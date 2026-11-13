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
  String get geri => 'Geri';

  @override
  String get tarifGoster => 'Sahne tarifi';

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
}
