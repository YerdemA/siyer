package com.yerdema.siyer

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import com.google.android.play.core.assetpacks.AssetPackManager
import com.google.android.play.core.assetpacks.AssetPackManagerFactory
import com.google.android.play.core.assetpacks.AssetPackState
import com.google.android.play.core.assetpacks.AssetPackStateUpdateListener
import com.google.android.play.core.assetpacks.model.AssetPackStatus
import com.google.android.play.core.assetpacks.model.AssetPackStorageMethod
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Bölüm paketleri (Play Asset Delivery, isteğe bağlı) için Dart köprüsü.
 * Dart tarafı: lib/icerik/paketler.dart.
 *
 * Her yanıt bir durum haritasıdır:
 * `{ad, durum: hazir|yok|iniyor|bekliyor|onay|hata, inen, toplam, yol?, hata?}`.
 * `yol`, paketin içindeki `<ad>/` klasörüdür; dosyalar oraya
 * `assets/icerik/` altındaki yollarıyla yerleşir.
 *
 * Uygulama Play'den gelmemişse (bundletool ile üretilmiş tek APK elle
 * kurulduysa) paket APK'nın içindedir; bir kez dosya sistemine kopyalanır.
 */
class BolumPaketleri(private val activity: Activity, messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private val context: Context = activity.applicationContext
    private val yonetici: AssetPackManager = AssetPackManagerFactory.getInstance(context)
    private val ana = Handler(Looper.getMainLooper())
    private var olaylar: EventChannel.EventSink? = null

    private val dinleyici = AssetPackStateUpdateListener { durum ->
        olaylar?.success(durumHaritasi(durum))
    }

    init {
        MethodChannel(messenger, "siyer/paketler").setMethodCallHandler(this)
        EventChannel(messenger, "siyer/paketler/olay").setStreamHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val ad = call.argument<String>("ad")
        if (ad == null || !ad.matches(Regex("[a-z][a-z0-9_]*"))) {
            result.error("ad", "Geçersiz paket adı: $ad", null)
            return
        }
        when (call.method) {
            "durum" -> durum(ad, result)
            "indir" -> indir(ad, result)
            "sil" -> sil(ad, result)
            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        olaylar = events
        yonetici.registerListener(dinleyici)
    }

    override fun onCancel(arguments: Any?) {
        yonetici.unregisterListener(dinleyici)
        olaylar = null
    }

    fun kapat() {
        yonetici.unregisterListener(dinleyici)
        olaylar = null
    }

    private fun durum(ad: String, result: MethodChannel.Result) {
        konum(ad)?.let { return result.success(hazir(ad, it)) }
        if (apkIcinde(ad)) return apktanCikar(ad, result)
        yonetici.getPackStates(listOf(ad))
            .addOnSuccessListener { durumlar ->
                val d = durumlar.packStates()[ad]
                result.success(if (d == null) yok(ad) else durumHaritasi(d))
            }
            .addOnFailureListener { result.success(hata(ad, it.message)) }
    }

    private fun indir(ad: String, result: MethodChannel.Result) {
        konum(ad)?.let { return result.success(hazir(ad, it)) }
        if (apkIcinde(ad)) return apktanCikar(ad, result)
        yonetici.fetch(listOf(ad))
            .addOnSuccessListener { durumlar ->
                val d = durumlar.packStates()[ad]
                if (d != null && (d.status() == AssetPackStatus.WAITING_FOR_WIFI ||
                        d.status() == AssetPackStatus.REQUIRES_USER_CONFIRMATION)) {
                    @Suppress("DEPRECATION")
                    yonetici.showConfirmationDialog(activity)
                }
                result.success(if (d == null) yok(ad) else durumHaritasi(d))
            }
            .addOnFailureListener { result.success(hata(ad, it.message)) }
    }

    private fun sil(ad: String, result: MethodChannel.Result) {
        File(context.filesDir, "paketler/$ad").deleteRecursively()
        yonetici.removePack(ad)
            .addOnSuccessListener { result.success(yok(ad)) }
            // Play'den gelmemiş pakette silinecek bir şey yoktur.
            .addOnFailureListener { result.success(yok(ad)) }
    }

    /** İnmiş paketin içindeki `<ad>/` klasörü; yoksa null. */
    private fun konum(ad: String): String? {
        val k = yonetici.getPackLocation(ad) ?: return null
        if (k.packStorageMethod() != AssetPackStorageMethod.STORAGE_FILES) return null
        val klasor = File(k.assetsPath() ?: return null, ad)
        return if (klasor.isDirectory) klasor.absolutePath else null
    }

    private fun apkIcinde(ad: String): Boolean =
        try {
            !context.assets.list(ad).isNullOrEmpty()
        } catch (_: Exception) {
            false
        }

    /** APK'daki paketi bir kez `files/paketler/<ad>/` altına çıkarır. */
    private fun apktanCikar(ad: String, result: MethodChannel.Result) {
        val hedef = File(context.filesDir, "paketler/$ad")
        val isaret = File(hedef, ".surum")
        val surum = context.packageManager.getPackageInfo(context.packageName, 0).lastUpdateTime.toString()
        if (isaret.isFile && isaret.readText() == surum) {
            return result.success(hazir(ad, File(hedef, ad).absolutePath))
        }
        Thread {
            val cevap = try {
                hedef.deleteRecursively()
                kopyala(ad, File(hedef, ad))
                isaret.writeText(surum)
                hazir(ad, File(hedef, ad).absolutePath)
            } catch (e: Exception) {
                hata(ad, e.message)
            }
            ana.post { result.success(cevap) }
        }.start()
    }

    private fun kopyala(yol: String, hedef: File) {
        val icerik = context.assets.list(yol).orEmpty()
        if (icerik.isEmpty()) {
            hedef.parentFile?.mkdirs()
            context.assets.open(yol).use { g -> hedef.outputStream().use { g.copyTo(it) } }
        } else {
            for (alt in icerik) kopyala("$yol/$alt", File(hedef, alt))
        }
    }

    private fun durumHaritasi(d: AssetPackState): Map<String, Any?> {
        val ad = d.name()
        val durum = when (d.status()) {
            AssetPackStatus.COMPLETED -> konum(ad)?.let { return hazir(ad, it) } ?: "hata"
            AssetPackStatus.PENDING, AssetPackStatus.DOWNLOADING, AssetPackStatus.TRANSFERRING -> "iniyor"
            AssetPackStatus.WAITING_FOR_WIFI -> "bekliyor"
            AssetPackStatus.REQUIRES_USER_CONFIRMATION -> "onay"
            AssetPackStatus.FAILED -> "hata"
            else -> "yok"
        }
        return mapOf(
            "ad" to ad,
            "durum" to durum,
            "inen" to d.bytesDownloaded(),
            "toplam" to d.totalBytesToDownload(),
            "hata" to if (d.errorCode() != 0) "kod ${d.errorCode()}" else null,
        )
    }

    private fun hazir(ad: String, yol: String) = mapOf("ad" to ad, "durum" to "hazir", "yol" to yol)
    private fun yok(ad: String) = mapOf("ad" to ad, "durum" to "yok")
    private fun hata(ad: String, mesaj: String?) = mapOf("ad" to ad, "durum" to "hata", "hata" to mesaj)
}
