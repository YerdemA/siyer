// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class MetinlerEn extends Metinler {
  MetinlerEn([String locale = 'en']) : super(locale);

  @override
  String get uygulamaAdi => 'The Life of the Prophet';

  @override
  String get bolumler => 'Episodes';

  @override
  String bolumNo(int no) {
    return 'Episode $no';
  }

  @override
  String get taslak => 'Draft';

  @override
  String get oynat => 'Play';

  @override
  String get duraklat => 'Pause';

  @override
  String get oncekiSahne => 'Previous scene';

  @override
  String get sonrakiSahne => 'Next scene';

  @override
  String get geri => 'Back';

  @override
  String get tarifGoster => 'Scene brief';

  @override
  String get altyazi => 'Subtitles';

  @override
  String sahneSayaci(int no, int toplam) {
    return 'Scene $no / $toplam';
  }

  @override
  String get sesYok =>
      'No narration audio yet; timing is estimated from the text.';

  @override
  String get yerTutucuUyari => 'Images are temporary placeholders.';

  @override
  String get bolumSonu => 'End of episode';

  @override
  String get kaynaklar => 'Sources';

  @override
  String get dogrulamaBekliyor => 'pending verification';

  @override
  String get yenidenOynat => 'Replay';

  @override
  String yuklemeHatasi(String hata) {
    return 'Could not load content: $hata';
  }

  @override
  String get bolumYok =>
      'No episodes yet. Run `dart run tools/icerik_esitle.dart` at the repository root to copy the content.';

  @override
  String get kamera => 'Camera';

  @override
  String get katmanlar => 'Layers';

  @override
  String get saat => 'Time of day';

  @override
  String get tamamlandi => 'Completed';

  @override
  String kaldiginYer(int no, int toplam) {
    return 'Scene $no / $toplam · continue where you left off';
  }
}
