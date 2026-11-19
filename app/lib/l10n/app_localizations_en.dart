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

  @override
  String get ayarlar => 'Settings';

  @override
  String get kaynakca => 'Bibliography';

  @override
  String kaynakKatmani(String katman) {
    return 'Source tier $katman';
  }

  @override
  String get sahislar => 'People';

  @override
  String get zamanCizelgesi => 'Timeline';

  @override
  String get kaynakBekliyor => 'Source pending';

  @override
  String get ilerlemeyiSifirla => 'Reset progress';

  @override
  String get ilerlemeSifirlaOnay =>
      'Progress in all episodes will be deleted. Are you sure?';

  @override
  String get iptal => 'Cancel';

  @override
  String get sifirla => 'Reset';

  @override
  String get hakkinda => 'About';

  @override
  String get hakkindaMetni =>
      'Free of charge. No accounts, no ads, no analytics; your progress is stored only on this device. Every historical statement in the app is tied to a source; sources are listed at the end of each episode and in the bibliography below.';

  @override
  String get bulunamadi => 'Entry not found.';

  @override
  String yil(int yil) {
    return '$yil';
  }

  @override
  String yilYaklasik(int yil) {
    return 'c. $yil';
  }

  @override
  String get bolumeGit => 'Go to episode';

  @override
  String get harita => 'Map';

  @override
  String get konumYaklasik =>
      'Locations are approximate; the map is not to scale.';

  @override
  String get haritaMekkeCevresi => 'Around Mecca';

  @override
  String get haritaKizildeniz => 'Red Sea';

  @override
  String get pusulaKuzey => 'N';

  @override
  String get sahisAra => 'Search people';

  @override
  String sahisKilitNotu(int sayi) {
    return '$sayi more people will appear here as you watch the episodes.';
  }

  @override
  String get sahisAramaBos => 'No one matches your search.';

  @override
  String get izlendi => 'Watched';

  @override
  String get yolAltBaslik => 'Before prophethood';

  @override
  String get haritaGec => 'Skip';

  @override
  String bolumEtiketi(int no) {
    return 'Episode $no';
  }

  @override
  String get yolBaslik => 'The Life of the Prophet';

  @override
  String get altyaziBoyutu => 'Subtitle size';

  @override
  String get boyutKucuk => 'Small';

  @override
  String get boyutOrta => 'Medium';

  @override
  String get boyutBuyuk => 'Large';

  @override
  String get efektSesleri => 'Sound effects';

  @override
  String get efektSesleriAciklama =>
      'Short sounds on episode cards and map transitions';

  @override
  String siradakiBolum(String baslik) {
    return 'Next episode: $baslik';
  }

  @override
  String get siradaki => 'Up next';

  @override
  String get ilkGorundugu => 'First appears in';

  @override
  String ilkGorunduguAyrinti(String bolum, int sahne) {
    return '$bolum, scene $sahne';
  }

  @override
  String get devamEt => 'Continue where you left off';
}
