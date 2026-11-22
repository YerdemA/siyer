import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Metinler
/// returned by `Metinler.of(context)`.
///
/// Applications need to include `Metinler.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Metinler.localizationsDelegates,
///   supportedLocales: Metinler.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Metinler.supportedLocales
/// property.
abstract class Metinler {
  Metinler(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Metinler of(BuildContext context) {
    return Localizations.of<Metinler>(context, Metinler)!;
  }

  static const LocalizationsDelegate<Metinler> delegate = _MetinlerDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @uygulamaAdi.
  ///
  /// In tr, this message translates to:
  /// **'Resulü Ekrem\'in Hayatı'**
  String get uygulamaAdi;

  /// No description provided for @bolumler.
  ///
  /// In tr, this message translates to:
  /// **'Bölümler'**
  String get bolumler;

  /// No description provided for @bolumNo.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm {no}'**
  String bolumNo(int no);

  /// No description provided for @taslak.
  ///
  /// In tr, this message translates to:
  /// **'Taslak'**
  String get taslak;

  /// No description provided for @oynat.
  ///
  /// In tr, this message translates to:
  /// **'Oynat'**
  String get oynat;

  /// No description provided for @duraklat.
  ///
  /// In tr, this message translates to:
  /// **'Duraklat'**
  String get duraklat;

  /// No description provided for @oncekiSahne.
  ///
  /// In tr, this message translates to:
  /// **'Önceki sahne'**
  String get oncekiSahne;

  /// No description provided for @sonrakiSahne.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki sahne'**
  String get sonrakiSahne;

  /// No description provided for @geri.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get geri;

  /// No description provided for @tarifGoster.
  ///
  /// In tr, this message translates to:
  /// **'Sahne tarifi'**
  String get tarifGoster;

  /// No description provided for @altyazi.
  ///
  /// In tr, this message translates to:
  /// **'Altyazı'**
  String get altyazi;

  /// No description provided for @sahneSayaci.
  ///
  /// In tr, this message translates to:
  /// **'Sahne {no} / {toplam}'**
  String sahneSayaci(int no, int toplam);

  /// No description provided for @sesYok.
  ///
  /// In tr, this message translates to:
  /// **'Anlatım sesi henüz yok; süre metinden tahmin ediliyor.'**
  String get sesYok;

  /// No description provided for @yerTutucuUyari.
  ///
  /// In tr, this message translates to:
  /// **'Görseller geçici yer tutucudur.'**
  String get yerTutucuUyari;

  /// No description provided for @bolumSonu.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm sonu'**
  String get bolumSonu;

  /// No description provided for @kaynaklar.
  ///
  /// In tr, this message translates to:
  /// **'Kaynaklar'**
  String get kaynaklar;

  /// No description provided for @dogrulamaBekliyor.
  ///
  /// In tr, this message translates to:
  /// **'doğrulama bekliyor'**
  String get dogrulamaBekliyor;

  /// No description provided for @yenidenOynat.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden oynat'**
  String get yenidenOynat;

  /// No description provided for @yuklemeHatasi.
  ///
  /// In tr, this message translates to:
  /// **'İçerik yüklenemedi: {hata}'**
  String yuklemeHatasi(String hata);

  /// No description provided for @bolumYok.
  ///
  /// In tr, this message translates to:
  /// **'Henüz bölüm yok. İçeriği kopyalamak için depo kökünde `dart run tools/icerik_esitle.dart` çalıştır.'**
  String get bolumYok;

  /// No description provided for @kamera.
  ///
  /// In tr, this message translates to:
  /// **'Kamera'**
  String get kamera;

  /// No description provided for @katmanlar.
  ///
  /// In tr, this message translates to:
  /// **'Katmanlar'**
  String get katmanlar;

  /// No description provided for @saat.
  ///
  /// In tr, this message translates to:
  /// **'Saat'**
  String get saat;

  /// No description provided for @tamamlandi.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlandı'**
  String get tamamlandi;

  /// No description provided for @kaldiginYer.
  ///
  /// In tr, this message translates to:
  /// **'Sahne {no} / {toplam} · kaldığın yerden devam'**
  String kaldiginYer(int no, int toplam);

  /// No description provided for @ayarlar.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get ayarlar;

  /// No description provided for @kaynakca.
  ///
  /// In tr, this message translates to:
  /// **'Kaynakça'**
  String get kaynakca;

  /// No description provided for @kaynakKatmani.
  ///
  /// In tr, this message translates to:
  /// **'Kaynak katmanı {katman}'**
  String kaynakKatmani(String katman);

  /// No description provided for @sahislar.
  ///
  /// In tr, this message translates to:
  /// **'Şahıslar'**
  String get sahislar;

  /// No description provided for @zamanCizelgesi.
  ///
  /// In tr, this message translates to:
  /// **'Zaman çizelgesi'**
  String get zamanCizelgesi;

  /// No description provided for @kaynakBekliyor.
  ///
  /// In tr, this message translates to:
  /// **'Kaynak bekliyor'**
  String get kaynakBekliyor;

  /// No description provided for @ilerlemeyiSifirla.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi sıfırla'**
  String get ilerlemeyiSifirla;

  /// No description provided for @ilerlemeSifirlaOnay.
  ///
  /// In tr, this message translates to:
  /// **'Bütün bölümlerdeki ilerleme silinecek. Emin misin?'**
  String get ilerlemeSifirlaOnay;

  /// No description provided for @iptal.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get iptal;

  /// No description provided for @sifirla.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırla'**
  String get sifirla;

  /// No description provided for @hakkinda.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get hakkinda;

  /// No description provided for @hakkindaMetni.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsizdir. Hesap, reklam ve analitik yoktur; ilerlemen yalnız bu cihazda saklanır. Uygulamadaki her tarihî bilgi kaynağına bağlıdır; kaynaklar bölüm sonlarında ve aşağıdaki kaynakçada listelenir.'**
  String get hakkindaMetni;

  /// No description provided for @bulunamadi.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt bulunamadı.'**
  String get bulunamadi;

  /// No description provided for @yil.
  ///
  /// In tr, this message translates to:
  /// **'{yil}'**
  String yil(int yil);

  /// No description provided for @yilYaklasik.
  ///
  /// In tr, this message translates to:
  /// **'yakl. {yil}'**
  String yilYaklasik(int yil);

  /// No description provided for @bolumeGit.
  ///
  /// In tr, this message translates to:
  /// **'Bölüme git'**
  String get bolumeGit;

  /// No description provided for @harita.
  ///
  /// In tr, this message translates to:
  /// **'Harita'**
  String get harita;

  /// No description provided for @konumYaklasik.
  ///
  /// In tr, this message translates to:
  /// **'Konum yaklaşıktır; harita ölçekli değildir.'**
  String get konumYaklasik;

  /// No description provided for @haritaMekkeCevresi.
  ///
  /// In tr, this message translates to:
  /// **'Mekke çevresi'**
  String get haritaMekkeCevresi;

  /// No description provided for @haritaKizildeniz.
  ///
  /// In tr, this message translates to:
  /// **'Kızıldeniz'**
  String get haritaKizildeniz;

  /// No description provided for @pusulaKuzey.
  ///
  /// In tr, this message translates to:
  /// **'K'**
  String get pusulaKuzey;

  /// No description provided for @sahisAra.
  ///
  /// In tr, this message translates to:
  /// **'Şahıs ara'**
  String get sahisAra;

  /// No description provided for @sahisKilitNotu.
  ///
  /// In tr, this message translates to:
  /// **'Bölümleri izledikçe {sayi} şahıs daha burada açılacak.'**
  String sahisKilitNotu(int sayi);

  /// No description provided for @sahisAramaBos.
  ///
  /// In tr, this message translates to:
  /// **'Aramaya uyan şahıs yok.'**
  String get sahisAramaBos;

  /// No description provided for @izlendi.
  ///
  /// In tr, this message translates to:
  /// **'İzlendi'**
  String get izlendi;

  /// No description provided for @yolAltBaslik.
  ///
  /// In tr, this message translates to:
  /// **'Peygamberlik öncesi'**
  String get yolAltBaslik;

  /// No description provided for @haritaGec.
  ///
  /// In tr, this message translates to:
  /// **'Geç'**
  String get haritaGec;

  /// No description provided for @bolumEtiketi.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm {no}'**
  String bolumEtiketi(int no);

  /// No description provided for @yolBaslik.
  ///
  /// In tr, this message translates to:
  /// **'Resulü Ekrem\'in Hayatı'**
  String get yolBaslik;

  /// No description provided for @altyaziBoyutu.
  ///
  /// In tr, this message translates to:
  /// **'Altyazı boyutu'**
  String get altyaziBoyutu;

  /// No description provided for @altyaziAciklama.
  ///
  /// In tr, this message translates to:
  /// **'Anlatım sesli sahnelerde metni de göster. Sesi olmayan sahnelerde metin her zaman görünür.'**
  String get altyaziAciklama;

  /// No description provided for @boyutKucuk.
  ///
  /// In tr, this message translates to:
  /// **'Küçük'**
  String get boyutKucuk;

  /// No description provided for @boyutOrta.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get boyutOrta;

  /// No description provided for @boyutBuyuk.
  ///
  /// In tr, this message translates to:
  /// **'Büyük'**
  String get boyutBuyuk;

  /// No description provided for @efektSesleri.
  ///
  /// In tr, this message translates to:
  /// **'Efekt sesleri'**
  String get efektSesleri;

  /// No description provided for @efektSesleriAciklama.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm kartı ve harita geçişinde kısa sesler'**
  String get efektSesleriAciklama;

  /// No description provided for @siradakiBolum.
  ///
  /// In tr, this message translates to:
  /// **'Sıradaki bölüm: {baslik}'**
  String siradakiBolum(String baslik);

  /// No description provided for @siradaki.
  ///
  /// In tr, this message translates to:
  /// **'Sıradaki'**
  String get siradaki;

  /// No description provided for @ilkGorundugu.
  ///
  /// In tr, this message translates to:
  /// **'İlk göründüğü yer'**
  String get ilkGorundugu;

  /// No description provided for @ilkGorunduguAyrinti.
  ///
  /// In tr, this message translates to:
  /// **'{bolum}, {sahne}. sahne'**
  String ilkGorunduguAyrinti(String bolum, int sahne);

  /// No description provided for @devamEt.
  ///
  /// In tr, this message translates to:
  /// **'Kaldığın yerden devam et'**
  String get devamEt;

  /// No description provided for @hareketiAzalt.
  ///
  /// In tr, this message translates to:
  /// **'Hareketi azalt'**
  String get hareketiAzalt;

  /// No description provided for @hareketiAzaltAciklama.
  ///
  /// In tr, this message translates to:
  /// **'Kart ve harita animasyonları kısalır'**
  String get hareketiAzaltAciklama;

  /// No description provided for @indiriliyor.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm indiriliyor'**
  String get indiriliyor;

  /// No description provided for @indirmeIlerleme.
  ///
  /// In tr, this message translates to:
  /// **'{inen} / {toplam} MB'**
  String indirmeIlerleme(String inen, String toplam);

  /// No description provided for @indirmeBoyutu.
  ///
  /// In tr, this message translates to:
  /// **'{boyut} MB'**
  String indirmeBoyutu(String boyut);

  /// No description provided for @indirmeBekliyor.
  ///
  /// In tr, this message translates to:
  /// **'İndirme Wi-Fi ya da onay bekliyor'**
  String get indirmeBekliyor;

  /// No description provided for @indirmeHatasi.
  ///
  /// In tr, this message translates to:
  /// **'Bölüm indirilemedi. İnternet bağlantını denetleyip tekrar dene.'**
  String get indirmeHatasi;

  /// No description provided for @tekrarDene.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get tekrarDene;

  /// No description provided for @indir.
  ///
  /// In tr, this message translates to:
  /// **'İndir'**
  String get indir;

  /// No description provided for @indirilmedi.
  ///
  /// In tr, this message translates to:
  /// **'İndirilmedi'**
  String get indirilmedi;

  /// No description provided for @indirilenBolumler.
  ///
  /// In tr, this message translates to:
  /// **'İndirilen bölümler'**
  String get indirilenBolumler;

  /// No description provided for @indirilenBolumlerAciklama.
  ///
  /// In tr, this message translates to:
  /// **'İlk bölüm uygulamayla gelir; diğerleri açılınca indirilir ve internetsiz de izlenir.'**
  String get indirilenBolumlerAciklama;

  /// No description provided for @indirilenYok.
  ///
  /// In tr, this message translates to:
  /// **'Henüz indirilen bölüm yok.'**
  String get indirilenYok;

  /// No description provided for @sil.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get sil;

  /// No description provided for @uygulamaylaGelir.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamayla gelir'**
  String get uygulamaylaGelir;
}

class _MetinlerDelegate extends LocalizationsDelegate<Metinler> {
  const _MetinlerDelegate();

  @override
  Future<Metinler> load(Locale locale) {
    return SynchronousFuture<Metinler>(lookupMetinler(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_MetinlerDelegate old) => false;
}

Metinler lookupMetinler(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return MetinlerEn();
    case 'tr':
      return MetinlerTr();
  }

  throw FlutterError(
    'Metinler.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
