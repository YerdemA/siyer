package com.yerdema.siyer

import android.content.Context
import android.os.PowerManager
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var paketler: BolumPaketleri? = null
    private var uyanik: PowerManager.WakeLock? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        paketler = BolumPaketleri(this, flutterEngine.dartExecutor.binaryMessenger)
        // Oynatıcının ekranla ilgili istekleri (lib/oynatici/ekran.dart).
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "siyer/ekran").setMethodCallHandler { cagri, sonuc ->
            when (cagri.method) {
                "ekranAcik" -> sonuc.success((getSystemService(Context.POWER_SERVICE) as PowerManager).isInteractive)
                "acikTut" -> {
                    if (cagri.arguments == true) {
                        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                    } else {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                    }
                    sonuc.success(null)
                }
                "uyanikTut" -> {
                    uyanikTut(cagri.arguments == true)
                    sonuc.success(null)
                }
                else -> sonuc.notImplemented()
            }
        }
    }

    /// Ekran kapalıyken bölüm sürerken sahne aralarındaki sessizlikte işlemci
    /// uyumasın; saat ilerlemezse sonraki sahnenin sesi hiç başlamaz.
    private fun uyanikTut(acik: Boolean) {
        if (acik) {
            if (uyanik?.isHeld == true) return
            uyanik = (getSystemService(Context.POWER_SERVICE) as PowerManager)
                .newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "siyer:bolum")
                .apply { acquire(30 * 60 * 1000L) } // en uzun bölümden çok uzun; unutulursa kendi bırakılır
        } else {
            uyanik?.takeIf { it.isHeld }?.release()
            uyanik = null
        }
    }

    override fun onDestroy() {
        uyanikTut(false)
        paketler?.kapat()
        paketler = null
        super.onDestroy()
    }
}
