// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class MetinlerTr extends Metinler {
  MetinlerTr([String locale = 'tr']) : super(locale);

  @override
  String get uygulamaAdi => 'Resulü Ekrem\'in Hayatı';

  @override
  String get bolumler => 'Bölümler';

  @override
  String bolumNo(int no) {
    return 'Bölüm $no';
  }

  @override
  String get taslak => 'Taslak';

  @override
  String get oynat => 'Oynat';

  @override
  String get duraklat => 'Duraklat';

  @override
  String get oncekiSahne => 'Önceki sahne';

  @override
  String get sonrakiSahne => 'Sonraki sahne';

  @override
  String kartSahne(int no, int toplam) {
    return 'Sahne $no/$toplam';
  }

  @override
  String get kartKanali => 'Bölüm oynatma';

  @override
  String get geri => 'Geri';

  @override
  String get tarifGoster => 'Sahne tarifi';

  @override
  String get oynatmaHizi => 'Oynatma hızı';

  @override
  String saniyeIleri(int sn) {
    return '$sn saniye ileri';
  }

  @override
  String saniyeGeri(int sn) {
    return '$sn saniye geri';
  }

  @override
  String saniyeKisa(int sn) {
    return '$sn sn';
  }

  @override
  String get altyazi => 'Altyazı';

  @override
  String sahneSayaci(int no, int toplam) {
    return 'Sahne $no / $toplam';
  }

  @override
  String get sesYok => 'Anlatım sesi henüz yok; süre metinden tahmin ediliyor.';

  @override
  String get yerTutucuUyari => 'Görseller geçici yer tutucudur.';

  @override
  String get bolumSonu => 'Bölüm sonu';

  @override
  String get kaynaklar => 'Kaynaklar';

  @override
  String get dogrulamaBekliyor => 'doğrulama bekliyor';

  @override
  String get yenidenOynat => 'Yeniden oynat';

  @override
  String yuklemeHatasi(String hata) {
    return 'İçerik yüklenemedi: $hata';
  }

  @override
  String get bolumYok =>
      'Henüz bölüm yok. İçeriği kopyalamak için depo kökünde `dart run tools/icerik_esitle.dart` çalıştır.';

  @override
  String get kamera => 'Kamera';

  @override
  String get katmanlar => 'Katmanlar';

  @override
  String get saat => 'Saat';

  @override
  String get tamamlandi => 'Tamamlandı';

  @override
  String kaldiginYer(int no, int toplam) {
    return 'Sahne $no / $toplam · kaldığın yerden devam';
  }

  @override
  String get ayarlar => 'Ayarlar';

  @override
  String get kaynakca => 'Kaynakça';

  @override
  String kaynakKatmani(String katman) {
    return 'Kaynak katmanı $katman';
  }

  @override
  String get sahislar => 'Şahıslar';

  @override
  String get zamanCizelgesi => 'Zaman çizelgesi';

  @override
  String get kaynakBekliyor => 'Kaynak bekliyor';

  @override
  String get ilerlemeyiSifirla => 'İlerlemeyi sıfırla';

  @override
  String get ilerlemeSifirlaOnay =>
      'Bütün bölümlerdeki ilerleme silinecek. Emin misin?';

  @override
  String get iptal => 'İptal';

  @override
  String get sifirla => 'Sıfırla';

  @override
  String get hakkinda => 'Hakkında';

  @override
  String get hakkindaMetni =>
      'Ücretsizdir. Hesap, reklam ve analitik yoktur; ilerlemen yalnız bu cihazda saklanır. Uygulamadaki her tarihî bilgi kaynağına bağlıdır; kaynaklar bölüm sonlarında ve aşağıdaki kaynakçada listelenir.';

  @override
  String get bulunamadi => 'Kayıt bulunamadı.';

  @override
  String yil(int yil) {
    return '$yil';
  }

  @override
  String yilYaklasik(int yil) {
    return 'yakl. $yil';
  }

  @override
  String get bolumeGit => 'Bölüme git';

  @override
  String get harita => 'Harita';

  @override
  String get konumYaklasik => 'Konum yaklaşıktır; harita ölçekli değildir.';

  @override
  String get haritaMekkeCevresi => 'Mekke çevresi';

  @override
  String get haritaKizildeniz => 'Kızıldeniz';

  @override
  String get pusulaKuzey => 'K';

  @override
  String get sahisAra => 'Şahıs ara';

  @override
  String sahisKilitNotu(int sayi) {
    return 'Bölümleri izledikçe $sayi şahıs daha burada açılacak.';
  }

  @override
  String get sahisAramaBos => 'Aramaya uyan şahıs yok.';

  @override
  String get izlendi => 'İzlendi';

  @override
  String get yolAltBaslik => 'Peygamberlik öncesi';

  @override
  String get haritaGec => 'Geç';

  @override
  String bolumEtiketi(int no) {
    return 'Bölüm $no';
  }

  @override
  String get yolBaslik => 'Resulü Ekrem\'in Hayatı';

  @override
  String get altyaziBoyutu => 'Altyazı boyutu';

  @override
  String get altyaziAciklama =>
      'Anlatım sesli sahnelerde metni de göster. Sesi olmayan sahnelerde metin her zaman görünür.';

  @override
  String get boyutKucuk => 'Küçük';

  @override
  String get boyutOrta => 'Orta';

  @override
  String get boyutBuyuk => 'Büyük';

  @override
  String get efektSesleri => 'Efekt sesleri';

  @override
  String get efektSesleriAciklama =>
      'Bölüm kartı ve harita geçişinde kısa sesler';

  @override
  String siradakiBolum(String baslik) {
    return 'Sıradaki bölüm: $baslik';
  }

  @override
  String get siradaki => 'Sıradaki';

  @override
  String get ilkGorundugu => 'İlk göründüğü yer';

  @override
  String ilkGorunduguAyrinti(String bolum, int sahne) {
    return '$bolum, $sahne. sahne';
  }

  @override
  String get devamEt => 'Kaldığın yerden devam et';

  @override
  String get hareketiAzalt => 'Hareketi azalt';

  @override
  String get hareketiAzaltAciklama => 'Kart ve harita animasyonları kısalır';

  @override
  String get indiriliyor => 'Bölüm indiriliyor';

  @override
  String indirmeIlerleme(String inen, String toplam) {
    return '$inen / $toplam MB';
  }

  @override
  String indirmeBoyutu(String boyut) {
    return '$boyut MB';
  }

  @override
  String get indirmeBekliyor => 'İndirme Wi-Fi ya da onay bekliyor';

  @override
  String get indirmeHatasi =>
      'Bölüm indirilemedi. İnternet bağlantını denetleyip tekrar dene.';

  @override
  String get tekrarDene => 'Tekrar dene';

  @override
  String get indir => 'İndir';

  @override
  String get indirilmedi => 'İndirilmedi';

  @override
  String get indirilenBolumler => 'İndirilen bölümler';

  @override
  String get indirilenBolumlerAciklama =>
      'İlk bölüm uygulamayla gelir; diğerleri açılınca indirilir ve internetsiz de izlenir.';

  @override
  String get indirilenYok => 'Henüz indirilen bölüm yok.';

  @override
  String get sil => 'Sil';

  @override
  String get uygulamaylaGelir => 'Uygulamayla gelir';

  @override
  String get hataBildir => 'Hata bildir';

  @override
  String get hataBildirAciklama =>
      'Yanlış bilgi, görsel ya da ses sorunu gördüysen e-postayla bildir.';

  @override
  String get hataBildirKonu => 'Resulü Ekrem\'in Hayatı: hata bildirimi';

  @override
  String hataBildirGovde(String bilgi) {
    return 'Ne gördün? (yanlış bilgi, görsel, ses, uygulama hatası)\n\n\n---\nBu satırları silme, sorunu bulmamıza yardım eder:\n$bilgi';
  }

  @override
  String hataBildirAcilamadi(String adres) {
    return 'E-posta uygulaması açılamadı. Bildirimini $adres adresine gönderebilirsin.';
  }

  @override
  String get yakindaUst => 'Sıradaki dönem';

  @override
  String get yakindaBaslik => 'Peygamberlik Dönemi';

  @override
  String get yakindaAlt => 'Yakında';

  @override
  String get fonSesi => 'Müzik ve ortam sesi';

  @override
  String get fonSesiAciklama =>
      'Bölümlerde anlatımın altında kısık fon müziği ve rüzgâr, kalabalık gibi sesler.';

  @override
  String get altyaziDili => 'Altyazı dili';

  @override
  String get uygulamaDili => 'Uygulama dili';
}
