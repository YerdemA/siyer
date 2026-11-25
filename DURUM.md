# Proje Durumu

**Claude Code: oturuma başlarken ilk bu dosyayı oku.** Son yapılanlar ve sıradaki adımlar burada. Genel plan `YOL_HARITASI.md`'de, kurallar `CLAUDE.md`'de. Oturum sonunda bu dosyayı güncelle.

Son güncelleme: 2026-11-25.

## Sıradaki adımlar (öncelik sırasıyla)

**Test APK'sı v10 (2026-11-25): `İndirilenler\siyer\siyer-test-v10.apk` (145 MB), Erdem telefonda deneyecek.** v9'dan sonraki her şey içinde: hata bildir, Yakında kartı, fon sesi altyapısı (ses dosyası yok, sessiz), uygulama dili ve İngilizce altyazı (10 bölüm + yan veriler), oynatıcıda TR/EN, Pickthall atıfları, b04-s01 kafile; `REVIZE=true` ile derlendi (sahne tarifi paneli görünür). Kilit kartı simgeleri APK'da doğrulandı. Derleme yolu: `flutter clean` → `flutter build appbundle --release --android-project-arg=kapaliTest=true --android-project-arg=paketTeslimi=install-time --dart-define=REVIZE=true` → bundletool (Android Studio Java'sı) `build-apks --mode=universal` yükleme anahtarıyla. Not: kapalı test denetimi eksik fon seslerini artık uyarı sayıyor (yayında hata).

**Kaldığımız yer (2026-11-25, dördüncü oturum): Yakında kartı ve fon sesi altyapısı.**
- **Ana sayfada "Peygamberlik Dönemi · Yakında" kartı** (Erdem istedi): 10. bölümden sonra yol soluklaşarak kesik çizgili, soluk kâğıt bir karta varır; "Sıradaki dönem", başlık, altın çizgiler arasında kum saati, "Yakında". `YakindaKarti` (`bolum_yolu.dart`). Gerçek yazı tipleriyle test görüntüsü `İndirilenler\siyer\_onizleme-yakinda.png`; telefonda denenmedi.
- **Fon müziği ve ortam sesi altyapısı yapıldı** (`lib/oynatici/fon_sesi.dart`, `docs/SES_TASARIMI.md`): iki kanal, döngü, sahne değişince 1,8 sn yumuşak geçiş, aynı ad kesintisiz, duraklayınca susar; Ayarlar'da "Müzik ve ortam sesi". Dosyalar `content/fon/muzik|ortam/<ad>.mp3` → uygulamaya gömülür. İçerik adları 11 müzik + 13 ortama indirildi. **Ses dosyası yok**; doğrulama eksikleri uyarı olarak listeler (yayında hata). Testler 107/107.
- **ElevenLabs kredisi bitmek üzere:** Starter, 39.331'in 39.107'si kullanılmış, yenilenme ~2026-12-21. Üretim yenilenmeden sonra ya da plan yükseltilince; önce planın müzik için ticari kullanım koşuluna bakılacak. İstemler `docs/SES_TASARIMI.md`'de, her parça tek tek üretilip Erdem'e dinletilecek.
- Anlatıcı: Seyfullah Kartal (Erdem doğruladı).
- **İngilizce âyet meali: Pickthall 1930** (Erdem: telifsiz güvenli meal varsa izinle uğraşmayalım; Diyanet'in İngilizcesi telifli görünüyor). Tarama PDF'i ve 6 atıflı âyetin metni + basılı sayfaları `kaynaklar/kuran/kuran-meal-pickthall.md` (İbrâhîm 14/37 Wikisource'ta yok, taramadan; Kureyş Pickthall'da 5 âyet). `docs/KAYNAKLAR.md` A listesine eklendi. İngilizce içerikte kaynakçaya `kuran-meal-pickthall` girdisi açılacak.
- **Âyet uyarlaması onaylandı** (Erdem, 2026-11-25): Pickthall yalnız eski biçimlerden arındırılır (thee→you, hath→has, Lo!→Indeed…), kelime ve yapı aynı; kurallar `docs/KAYNAK_POLITIKASI.md`, uyarlanmış metinler `kaynaklar/kuran/kuran-meal-pickthall.md`.
- **İngilizce altyazı altyapısı yapıldı:** Ayarlar → "Altyazı dili" (Türkçe/English); çeviri `content/en/altyazi/<bölüm>.json` (şema `docs/ICERIK_SEMASI.md` → Altyazı çevirileri). Erdem üslubu onayladı; **10 bölümün hepsi çevrildi** (4.358 kelime; âyetler uyarlanmış Pickthall: b01-s01/s02/s04/s11, b02-s14, b03-s09). Telefonda denenmedi; İngilizce bilen bir okuyucu bakmalı (uzman okumasıyla).
- **Uygulama dili ayarı** (Erdem istedi): Ayarlar → "Uygulama dili" Türkçe/English; arayüz metinleri ve bölüm adı/özeti (çeviriden) değişir. Şahıslar (50), yerler (11), zaman çizelgesi (10) ve kaynakça notları da çevrildi (`content/en/*.json`, kimliğe göre üstüne yazılır). Uygulama dili değişince altyazı dili de geçer; oynatıcının alt çubuğunda TR/EN düğmesi (yalnız altyazı; kapalıysa altyazıyı da açar). Testler 110/110. **Sahne tarifi paneli herkese açık sürümde gizli** (Erdem onayladı): yalnız debug ve `--dart-define=REVIZE=true` derlemelerinde (`revizeAraclari`). **Revize için test APK'sı derlerken bu bayrak eklenmeli:** `flutter build appbundle --release --android-project-arg=kapaliTest=true --android-project-arg=paketTeslimi=install-time --dart-define=REVIZE=true`. Tarifler çevrilmedi (gerek kalmadı).
- **Pickthall atıfları eklendi:** kaynakçada `kuran-meal-pickthall` (dil `en`, katman A); 6 âyet iddiasına (i-b01-001/002/004/017, i-b02-015, i-b03-011) Diyanet'in yanına Pickthall atfı (`XIV:37 (p. 259)` biçimi, `bekliyor`; Erdem taramada görecek). Bölüm sonu listesinde İngilizce eser atfı yalnız altyazı İngilizceyken görünür. Bekleyen atıf 582 → 588. Testler 112/112.
- Fon sesi kredi hesabı: belgelenen süreler ~31.800 kredi, kısa süreler (müzik 60 sn, ortam 15 sn) ~17.700; öneri kısa (`docs/SES_TASARIMI.md`).

**Önceki (2026-11-25, üçüncü oturum): Erdem'in v9 notları işlendi, kararlar alındı.**
- Telefonda onaylananlar: kilit kartı (düğmeler var), b09-s09, b09-s07, b04-s07 göz dizisi, anlatıcı sesi, Xiaomi'de ekran kapalıyken durma görülmedi. b04-s01 kafile büyütüldü (`x .25, y .687, olcek .36`; ayak çizgisi aynı, Kâbe'yle çakışmıyor).
- **Hata bildir yapıldı:** oynatıcı üst çubuğunda bayrak düğmesi (anlatımı durdurur) ve Ayarlar'da satır → e-posta uygulaması; konu hazır, gövdede sürüm, dil, bölüm, sahne, bölüm zamanı. Adres gizlilik sayfasındakiyle aynı. `lib/hata_bildir.dart`; `uygulamaSurumu` sabiti `pubspec.yaml` sürümüyle aynı olmalı (test denetler; **sürüm `+2` yapılınca ikisi birlikte**). Manifestte `mailto` sorgusu. Testler 105/105. Telefonda denenmedi.
- **Erdem'in kararları (2026-11-25):** müzik ve ortam sesi MVP'de (çalgılı, sade, Ayarlar'da kapatılabilir; ElevenLabs'te üretim, her parçayı Erdem onaylar, toplu üretimden önce sor); İngilizce **altyazı** MVP'de (anlatım Türkçe); güncellemesiz yeni bölüm altyapısı MVP sonrası, GitHub Releases (`docs/UZAK_BOLUM.md`); tablet testi ve zorunlu işler (582 atıf, kapalı test, kaynakça) en sona.
- **Sıradaki iş önerisi:** (1) müzik/ortam: oynatıcıda çalma kodu (yer tutucu sessiz dosyalarla), içerikteki adları ~10 müzik + ~12 ortama indirgeme, ElevenLabs istem listesi → Erdem onayı → üretim; (2) İngilizce altyazı: `content/en/bolumler` anlatım metinleri (kendi cümlelerimizle çeviri; âyetler için İngilizce meal seçimi Erdem'e sorulacak), oynatıcıda altyazı dili ayarı; (3) uzak katalog altyapısı (`archive`/`crypto` paket onayı gerekir).

**Önceki (2026-11-25, ikinci oturum): v9 test APK'sı; Erdem denedi: kilit kartı tamam (düğmeler var), b09-s09 kabul edilebilir.**
- `İndirilenler\siyer\siyer-kilit-karti-test-v9.apk` (145 MB, v8 ile aynı yoldan; bundletool Android Studio'nun Java'sıyla çalışır: `"C:\Program Files\Android\Android Studio\jbr\bin\java.exe" -jar ~/siyer-araclar/bundletool.jar`, sistemdeki Java 8 yetmez).
- **Kilit kartında düğme yoktu (Erdem, v8):** başlık, sahne ve süre çubuğu vardı; durdur/oynat, önceki/sonraki yoktu. Neden: `audio_service` simgeleri adla aranıyor (`getIdentifier`), yayın derlemesindeki kaynak küçültme onları siliyordu (v8'in `resources.arsc`'ında `audio_service_*` yok). `app/android/app/src/main/res/raw/keep.xml` eklendi; v9'da simgeler var. **Telefonda denenecek.**
- **Erdem'in üç sahne notu düzeltildi:** b02-s03 Kinâneli yolcunun başı/ayağı kesikti: ham görsel tamdı, katman `--sigdir` yerine kırpılarak işlenmişti → yeniden işlendi (`x .35, y .5, olcek .5`). Diğer `sigdir` katmanları tarandı, başka kesik yok. b02-s14 eşyalar ufuk çizgisindeydi → `bos-col` `ayar.gorsel {.5, .74, .9}`, kumda. b09-s09 yarım duvar ön plandaydı, kap duvarın önünde asılıydı → duvar halkanın arkasında (`.5, .56, .32`), kap halkanın ortasında yerde (`.5, .745, .1`); halkanın kendisi yukarıdan bakış açısıyla çizilmiş, hâlâ tuhaf gelirse görselin yeniden üretimi gerekir.
- **d2 görselleri (9) kabul ve yerleştirildi** (plan aşağıda, uygulandığı gibi). Farklar: b10-s07'de oynatıcı `parca 0, an 0` çekimini atladığı için Beldah ana görüntü oldu (kamera `bakis-acisi-yuruyus`), sofra bileşimi p0 an .5'e çekim oldu (eski tarifiyle), dikili taşlar p1 an .36, bileşime dönüş an .68. b06-s11 sorgu çekimi `sabit` kamera, `y .53` (yüz üstten kesiliyordu). b10-s06 Zeyd yakın planı kadraj `{.62, .4, 1.5}`. Görseller `arsiv\<bölüm>\`, `yeni\` boş. Doğrulama 0 hata, testler 103/103.
- Önizleme: oynatıcının yerleşim hesabını Python'a kopyalayan pafta betiği oturum klasöründeydi (kalıcı değil); gerekirse `sahne_cizici.dart`'tan yeniden yazılır.

**Önceki (2026-11-25): test APK'sı derlendi, Erdem telefonda deneyecek.**
- `İndirilenler\siyer\siyer-kilit-karti-test-v8.apk` (143 MB): özgün ses (135 MP3), bütün d1 görselleri ve b04-s07 göz dizisi, kilit ekranı kartı; bütün bölümler içinde. Yapılış: `flutter clean` → `flutter build appbundle --release --android-project-arg=kapaliTest=true --android-project-arg=paketTeslimi=install-time` → bundletool `build-apks --mode=universal` yükleme anahtarıyla. Normal `flutter build apk --release` yayın denetimine takılır (doğrulanmamış atıflar), bu yüzden bu yol. Sürüm kodu hâlâ `+1`; Play'den kurulu sürümün üstüne kurulmaz (Play imzası farklı), önce o kaldırılmalı (ilerleme silinir).
- **Telefonda bakılacaklar:** (1) anlatıcı sesi artık Seyfullah Kartal'ın sesi gibi mi; (2) b04-s07 göz dizisi ve yansımalardaki nur; (3) d1 görsellerinin yerleşimi ve uzun kalan çekimler; (4) kilit ekranı kartı: kart görünüyor mu, kapak resmi, ekran kapalıyken karttan devam (Android 12+), sonraki/önceki sahne, ilerleme çubuğunu sürükleme, duraklamışken kartı kaydırınca durma ve ilerlemenin kaydı, kulaklık tuşu ve çıkarma, arama gelince durup bitince sürme; (5) Xiaomi'de ekran kapalıyken uzun dinlemede sistem durduruyor mu.
- **Sonraki oturum:** Erdem'in telefon notları → d2 görselleri gelince yerleşim (plan aşağıda) → Play için AAB (`pubspec.yaml` `1.0.0+2`, on-demand paketli, obfuscate; Play Console'da ön plan servisi beyanı "medya oynatma").

**Kaldığımız yer (2026-11-25): bütün d1 görselleri sahnelerde.** `tools/d1_yerlestir.py <bölüm> [--yaz]` istem kaydındaki hedef parçaya çekim olarak koyar: hedef parçadaki yalnız kadraj olan ortak çekimi kaldırır, aynı parçadakileri `an` ile sıralar (metin bölünmedi), boş bırakılan yerlere nur (`NUR`), anlatım sırasına göre düzeltmeler (`YENIDEN`, `TASI`, `PARCA`, `AN`) ve oynatıcıyla aynı zamanlama denetimi. Bölüm bölüm oynatıcının çizim koduyla pafta kontrolü yapıldı (her çekimin bir karesi), sıra hataları düzeltildi (b02-s12 fil, b03-s12 kapı→dua, b04-s09 tavaf, b05-s02, b06-s05 nurlu yamaç, b07-s01/s04, b09-s14, b10-s03/s05/s06). `yeni\` boş; görseller `arsiv\<bölüm>\`. Doğrulama 0 hata. Telefonda/gerçek oynatıcıda denenmedi. **Yeni AAB gerekiyor** (özgün ses + görseller; sürüm kodu `+2`).
- **Kilit ekranı / bildirim kartı yapıldı (2026-11-25, Erdem `audio_service`'i onayladı).** `lib/oynatici/medya_karti.dart`: bölüm açıkken sistem medya oturumu. Kart: bölüm adı, "Sahne 7/10", sahnenin ilk çekimi kapak (oynatıcının çizimiyle 512×288 PNG, geçici klasör), durdur/devam, önceki/sonraki sahne, sürüklenebilir ilerleme çubuğu. Kartı kapatınca (duraklamışken kaydırınca) oynatma durur, ilerleme hemen kaydedilir. Kulaklık/Bluetooth tuşları; kulaklık çıkınca durur; arama/başka ses gelince durur, geçici kesinti bitince sürer (`audio_session`; just_audio'nun kendi kesinti yönetimi kapatıldı, saat sesi yeniden başlatmasın diye). Oynarken ön plan servisi (Xiaomi'de öldürülmeme). Görünmezken karttan sürdürülürse saati zamanlayıcı ilerletir. `MainActivity` artık `AudioServiceActivity`; manifestte `FOREGROUND_SERVICE(_MEDIA_PLAYBACK)`, servis ve medya tuşu alıcısı. Bildirim izni istenmez (medya oturumu bildirimi muaf). Testler 103/103, debug APK derlendi. **Telefonda denenmedi** (telefon bağlı değildi). **Play Console:** yeni AAB yüklenirken ön plan servisi beyanı "medya oynatma" istenecek (kısa video gerekebilir). Denenecek: kilit ekranında kart, karttan sürdürme ekran kapalıyken (Android 12+ ön plan servisi kısıtı), kart kaydırma, kulaklık çıkarma, arama gelmesi.
- **d2 istemleri (2026-11-25): hâlâ uzun kalan çekimler için 9 görsel**, `tools/dinamik_istemler.py` → `D2`; mesajlar `istemler/b03-d2-chatgpt.md` (2), `b06-d2` (2), `b07-d2` (2), `b10-d2` (3), her biri yeni sohbet + Mesaj 0. Yerleşim planı (görseller gelince `d1_yerlestir.py`):
  - b03-s01 p1 (16,7 sn kabileler): `kureys-kabe` an≈.35 ("Kureyş'i seçti"), `hasim-mahalle` an≈.7 ("Hâşimoğulları'ndan beni").
  - b06-s11: `kureys-bakisma` p1 başı (cevaba şaşıran Ebû Tâlib ve Kureyşliler); p2: `bahira-sorgu` başta, `bahira-yakin` an≈.65 (mühür).
  - b07-s04 p1 (15,2 sn kervan bileşimi): `urve-kervan` p1 başı, bileşim (Berrâd) an≈.45, `sahipsiz-kervan` an≈.8 (öldürme ve ölü çizilmez).
  - b10-s06 p2 (17,6 sn): bileşim başta, Zeyd'e kadraj yaklaşması an≈.35 (yeni görsel gerekmez), `kureys-dinler` an≈.65. Esmâ çizilmedi.
  - b10-s07 (22,3 sn): `beldah` p0 başı (onun gözünden, uzakta Zeyd), bileşim an≈.5; p1: `dikili-taslar` an≈.4 ("putlarınızın taşları"), sonra bileşime dönüş. Sofrada ret jesti yok (b10 notu: kimin yemediği rivayetlerde farklı).

**Kaldığımız yer (2026-11-24): ses özgün hâline döndü, d1 görselleri denetlendi.**
- **Anlatım sesi** (Erdem: kapalı testte ses Seyfullah Kartal'a benzemiyordu): 135 dosyanın hepsi ElevenLabs'ten gelen özgün MP3 (44,1 kHz 128 kbps) oldu; sıkıştırıcı, loudnorm ve 48k AAC kaldırıldı, `tools/ses_dengele.py` silindi. b01–b04 git geçmişinden (`b0bb6e6`), b05–b10 ElevenLabs akışından (`w7W5ESD14axY7ULG05AG`) alındı; her dosyanın süresi eski sürümle eşleşti. **Bundan sonra sese hiçbir işlem yok** (`ICERIK_SEMASI.md`). Ses 16 → 42 MB; b01 gömülü (13 dosya). Testler 90/90, doğrulama 0 hata. **Yeni AAB derlenmedi** (sürüm kodu `+2` olmalı); telefonda dinlenmedi.
- **d1 görselleri** (`İndirilenler\siyer\yeni\`, 76 görsel): **66 kabul**, 10 red. Reddedilenler `arsiv\<bölüm>\<kimlik>-red.png`; düzeltilmiş istemler `istemler/bXX-d1-yeniden-chatgpt.md` (her biri yeni sohbet, Mesaj 0 ile başlar):
  - `b01-d-putlar`: içerideki Hübel dışarıda duruyordu, bir put Kâbe'den yüksekti.
  - `b03-d-kura-oklari`: alttaki el bedene bağlı değildi. `b03-d-kabe-ic-dua`: Abdülmuttalib Hübel'e dönük, puta dua ediyor gibi; yeni istemde putlar kameranın arkasında, yüzü göğe.
  - **Kalp sahnesi yeniden tasarlandı (Erdem'in akışı, 2026-11-24):** yamaç → `b04-d-cocuk-bakis` (üç çocuk aynı yere kilitlenmiş) → `b04-d-cocuk-onden` (önden, izleyiciye bakar gibi; kamera en soldakine yaklaşır) → fark edilmeyecek geçişle `b04-d-gozler-a` → kamera sağa kayarak `gozler-a` (sol: Cebrâil'in gelişi, sağ: yere yatırma), `gozler-b` (sol: göğsün yarılıp kalbin çıkarılması, sağ: pıhtının alınması), `gozler-c` (sol: leğende yıkama, sağ: yerine koyma ve ışığın çekilişi). Her görselde bir çocuğun iki gözü; sol/sağ = görselin solu/sağı. Kalp: küçük altın ışığın içinden kaldırılan parlak kıvılcım; pıhtı: ondan ayrılıp duman gibi dağılan koyu nokta. Eski `cocuk-yuzler` ve `goz-1…5` kayıtları silindi. Üç çocuk ayırt edilir (A kum rengi, B beyaz sarık, C gri-mavi; Müslim rivayetinde tanıklar oğlan). `referans/sahne-b04-oyun.png` iliştirilir; beşi sırayla aynı sohbette. **Oynatıcı hazır (2026-11-24):** çekimlere `an` (parça içinde başlangıç oranı; parça 0 da olur), `gecis` (çekime özgü geçiş süresi) ve `yol` (bas→son kadraj, `egri: duz|yumusak`, parallax'sız kesin kamera) eklendi; şema `ICERIK_SEMASI.md` → çekimler, doğrulama betiği ve testler (96/96) güncel. Gerçek oynatıcıda henüz görsel olmadığı için denenmedi.
    - **s07 yerleşim taslağı** (ses 23,6 sn; parçalar p0 0,8–7,3 "Cebrâil geldi", p1 7,3–17,3 "yatırdı, yarıp kalbini çıkardı, pıhtı", p2 17,3–24,4 "yıkadı, kapattı, yerine koydu"): ana `b04-d-oyun` → `cocuk-bakis` (p0 an≈.12) → `cocuk-onden` (p0 an≈.38; yol: tam kadrajdan A'nın gözlerine yaklaşma) → `gozler-a` (p0 an≈.68, gecis≈1,8; yol düz: sol göz → sağ göz, "yatırdı" p1 başında sağ gözde) → `gozler-b` (p1 an≈.3, gecis≈1; sol göz "kalbini çıkardı", sağ göz "pıhtı") → `gozler-c` (p2 an≈0; sol göz yıkama, sağ göz yerine koyma). Her göz ≈2,5–3,5 sn; `onden` yalnız ≈2 sn, hızlı gelirse ana görseli atlayıp `cocuk-bakis` ile açmak bir seçenek. Kesin x/y değerleri görseller gelince gözlerin yerine göre ölçülür; önizlemede Erdem bakar.
  - `b07-d-ukaz-yakin` (isteğe bağlı): mantarlı cam şişeler günümüz işi gibiydi.
- **b04-s07 göz dizisi, üçüncü yol kuruldu (2026-11-25).** Duraklar ve ikinci kurgu geri alındı (oynatıcının durak özelliği kodda, kullanılmıyor). `b04-d-yuz-a/b/c` (yeşil perde, kabul) → `tools/yuz_birlestir.py` üç yüzü bulanık çayırın önünde yan yana tek görselde birleştirir (`b04-d-yuzler.webp`, 4816×864; perde yalnız kenara bağlı bölgede silinir; göz aralığı A'ya eşitlenir; yüz merkezleri 1640 px arayla). `tools/goz_dizisi.py` kurgu: yamaç → bakış → önden → A'nın gözlerine tek yaklaşma (yama `b04-d-yuz-a-gecis.webp`) → kamera yüzler boyunca efektsiz sağa kayar, altı gözde anlatıma göre durur. Ses durağı yok, sahne 27 sn. Önizleme `İndirilenler\siyer\_onizleme-b04-s07-goz-v3.mp4`. Telefonda denenmedi. Eski `b04-d-gozler-*` görselleri silindi.
  - **Efendimiz yansımada nur (Erdem, 2026-11-25), yapıldı:** altın top anlaşılmıyordu. Oynatıcıya `ayar.daire` (daireyle kırpma), nurda `aci` (yatırma) ve `hemen` (belirmeden) eklendi. Erdem toplar silinmiş yüz görsellerini üretti (eskileri `arsiv\b04\*-toplu.png`); topların yeri eski/yeni farkından ölçüldü; `goz_dizisi.py` her göze nur koyar (A-sol ve C-sağ ayakta, diğerleri yatık; boy 100 px). Önizleme `İndirilenler\siyer\_onizleme-b04-s07-goz-v4.mp4`. Telefonda denenmedi.
- **Üçüncü üretim (2026-11-24 gece): `b04-d-gozler-a/b/c` kabul** (75 kabul görsel, kırmızı yok). Işıklar soyut (küre, sütun, kemer), insan biçimi yok, gündüz yamaç, her gözde ayrı an. Küçük not: c-sol'da yatan altın küre ışıklı bir tabak gibi duruyor, leğenin yanında ikinci kap sanılabilir; önizlemede bakılacak. Sırada: s07 göz dizisinin yerleşimi (`yol`, `an`, `gecis`) ve önizleme.
- **İkinci üretim (2026-11-24 akşam):** kabul: `b01-d-putlar`, `b03-d-kura-oklari`, `b03-d-kabe-ic-dua`, `b07-d-ukaz-yakin`, `b04-d-cocuk-bakis`, `b04-d-cocuk-onden` (`yeni\`'de; artık 72 kabul). **Red: `b04-d-gozler-a/b/c`** (`arsiv\b04\*-red.png`): ışıklar biçim tutmadı: a-sol beyaz ışık dumanlı mum, altın ışık kuzunun başında alev gibi; b-sağ beyaz ışık kollu insan silüeti; c-sol yatan ışık bebek, c-sağ ayakta çocuk silüeti, gökteki ışık kanatlı figür. İyi okunan: kavisle eğilen sütun (a-sağ, b-sol, c-sol leğen). İstemler sıkılaştırıldı: çocuk = başsız, uzuvsuz yuvarlak/oval altın küre; ziyaretçi = başsız, kolsuz, yuvarlak tepeli beyaz sütun, eğilince kemer; tutulan şey kemerin ucunda süzülür. Önden görsel `referans/sahne-b04-onden.png` oldu ve göz mesajlarına iliştirilir (yüz tutarlılığı). Mesajlar `b04-d1-yeniden-chatgpt.md` (3 görsel).
- Kâbe içi referansları: `referans/kabe-ic-alcak.png` (= `b01-d-kabe-ic`, Erdem koymuştu) ve `referans/kabe-ic-yuksek.png` (= `b09-d-kabe-ic-tavan`, kabul). Küçük not: tavan görselinde kapı kapalı olduğu hâlde içeri ışık giriyor; referans olarak yeterli.
- **Sırada:** 66 kabul görselin sahnelere yerleştirilmesi (`gorsel_katman.py --opak` → `cekimler[]`, öneriler `docs/DINAMIZM.md`) → doğrulama → bölüm bölüm önizleme → commit; kullanılanlar `arsiv\<bölüm>\`'e. Sonra yeni AAB (`1.0.0+2`).

**Kaldığımız yer (2026-11-23): ilk sürüm Google incelemesinde** (kapalı test kanalı).
- Play Console'da uygulama oluşturuldu, `siyer-kapali-test-1.0.0+1-v4.aab` (versionCode 1, `com.yerdema.siyer`) kapalı teste yüklendi ve incelemeye gönderildi. Kategori: Eğitim. Etiketler Erdem'in seçimi (öneri: Din, Tarih, Eğitim).
- Gizlilik politikası: https://yerdema.github.io/siyer-gizlilik/ (herkese açık `YerdemA/siyer-gizlilik`; `magaza/gizlilik.html` değişirse orası da güncellenir). GitHub CLI kuruldu ve YerdemA hesabıyla girişli.
- **Bundan sonra her yeni AAB'de `pubspec.yaml`'daki sürüm kodu artırılmalı** (`1.0.0+2`, `+3`…); Play aynı versionCode'u ikinci kez kabul etmez.
- **İnceleme sonrası (sıradaki oturum):**
  1. Onay gelince test edenler katılım bağlantısıyla kurar; gerçek ağda ilk kez denenecekler: bölüm indirme (b02–b10), yarıda kesilen indirme, internetsiz açılış, ekran kapalıyken uzun dinleme (Xiaomi gibi telefonlarda sistem durduruyor mu).
  2. Red gelirse gerekçeye göre düzelt (olası konular: hedef kitle/Aileler, gizlilik, içerik derecelendirmesi).
  3. Telefonda kontrol edilmedi: harita sekmesinin yeni hâli (yalnız test görüntüsünde doğrulandı).
  4. Erdem bakacak: b09-s07 (kaya havada gibi), b04-s01 (küçük kervan); `ordu-hazir` ve `develer-donus` yeniden üretimi; b10 ve diğer d1 görselleri; 582 atıf doğrulaması (herkese açık yayından önce şart).
  5. 12 test eden ve 14 gün kapalı test şartı (kişisel geliştirici hesabı) üretime çıkıştan önce.

**Erdem'in telefon notları işlendi (2026-11-22, gece).**
- **Sahne düzeltmeleri** (yalnız katman yerleşimi, görsel değişmedi): b06-s07 kervan zemine indi (`y .42→.53`, `olcek .62→.66`); b09-s09 halka + duvar + kap birlikte aşağı ve küçük (arka sıra evlerin önündeki zemine basıyor); b09-s10 kalabalık iki evin arasındaki geçitte, uzak plan (`x .515, y .668, olcek .16`, derinlik `.7→.42` geçitle birlikte kaysın diye). Önizleme betiği oynatıcının yerleşim hesabını kopyalar (geçici; oturum klasöründe). Bütün bölümlerin ana görselleri paftayla tarandı: kesin hata yok; Erdem bakmalı: **b09-s07** (soldaki kaya havada gibi), **b04-s01** (öndeki küçük kervan yerine göre küçük). Çekimler (`cekimler[]`) taranmadı.
- **Ekran kapanınca bölüm sürer** (yalnız ekran kapanınca; başka uygulamaya geçince yine durur). Ekran kapalıyken kare çizilmediği için saati 100 ms'lik zamanlayıcı ilerletir (`Timer.tick` ile; harita geçişi atlanır, ilerleme hemen kaydedilir), `PARTIAL_WAKE_LOCK` (en çok 30 dk; bitince/durunca bırakılır) sahne aralarındaki sessizlikte işlemci uyumasın diye. Oynarken ekran kendiliğinden kararmaz (`FLAG_KEEP_SCREEN_ON`). Köprü: `lib/oynatici/ekran.dart` ↔ `MainActivity.kt` (`siyer/ekran`). Manifest'e `WAKE_LOCK` (normal izin, Play beyanı gerekmez). Ön plan servisi/kilit ekranı kontrolleri yok: Xiaomi gibi agresif pil yönetimli telefonlarda uzun süre ekran kapalıyken sistem uygulamayı durdurabilir; olursa `audio_service` paketi (Erdem onayı) gerekir.
- **Harita geçişi** yalnız bölümün kalanında (o sahne dahil) en az iki sahnenin geçtiği yere açılır (`kaliciYer`); tek sahnelik uğrak (b03-s09 Yesrib kabri) ne gidişte ne dönüşte harita açtırır.
- **Ana sayfa ve oynatıcı dışı her ekran dikey** (`main.dart`); oynatıcı kapanınca dikeye döner.
- Gizlilik metni (indirme Google Play'den; uyanık tutma izni, e-posta) yayında: https://yerdema.github.io/siyer-gizlilik/ . Mağaza ekran görüntüleri `magaza/ekran-goruntuleri/` (4 adet). Sıradaki: Play Console adımları (`magaza/MAGAZA_METINLERI.md` sonu), hedef kitle kararı. Harita sekmesindeki üst/alt koyu şerit giderildi: pencere ekran oranına genişler (`HaritaBolgesi.ekranaGore`), kıyılar Aden Körfezi ve Anadolu güney kıyısına uzatıldı; telefonda değil test görüntüsünde doğrulandı (telefon bağlantısı koptu). Yüklenecek AAB: `İndirilenler\siyer\siyer-kapali-test-1.0.0+1-v4.aab`; eski `…1.0.0+1.aab` (çöker) ve `-v2` silinebilir. Testler 89/89.

**Telefon testi: Play Asset Delivery (2026-11-22, gece).** Xiaomi 2201117SG (Android 11), USB; `bundletool build-apks --local-testing --connected-device` + `install-apks`. Telefondaki kurulum debug anahtarlı olduğu için test seti de `~/.android/debug.keystore` ile imzalandı (yükleme anahtarıyla kurulmaz, kaldırmak ilerlemeyi siler).
- **Release derleme açılışta çöküyordu** (R8, WorkManager'ın `WorkDatabase_Impl`'ini siliyordu; WorkManager asset-delivery kitaplığından geliyor). `app/android/app/proguard-rules.pro` eklendi (Flutter eklentisi kendiliğinden alır). **Eski `siyer-kapali-test-1.0.0+1.aab` bozuk, yüklenmemeli**; yerine `İndirilenler\siyer\siyer-kapali-test-1.0.0+1-v2.aab` (obfuscate, semboller `app/build/semboller`; telefonda açılış ve indirme denendi). Eski Play'e yüklendiyse versionCode artırılmalı.
- Denendi, çalışıyor: bölüm açılınca paket iner (b02, b03) ve oynar, ses paketten çalar; uygulama kapatılıp açılınca indirilen kalır; Ayarlar → İndirilen bölümler → sil (onay sormadan siler); internet kapalıyken indirilmiş bölüm görüntü ve sesle oynar; uygulama güncellenince indirilenler kalır; hız düğmesi 1×/1,5×/2×; çift dokunma ±10 sn.
- Düzeltildi: üçüncü dokunuş sarmıyor, kontrolleri kapatıyordu → gösterge açıkken tek dokunuş da +10 sn (gösterge 900 ms). Telefonda 3 dokunuş = +20 sn doğrulandı. Test eklendi (85/85).
- Düzeltildi: indirme boyutu satırı olan kartlarda özet satır ortasından kesiliyordu → o kartlarda özet 2 satır.
- Denenemedi: gerçek ağ hatası/yarıda kalan indirme (yerel test servisi ağ kullanmıyor); bunlar kapalı test kanalında görülür. b02 d1 görselleri telefonda göründü (s04–s15), göze batan sorun yok.
- Not: ana sayfa yatayda da açılıyor (oynatıcıdan dönünce telefon yan duruyorsa); yatayda tek kart sığıyor. İstenirse ana sayfa dikeye kilitlenir.

**Görsel yardımcısı (2026-11-22):** masaüstündeki "Görsel yardımcısı" kısayolu (konsolsuz; `--kisayol` yeniden oluşturur) ya da `python tools/gorsel_yardimci.py` → tarayıcıda http://127.0.0.1:8765. Sayfadaki "Kapat" düğmesiyle ya da sekme kapanınca ~1 dk sonra kendiliğinden kapanır; günlük `İndirilenler\siyer\_yardimci.log`. Mesaj dosyası seçilir; her kartta "Ekleri kopyala" (referanslar panoya dosya olarak, ChatGPT'de Ctrl+V), "İstemi kopyala" (metin panoya + kimlik indirme kuyruğuna). İndirilenler ve İndirilenler\siyer izlenir; yeni görsel kuyruktaki kimlikle `yeni\<kimlik>.png` olur, kuyruk boşsa sağdaki "atanmamış" listesinden elle atanır; aynı kimlikte eskisi `yeni\_onceki\`'ne. Sahte indirmeyle ve pano ile denendi; ChatGPT'ye Ctrl+V ile dosya yapıştırma Erdem'in tarayıcısında denenmedi (olmazsa "Klasörde aç").

**En son (2026-11-22, gece): b02 d1 görselleri işlendi, Erdem önizlemeyi onayladı, commit'lendi** (`İndirilenler\siyer\_onizleme-b02-d1.jpg`; kaba pafta, saat tonu ve kamera yok).
- 22 görselden **20 kabul**, katmanları `content/gorseller/b02-d-*.webp`. 3:2 görsellerde başlar kesilmesin diye 9'u (arap-kabileler, ebrehe-ofke, ebrehe-saygi, tepede-bekleyis, ordugaha-varis, kureys-istisare, ebrehe-yakin, hunata-gelis, kasva) üstten %2,5 kırpılıp 16:9'a çevrildi, gerisi ortadan.
- **2 red, istemleri düzeltildi** (`b02-d1-chatgpt.md` Mesaj 13 ve 16): `ordu-hazir` (filin baş örtüsü yok; referansta ve öteki görsellerde var → fil kartına baş örtüsü eklendi), `develer-donus` (develer insandan küçük ve yüklü; kaynakta otlaktan alınan develer). Reddedilenler `arsiv\b02\*-red.png`.
- Yerleşim: s07, s08, s09, s11, s13'te yeni görsel ana görüntü oldu, eski ana görüntü sonraki parçaya çekim olarak taşındı. Metin ve ses değişmeden bölünen parçalar: s08 [1], s09 [0], s14 [1] (ayet üçe), s16 [2]. s08'deki eski kadrajlı Hunâta yakın planı kalktı (ana görüntü değişince kadraj yanlış yere düşüyordu). s10'da Ebrehe yakın planından sonra Abdülmuttalib'in cevabı yine yakın planda. s12 [0] `ordu-hazir` gelene kadar eski fil görseli.
- Doğrulama 0 hata, testler 84/84. Gerçek oynatıcıda (web/telefon) denenmedi.
- Sırada: `ordu-hazir` ve `develer-donus` yeniden üretilince yerleştirilir (s12 [0], s10 [3]); sonra b10 görselleri.

**Kaldığımız yer (2026-11-22, akşam): dinamizm turu d1** (Erdem istedi: uzun tek görselli ve yalnız Kâbe'li sahneler sıkıcı).
- 10 bölüm ölçüldü: 39 dakikanın ~%37'si ya yalnız ortak Mekke/Kâbe çekimi ya da 20 sn'den uzun tek görsel; en kötüleri b02 (%62), b10 (%58), b07 (%55). Değerlendirme ve görsel listesi: `docs/DINAMIZM.md`.
- **96 yeni görsel istemi** (63 A, 33 B), hepsi tam dolu `mekan`: `content/gorseller/istemler/bXX.json` içinde `tur: "d1"` (kaynak `tools/dinamik_istemler.py`), mesajlar `bXX-d1-chatgpt.md`. Efendimiz çizilmez; gereken 7 görselde yeri boş bırakılır.
- Erdem'in kararları (2026-11-22): putlar şekli kaynakta yoksa farklı biçimlerde yaklaşık put; göğsün yarılması çocukların gözündeki yansımada, 5 göz yakın planı (`b04-d-goz-1…5`, ışıklar istisna olarak görselde); b01 ve b02'de inisiyatif bende (Necâşî çıkarıldı, Kasvâ'da Efendimiz yok). `GORSEL_USLUP.md` güncellendi.
- Kâbe'nin içi (deneyenlerin önerisi): iki ana görsel (`b01-d-kabe-ic` 605 öncesi, `b09-d-kabe-ic-tavan` 605 sonrası; TDV KÂBE c. 24 ve anlatımdaki iddialara dayanır), onaylanınca `referans/kabe-ic-alcak.png` / `kabe-ic-yuksek.png`; iç sahneler b03-s03 (kura), b03-s12 (dua), b09-s02 (kuyu), b09-s14, ayrıca `b08-d-hatice-oda`.
- Referans kontrolü yapıldı: mesajlarda adı geçen bütün referanslar `istemler/referans/`'ta var; yalnız `kabe-ic-alcak.png` ve `kabe-ic-yuksek.png` bilerek eksik (ana iç görsellerden çıkacak). Kartı olmayan karakterler (Hunâta, Zû Nefer, rahip, Ebâbîl kuşları, Abdülmuttalib'in oğulları) için onaylı sahne görselleri `referans/sahne-*.png` olarak eklendi ve `SAHNE_REFERANSI` ile mesajlara otomatik iliştiriliyor. Habeşli asker tarifi karta bağlandı (zırh + kırmızı pelerin).
- **Erdem şimdi görselleri üretiyor; bitince yeni oturum açacak.** Üretim sırası:
  1. **Önce `b01-d-kabe-ic`** (605 öncesi Kâbe içi). Onaylanınca `referans/kabe-ic-alcak.png` olarak konur; b03-d-kabe-ic-kura, b03-d-kura-oklari, b03-d-kabe-ic-dua, b09-d-kabe-ic-kuyu bu referansı ister. `b09-d-kabe-ic-tavan` onaylanınca `referans/kabe-ic-yuksek.png`.
  2. Sonra bölüm sırası b02 → b10 → b07 → b01 → b08 → b03 → diğerleri; her bölümde önce A, sonra B öncelikliler.
  3. Görseller ChatGPT'den `İndirilenler\siyer\yeni\`'ye, dosya adı istem kimliğiyle (ör. `b02-d-kasva.png`).
- **Görseller gelince (oturum başında):** `yeni\` klasörünü listele, her görseli istemindeki karta, üç kesin red kuralına (kaynak, tutarlılık, gerçek dışı) ve bileşime göre denetle; özellikle b04 göz dizisinde yansımada insan/melek biçimi olmamalı, Efendimiz yalnız küçük ışık. Kabul edilenler `gorsel_katman.py --opak` → `cekimler[]`'e yerleştirme (uzun parçalar metin ve ses değişmeden bölünür; yerleşim önerileri `docs/DINAMIZM.md` bölüm tablolarında) → `icerik_dogrula` + `bolum_metni.py` → sahne önizlemesi → bölüm bölüm commit; kullanılan görseller `arsiv\<bölüm>\`'e, `yeni\` boşaltılır. Reddedilenler için düzeltilmiş istem yazılır.

**Önceki (2026-11-22): boyut küçültme ve bölüm indirme** (Erdem, kapalı testten önce istedi).
- **Bölüm indirme: Play Asset Delivery** (Erdem seçti; sunucu yok, INTERNET izni yok, gizlilik metni değişmez). b01 uygulamaya gömülü; b02–b10 isteğe bağlı paket (`app/android/paketler/bNN`, `icerik_esitle` üretir, git dışı). Ayrıntı: `docs/ICERIK_SEMASI.md` → Bölüm paketleri.
  - Kotlin köprüsü `BolumPaketleri.kt` (`asset-delivery:2.3.0`); Dart `lib/icerik/paketler.dart`. İnmemiş bölüm açılınca indirme kendiliğinden başlar (`oynatici/bolum_indirme.dart`); ana sayfa kartında boyut ya da ilerleme; Ayarlar'da "İndirilen bölümler" ve sil.
  - Elle kurulan tek APK'da (bundletool `--mode=universal`) paket APK'dan `files/paketler/` altına çıkarılır — **telefonda denenmedi**.
  - Yayın denetimi `--paketler app/android/paketler` ile paketlerdeki dosyaları da arar.
  - AAB derlendi (`--obfuscate --split-debug-info=build/semboller`): içinde b02–b10 on-demand modülleri; temel paketteki içerik 77 → 14,5 MB. Telefona inen boyut bundletool `get-size total` ile ölçülmedi (bundletool indirme izni verilmedi).
  - Görsel önbelleği artık yalnız önceki/şimdiki/sonraki sahneyi tutar (önce bütün bölüm bellekte kalıyordu, ~12 MB/katman).
  - Testler 80/80, analiz temiz.
- **Medya sıkıştırıldı** (Erdem sesi dinleyip onayladı): 135 ses 48k mono AAC `.m4a` (39 → 16 MB; `ses_dengele.py` artık ham MP3'ü m4a'ya çevirip MP3'ü siler), 163 görsel WebP q72 (37,8 → 22,8 MB; `gorsel_katman.py` q72). Görseller telefonda henüz görülmedi.
- **Ölçüm** (bundletool 1.18.3, `C:\Users\yusuf\siyer-araclar\bundletool.jar`, Android Studio JBR java'sıyla): Play'den inen boyut ~17 MB (arm64); önce ~90 MB. Gömülü içerik 8,5 MB; bölüm paketleri 2,0–4,7 MB.
- Tek dosyalık (universal) APK'ya on-demand paketler girmiyor. Elle kurulacak test APK'sı için paketler install-time derlenir (`--android-project-arg=paketTeslimi=install-time`), sonra `bundletool build-apks --mode=universal` yükleme anahtarıyla. Uygulama paketi APK'dan `files/paketler/` altına çıkarır.
- **Oynatıcı: hız ve çift dokunma** (Erdem istedi): kontrol çubuğunda `1× → 1,5× → 2×` düğmesi (saat ve ses birlikte hızlanır, perde korunur; tercih kalıcı, `tercih.hiz`). Görüntünün sağ yarısına çift dokunma 10 sn ileri, sol yarısına geri; art arda dokunmalar birikir (+20 sn). Çift dokunma algılayıcısı yalnız görüntüyü sarar, kontrol düğmeleri gecikmez; tek dokunuşla kontrolleri açıp kapama artık ~300 ms gecikmeli. Testler 84/84.
- **Test APK'sı:** `İndirilenler\siyer\siyer-paketli-test-v7.apk` (95 MB, hız ve çift dokunma dahil, bütün bölümler içinde; gerçek indirmeyi değil APK'dan çıkarmayı sınar) — telefonda denenmedi.
- **Kapalı test AAB'si yenilendi:** `İndirilenler\siyer\siyer-kapali-test-1.0.0+1.aab` (on-demand paketli, obfuscate; semboller `app/build/semboller`).
- **Sırada:** Erdem test APK'sını dener (b02+ açılışı, görsel kalitesi, Ayarlar'da sil). Gerçek indirme ya telefon USB ile bağlıyken `bundletool build-apks --local-testing` + `install-apks` ile ya da kapalı test kanalında denenir.

**Önceki (2026-11-21, akşam): anlatım sesi.**
- Erdem ElevenLabs Starter aldı. **b01–b04'ün 51 sahnesi seslendirildi** (Seyfullah Kartal `mF7tIc9VLrznhGooGjaT`, `eleven_v4`, sahne başına 1 üretim; ~17.400 kredi). Dosyalar `content/tr/ses/<sahne>.mp3` (18,6 MB, 6–48 sn).
- Seslendirme metinleri `content/tr/ses/istemler/b0N.json`: altyazıyla aynı kelimeler + duygu etiketleri ([calm], [warmly], [serious], [sad], [softly], [reverently] ayet/hadislerde, [dramatically] Fil Vakası'nda, [happy]/[excited] yalnız doğum haberinde). [playful] gibi şakacı etiketler üslup kuralı (7) gereği kullanılmadı. Ayraçlar akıcı okunsun diye kaldırıldı ("fil(in" → "filin"). `icerik_esitle` bu klasörü uygulamaya kopyalamaz.
- Etiketlerin okunmadığı b01-s01 hizalamasıyla görüldü (her etiket ~0,05 sn). Telaffuzu Claude dinleyemedi; **Erdem telefonda dinlemeli** (özellikle Arapça adlar, «s.a.v.», ayetler).
- Altyazı hâlâ sesi kelime sayısına göre paylaştırıyor; kayma görülürse ElevenLabs hizalamasıyla (kelime zamanları) parça sınırları kesinleştirilebilir.
- Test APK'sı: `İndirilenler\siyer\siyer-sesli-b01-b04.apk` (profile derleme; release yayın kapısına takılır, doğrulanmamış atıf var).
- Telefon testi (Erdem): sahne geçişinden sonra ses kesik/hiç gelmiyordu. Sebep: dosya yüklenirken saat ilerliyor, gecikme kayma sayılıp ses tekrar tekrar aranıyordu. Düzeltme: sessizlikte sıradaki ses önceden yüklenir; ses akmadan saat bekler (en çok 2 sn), akarken saat sese uyar; arama yalnız kaydırma/atlamada. Yeni APK: `siyer-sesli-b01-b04-v2.apk` — telefonda doğrulanmadı.
- Altyazı varsayılan kapalı (Erdem: animasyonun keyfini kaçırıyor); Ayarlar'da ve oynatıcı düğmesinde açılır, tercih saklanır. Sesi olmayan sahnede metin her zaman görünür.
- Telefon testi 2: ses düzgün (v2 doğrulandı). Bölüm sonu yumuşatıldı: son sahne 4 sn sürer, son 3 sn görüntü kararır, sonra bölüm adı kartı, ardından kaynaklar. Anlatıcı sesindeki ani iniş çıkışlar `tools/ses_dengele.py` ile giderildi (hafif sıkıştırıcı + -16 LUFS; sahneler arası fark 5,5 dB → 0, iç dalgalanma en çok 7,9 → 3,7 LU). ~~Yeni seslerden sonra bu betik çalıştırılmalı.~~ (2026-11-24: betik kaldırıldı, ses işlenmez.) APK: `siyer-sesli-b01-b04-v3.apk` — telefonda doğrulanmadı.
- **b05–b10 de seslendirildi (84 sahne; 10 bölüm, 135 sahne tamam).** Kredi için etiketler seyrek, sahne başındaki [calm] atıldı, sert etiketler ([excited], [breathless]) kullanılmadı. 18.829 kredi; kalan ~220 (yenilenme 2026-12-22 civarı). Hepsi `ses_dengele.py`'den geçti. Kelime denetimi: etiketler çıkınca metin anlatımla birebir aynı.
- Listelerin altı gezinme çubuğuna kalıyordu (Android 15 kenardan kenara); `tema.dart`'taki `altPayli` ile düzeltildi (v4).
- **Dikkat:** Yeni ses dosyası eklenince `flutter build` eski varlık listesini kullanıp yeni dosyaları pakete almadı (APK'da 51 dosya kaldı). `flutter clean` sonrası 135. Yeni varlık klasörüne dosya eklendiğinde temiz derle ve `unzip -l` ile say.
- APK: `siyer-tam-sesli-v5.apk` (temiz derleme, 135 ses) — telefonda doğrulanmadı.
- **Kapalı test hazırlığı** (Erdem, 2026-11-21; Play hesabı var).
  - **Kapalı test derlemesi** (Erdem seçti): `flutter build appbundle --release --android-project-arg=kapaliTest=true` → `icerik_dogrula --kapali-test`. Yalnız `bekliyor` atıflar uyarı olur, diğer bütün yayın kuralları hata kalır. Herkese açık yayın `--yayin` ile, değişmedi. Uygulama doğrulanmamış atıfları zaten "doğrulama bekliyor" diye gösteriyor.
  - **Tek kaynak istisnası** (`KAYNAK_POLITIKASI` §2.1) artık iddiada `"istisna": "tek-kaynak"` ile işaretleniyor (şema güncel); betik hata değil uyarı verir. İşaretlenenler: i-b06-007 (İbn Sa'd dayanağı), i-b08-024 (Buhârî/Müslim/Müsned dayanağı). **Erdem iki gerekçeyi onaylamalı.**
  - i-b05-002'ye İbn Hişâm s. 107 eklendi (taramadan okundu: «ثم أرسله إلى أمه آمنة», «فكان رسول الله مع أمه آمنة ... وجده عبد المطلب»).
  - Buhârî ve Müslim `baski` alanı dolduruldu (Erdem inisiyatifi Claude'a bıraktı): baskı adı değil, kullanılan numaralandırma yazıldı (sunnah.com; Müslim'de harfli alt numaralar sitenin). Matbu nüsha karşılaştırması herkese açık yayından önce.
  - **Kapalı test AAB'si derlendi:** `İndirilenler\siyer\siyer-kapali-test-1.0.0+1.aab` (129 MB; 0 hata, 14 uyarı). Yükleme anahtarıyla imzalı (SHA-256 `B9:79:88:EF:…:6F:CA`). İzinler: yalnız ACCESS_NETWORK_STATE (ses kitaplığından); INTERNET yok. targetSdk 36, versionCode 1.
  - Başlatıcı adı "siyer" idi; `res/values*/strings.xml` ile "Resulü Ekrem'in Hayatı" / İngilizce "The Life of the Prophet".
  - **Mağaza malzemesi `magaza/`:** `MAGAZA_METINLERI.md` (ad, kısa/tam açıklama, test notu, Play Console form cevapları), `gizlilik.html` (TR+EN; `ILETISIM_EPOSTASI` yerine e-posta yazılmalı), `simge-512.png`, `one-cikan-grafik.png` (taslak, Erdem onayı).
  - **Erdem'den beklenen:** gizlilik sayfasını yayımlamak (GitHub Pages ya da Google Sites; depo herkese açık değilse Pages ücretli plan ister), hedef yaş grubu kararı (13 altı → Aileler politikası), telefondan 4–5 ekran görüntüsü, Play Console'da uygulamayı oluşturup AAB'yi kapalı test kanalına yüklemek, test eden e-posta listesi. Not: Kasım 2023 sonrası açılmış kişisel geliştirici hesaplarında üretime çıkmak için 12 test edenle 14 gün kapalı test şartı var.
  - **Yükleme anahtarı:** `C:\Users\yusuf\siyer-anahtar\siyer-yukleme.jks` (alias `yukleme`), şifreler `app/android/key.properties` (git dışı) ve aynı klasörde yedek. Erdem güvenli yere yedeklemeli. Anahtar yoksa release debug anahtarıyla imzalanır.
  - Sırada: gizlilik politikası metni ve adresi, mağaza metinleri ve ekran görüntüleri, Play Console'da uygulama kaydı (veri güvenliği formu, içerik derecelendirmesi, kapalı test kanalı ve test eden listesi).

**Önceki (2026-11-21).**
- **Simge ve açılış uygulamada** (Erdem seçti: `simge-1-muhur` + `acilis-1-parsomen`; iki paket onaylandı, `dev_dependencies`). PNG'ler `tasarim/simge-acilis/uygulama_varliklari.py` ile `app/assets/simge/`'ye; ayarlar `app/flutter_launcher_icons.yaml`, `app/flutter_native_splash.yaml`. Uyarlanabilir simge (ön plan mühür, arka plan parşömen), Android 12+ açılışı (parşömen rengi + mühür), eski Android/iOS açılışı (parşömen zemin + mühür + başlık). Görünüm: `tasarim/simge-acilis/uygulamada.png`. Debug APK derlendi; telefonda henüz görülmedi.
- `android/gradle.properties`'e `kotlin.incremental=false` eklendi: proje D:, pub önbelleği C: sürücüsünde olduğu için Kotlin artımlı önbelleği kapanamıyor, derleme düşüyordu.
- Testler 67/67, analiz temiz.
- **Sıradaki:** telefonda deneme (Erdem "az sonra konuşalım" dedi), sonra içerik kontrolü.

**Kaldığımız yer (2026-11-20, kapanış).** Gün burada kapandı.
- **Hareketi azalt** (Ayarlar; telefonun "animasyonları kaldır" ayarı açıksa kendiliğinden): bölüm kartı büyümez, kaydırma anında, çarpı 0,5 sn; harita geçişi kamerasız, doğrudan hedef, nabız halkası yok, 1,5 sn.
- **Doğrulama betiği** `sahislar.json`'da `temsil` değerini (nur/yuzsuz), temsilli şahsa portre konmamasını (kural 5) ve `portre` dosyasının `content/gorseller/` altında var olmasını denetler. Bozuk kopyada üç hata da yakalandı; gerçek içerikte 0 hata.
- Testler 67/67, analiz temiz.
- **Sıradaki (Erdem'den):** telefonda deneme (nur kenarı, efekt sesleri, ana sayfa, harita geçişi); ~~simge/açılış taslağı seçimi ve iki paket onayı~~ (2026-11-21 yapıldı); `docs/BOLUM_METINLERI.md` üzerinden içerik kontrolü ve atıf doğrulaması (582 bekliyor).

**Önceki (2026-11-20, gece).**
- Hâcer ve Süveybe yüzsüz siluet kalır (Erdem; CLAUDE.md kural 5'e yazıldı).
- **Devam kartı:** Ana sayfanın en üstünde, en son izlenen yarım bölüme dönüş kartı (gece laciverdi, altın ilerleme, kına oynat düğmesi); dokununca bölüm kalınan sahneden açılır. İlerleme kaydına `zaman` (Unix ms) eklendi; eski kayıtlar 0 sayılır. Başlanmış bölümler sırası gelmese de soluk gösterilmez.
- **Kontrol nüshası:** `docs/BOLUM_METINLERI.md` (10 bölüm, 135 sahne, 200 iddia, 499 atıf; sahne sahne anlatım, yer, şahıslar, görsel tarifi; her bölüm sonunda iddialar, kaynaklar, gerekçe, alternatif rivayetler; ekler: şahıslar, yerler, zaman çizelgesi). `python tools/bolum_metni.py` ile üretilir; düzeltme JSON'a yapılır, dosya yeniden üretilir. **İçerik değişince yeniden üretilmeli.**
- **Simge ve açılış taslakları:** `tasarim/simge-acilis/` (4 simge, 3 açılış, `onizleme.html/png`, README'de öneri: mühür simgesi + parşömen açılış). Uygulamaya geçirmek için `flutter_launcher_icons` ve `flutter_native_splash` paketleri gerekir; Erdem'in seçimi ve paket onayı bekleniyor.
- Testler 66/66.

**Önceki (2026-11-20, akşam).** Erdem'in kararları: harita geçişi her açılışta kalır ("Geç" var); Zeyd b. Hârise evlatlık olduğu için yüzüyle çizilebilir, öz çocuklar çizilmez (CLAUDE.md kural 5 güncellendi). Öneri listesinden ilk altısı yapıldı:
1. Bölüm sonunda "Sıradaki bölüm: …" düğmesi (sonrakini açar).
2. Ana sayfada bitirilmemiş ilk bölüm "Sıradaki" işaretli; sonrakiler soluk (%55), yine açılabilir.
3. Haritada izlenen sahnelerin yerleri ve iki ucu görülen kervan yolları koyu, diğerleri soluk (`gorulenYerlerProvider`).
4. Şahıs sayfasında "İlk göründüğü yer" kartı: bölüm ve sahne, dokununca o sahneden açılır.
5. Efekt sesleri `app/assets/sesler/` (kalem.wav: çarpının iki darbesiyle zamanlı; parsomen.wav: harita açılışı); `tools/efekt_sesleri.py` gürültüden sentezler, telifsiz. **Erdem telefonda dinleyip beğenmeli**; Claude dinleyemedi. Ayarlar'da kapatılabilir.
6. Ayarlar'da altyazı boyutu (küçük 0,85 / orta / büyük 1,3); `ayarlar/tercihler.dart`.
- Not alınanlar (YOL_HARITASI): simge ve açılış ekranı, hareketi azalt, portre dosyası denetimi.
- Açık soru: Hâcer ve Süveybe ihtiyaten yüzsüz siluet; Erdem'e soruldu, cevap bekleniyor.
- Dart'ın `toUpperCase()`'i Türkçe i'yi bilmiyor ("SIRADAKI"); Türkçe metinlerde büyük harfe çevirmeden yazılmalı.
- Testler 63/63, analiz temiz.

**Önceki (2026-11-20).** Ana sayfa ve gezinme yenilendi; Erdem'in görmesi ve telefonda denemesi bekleniyor:
- **Tema** (`app/lib/tema.dart`): parşömen-mürekkep paleti (kına kırmızısı, şafak altını, zeytin), açık tema; başlıklarda serif (Android'de Noto Serif; web'de Roboto görünür).
- **Ana sayfa** (`ana_sayfa.dart`, `bolum_yolu.dart`): alt sekmeler Bölümler / Harita / Şahıslar; zaman çizelgesi ve ayarlar başlıkta. Bölüm kartları elle çizilmiş bir yol gibi sola-sağa salınır, ±3° eğik, aralarında noktalı yol; köşede numara mührü (izlenince zeytin + tik), açıklama, yarım bölümde ilerleme. Dokununca kart düzleşip büyür, kına kırmızısı çarpı iki darbeyle çizilir, bölüm açılır.
- **Şahıslar**: yalnız izlenen sahnelerde geçenler (`ilerleme/gorulenler.dart`; hiç izlenmemişse yalnız Efendimiz), arama (şapka/Türkçe harf duyarsız), madalyon: 17 portre karakter kartlarından kırpıldı (`tools/portre_kirp.py`, `content/gorseller/sahislar/`), Efendimiz/İbrâhim/İsmâil/Cebrâil nur, anne-baba/Hatice/Halîme/Süveybe/Hâcer/Kâsım yüzsüz siluet, kartı olmayanlar baş harf. `sahislar.json`'a `portre`, `temsil` eklendi.
- **Harita geçişi** (`oynatici/harita_gecisi.dart`): bölüm açılınca bütün harita → olayın yerine yakınlaşma ve ad; sahne uzak bir yere geçince önceki yer → bütün harita → yeni yer. Mekke çevresi içi (Mekke↔Hira vb.) geçiş yok. Zaman ve ses bu sırada durur; "Geç" ya da dokunuşla biter. Her açılışta gösterilir (devam edilen bölümde de). Revize açılışlarında (`?dur=1`, `?cekim=`) gösterilmez.
- **Harita**: kum serpintisi ve kum tepeleri eklendi; çizici artık kamera penceresiyle çizebiliyor (geçiş için).
- Testler 59/59, analiz temiz; web'de telefon boyutunda denendi.

**Önceki (2026-11-18).** b06'nın 12 görseli geldi, işlendi ve yerleştirildi; Erdem onayladı, commit'lendi (önizleme `İndirilenler\siyer\_onizleme-b06.jpg`; paftadaki nur kaba bir taklit, oynatıcıdakinden sert görünür).

- Denetim: kartlarla tek tek bakıldı, red yok. Notlar: `b06-manastir`'da ağacın dalları istendiği kadar alçak değil, bulut gölgesi ağaç gölgesiyle birleşik; Ebû Tâlib'in cüppesi b06'da zeytin tonlu (kartta kahverengi), bölüm içinde tutarlı.
- Hamlar `gorsel-ham/b06`. Kayıt `istemler/b06.json` → `uretimler`.
- Yerleşim: mekânlar (avlu, ev içi, yamaç, Busrâ) derinlik 0,3 + `ayar.gorsel {0.5, 0.5, 1.0}` ile tam görünür; manastır da tam görsel. s06 uzak plan + 1. parçada kadrajlı çekim (yeni). s07'de kervan arkada orta boy, Ebû Tâlib önde. s08/s12 kervan küçültüldü; s13'te kervan solda, Kâbe'ye değmeden. s09 Bahîrâ manastırın yanında küçük; s09 çekiminde nur ağaç gölgesinde (boy 0,2); s10 nur yüklerin yanında; s11 nur 0,48 boyda Bahîrâ'nın karşısında.
- Gerçek oynatıcıda (web) s09 çekimi, s10 ve s11 denendi; nur yerinde, yumuşak.
- **Erdem'in kararı bekleyen (eski):** Bahîrâ'nın kukuletalı, ip kemerli Batılı keşiş görünümü; görseller bu kartla üretildi, değişirse 5 Bahîrâ'lı görsel de yenilenir.
- **b06 metni, Erdem'in bakacakları:** `docs/ERDEM_KONTROL.md` → b06 (atıflar, yaş tercihi, tek kaynaklı iddialar). Bölümde bilerek yer verilmeyen bir rivayet: İbn Hişâm s. 114-115'teki Lehebli kâhinin çocukları inceleyip Efendimiz'e dikkat kesilmesi (eski plan notunda geçiyordu); istenirse eklenir.
- **2026-11-18: Efendimiz'in nurlu figürü oynatıcıya eklendi** (`kim: "efendimiz"`: dolu, opak nur + yeşil sarık; diğer peygamberlerin bulanık nuru aynı). b06'daki üç nur işaretlendi. Bütün metinlerde anlaşılmaz ifadeler sadeleştirildi (ör. "anne-baba bir kardeşi", câriye, inzivâ, kayser, kılavuz).
- **2026-11-18: b07 Gençlik taslağı yazıldı** (14 sahne, 26 iddia, 73 atıf; doğrulama 0 hata). Ficâr (Ukâz, ilk savaşlar, Berrâd-Urve, Ebû Tâlib'in itirazı, Zübeyr'in komutası, "amcalarıma ok verirdim") ve Hilfü'l-fudûl (Zübeydli tüccar, Cüd'ân'ın evi, yemin, Resûlullah'ın sözü). Kaynak denetçisi bulguları düzeltildi. Erdem'in bakacakları: `docs/ERDEM_KONTROL.md` → b07. Yeni şahıslar: Zübeyr, Abdullah b. Cüd'ân, Harb b. Ümeyye, Âs b. Vâil, Berrâd, Urve. Zaman çizelgesi: Ficâr ≈585, Hilfü'l-fudûl ≈589.
- **2026-11-18: b07'nin 13 görseli işlendi ve yerleştirildi.** Red yok. `b07-dagilan`'da sol grup aynalandı (iki grup aynı yöne yürüyordu; ham `gorsel-ham/b07/b07-dagilan-orijinal.png`). `b07-ebukubeys`'te tüccar üst kenara çok yakın, s11 kamerası sabit. Yemin sahnesindeki 'el göğüste' Erdem kabul etti. Hamlar `gorsel-ham/b07`; `yeni\` boşaltıldı, görseller `İndirilenler\siyerrsiv\<bölüm>\`'de (her bölümden sonra böyle).
- **2026-11-18, Erdem'in düzeltmeleri:** (1) Kervanlar havadaydı: `b02-col` zemininde düz kum ekranda y ≈ 0,66'dan başlar; ayaklar 0,70'e indirildi (b07 s04/s05/s09, b06 s08/s12). (2) Efendimiz'in nuru montaj gibiydi ve yeşil sarık daire gibi görünüyordu: sarık kaldırıldı (peygamberlik öncesi sarıksız; sarıklı görünüme peygamberlikten sonraki bölümlerde geçilecek), nur kenarları yumuşak, ortası parlak, ayakları ışığa karışan ve zemine ışık düşüren biçime getirildi.
- **2026-11-18, geri alınan iş:** Paralel çalışan başka bir Claude oturumu Erdem'in referans görseliyle sarıklı, görsel tabanlı bir 'Efendimiz'in nuru' tasarımına geçmişti (commit `1a542d2`, `2836fa6`'daki kervan değerleri, `bb7912f` ve commit'lenmemiş belge değişiklikleri). Erdem'in isteğiyle tamamı geri alındı; referans görsel (`efendimiz-nur-referans.png`, `efendimiz-nur.webp/png`) her yerden silindi.
- **2026-11-18: b08 el-Emîn taslağı yazıldı** (15 sahne, 24 iddia, 73 atıf; doğrulama 0 hata; commit `a22d8d8`). Ticaret ve el-Emîn, Hatice'nin teklifi, Meysere ile Şam yolculuğu, rahip (adı verilmeden, 'rivayete göre'), kâr, Hatice'nin evlenme isteği (dolaylı), amcaların istemesi, mehir ve yaşlar, çocuklar, Zeyd b. Hârise, kıtlık yılında Ali. Kaynak denetçisi bulguları düzeltildi: Hicr'deki söz tek ve atıfsız D kaynağı olduğu için çıkarıldı; Hatice'yi anma 'guclu'ya indi. Oğulların adları rivayetteki haliyle sayıldı (onaylı listeden farklı, Erdem'e bildirildi). Erdem'in bakacakları: `docs/ERDEM_KONTROL.md` → b08. Yeni şahıslar: Meysere, Hamza, Kâsım, Zeyd b. Hârise, Hakîm b. Hizâm, Hârise, Ali. Zaman çizelgesi: evlilik ≈596.
- **2026-11-18: b08 görsel istemleri hazırlandı** (`istemler/b08.json`, `b08-chatgpt.md`; 11 görsel; commit `8d02639`). Erdem'in onayıyla birden fazla görselde geçen karakterlerin kartları API ile üretildi: `karakter-meysere`, `karakter-zeyd_harise`, `karakter-hatice` (yüzsüz, arkadan; şarap kırmızısı-kahve pelerin); denetlendi, sorun yok. Tek görsellik kartlar (sayfasız): hamza, abbas, ali_cocuk, cafer_genc, hakim_b_hizam, harise, nestura. Ebû Tâlib istemlerde yaşlandırıldı (nikâhta ~60, kıtlıkta ~70). Nur için boş yer bırakılan görseller: hatice-ev (kapı), busra-agac (ağaç gölgesi), amcalar, nikah, aile, harise, zeyd-yuruyus, ali.
- **2026-11-19: b08'in 11 görseli işlendi ve yerleştirildi; commit'lenmedi, Erdem'in önizleme onayı bekliyor** (`İndirilenler\siyer\_onizleme-b08.jpg`; paftadaki nur kaba taklit).
  - Denetim: kartlarla tek tek bakıldı, red yok. `b08-ali`'de Ebû Tâlib'in cüppesi hardal renkliydi (kart ve `b08-amcalar`/`b08-nikah` zeytin-kahve); o bölge yerel olarak renk düzeltildi (ham `gorsel-ham/b08/b08-ali-orijinal.png`). Küçük notlar: `b08-nikah` ve `b08-hatice-ev`'de üst kat penceresinde perde ardında belli belirsiz kadın gölgesi (tarifle uyumlu); `b08-harise`'de Zeyd tam sağa değil öne dönük, başı babasında; `b08-zeyd-yuruyus`'ta Zeyd sağa yürüyor, nur onun sağında (önde) konuldu.
  - Yerleşim: mekânlar (avlu, Busrâ, nikâh, ev içi) derinlik 0,3 + tam görünür; s03'te kapı kenarda kaldığı için mekân sola kaydırılıp büyütüldü, Meysere yüklerin yanında, nur kapının önünde. s05: nur ağaç gölgesinde, rahip ile Meysere manastır kapısında. s09: nur Ebû Tâlib ile akrabaların arasında. s10: nur kapının önünde, çocukların arkasında. s11-s14: uzak plan + kadrajlı orta plan çekimi (b07-s06 düzeni). s08 tek parçalı olduğu için çekim olamadı; ortak katmanlar kadraj hesabıyla elle büyütülerek orta plan kuruldu.
  - Gerçek oynatıcıda (web) henüz denenmedi. Ham görseller `gorsel-ham/b08`, kayıt `istemler/b08.json` → `uretimler`; `yeni\` boşaltıldı, görseller `arsiv\b08\`.
- **2026-11-19, Erdem'in iki notu (önizlemeden sonra; ilk iş bunlar):**
  1. **"s08 kervan Kâbe'nin üstünde."** b08-s08'de kervan yok (Ebû Tâlib ile Hamza); büyük olasılıkla b08-s01 kastediliyor: `b06-kervan-hazirlik` x 0,5 / y 0,635 / ölçek 0,2 ile tam Kâbe'nin önüne biniyor. b06-s08 de olabilir; Erdem'e sor, ikisine de bak, kervanı Kâbe'den ayır.
  2. **Efendimiz'in nuru hâlâ istediği gibi değil.** Neyin değişmesi gerektiğini sor (biçim, ışık, boy, saydamlık?); gerçek oynatıcıda göstererek ilerle.
- **2026-11-19, iki not işlendi; Erdem onayladı, b08 commit'lendi:** (1) b08-s01'de kervan x 0,5 → 0,2 (Kâbe'nin solunda, evlerin önünde); b06-s06'da Kâbe olmadığı için dokunulmadı. (2) Nur: web oynatıcıda ve paftada siyah kenar görülmedi; büyük olasılıkla telefonda (Impeller) renk geçişli şekle `MaskFilter.blur` koyu saçak bırakıyor. Kenar ışıması ve gövde artık ayrı katmanda düz renkle çizilip katman bütün hâlinde bulanıklaştırılıyor (`_nurKatmani`); gövde biraz saydam (opaklık 0,9, aşağı doğru solar; Erdem saydamlığı beğendi). Siyah kenarı Erdem telefonda görmüştü; yeni hâl telefonda henüz denenmedi, ilk fırsatta bakılacak. Önce/sonra: oturum çıktısı `nur-once-sonra.jpg`. Not: b08 içeriği `icerik_esitle` ile uygulamaya hiç kopyalanmamıştı, kopyalandı.
- **2026-11-19 (akşam):** (1) b08 rahibi Bahîrâ ile karışmasın diye `nestura` kartı değişti (yaşlı, beyaz sakal, kukuletasız, küçük siyah takke, açık gri cüppe, asa); `b08-rahip` API ile 2. tur üretildi (~0,11 $), denetlendi, s05'te yerinde (ham `gorsel-ham/b08`, eski `-tur1`). Bahîrâ kıyafet kararı böylece kapandı, Bahîrâ olduğu gibi kaldı. (2) Bağış bağlantısı MVP'den çıktı (Erdem). (3) **Parşömen harita yapıldı** (kodla; Erdem kıyının çizilmesini seçti): `harita_cografya.dart` (izdüşüm, Kızıldeniz/Akdeniz kıyıları, dağ süsleri, kervan yolları Mekke–Ebvâ–Yesrib–Busrâ–Şam ve Mekke–San'a), pusula, kıyıya koşut dalga çizgileri; bütün haritada Mekke çevresi çerçeve olarak görünür, dokununca `/harita/mekke` ayrıntı haritası açılır (Hira, Şuaybe, Nahle, Ukâz, Tâif). Web'de telefon ve geniş ekranda denendi; Erdem'in görüşü bekleniyor (boş doğu çölü süslensin mi, dağlar yeterli mi).
 Erdem'in b08 önizleme onayı → commit. Açık: Bahîrâ kıyafet kararı (b08 rahibi de aynı kukuletalı keşiş görünümünde); b08 Erdem kontrolü (`docs/ERDEM_KONTROL.md`). Sonraki metin işi yok (10/10 taslak); sıradaki büyük iş b02-b05 görsel eksikleri ve ses.

0. **2026-11-16: 42 yeni görsel geldi** (`İndirilenler\siyer\yeni\`, ChatGPT ile elle; b02 5, b03 5, b04 12, b05 10, b10 10). Claude kartlarla tek tek denetledi: yeniden üretilecek yok. İşlerken dikkat:
   - `b03-kureys-itiraz`: soldaki üçüncü adamın sol eli ve birkaç bilek yeşil yansımalı; perde silinince zeytin rengi kalıyor, işlerken o bölge yerel olarak düzeltilmeli.
   - `b10-dort-kisi-yakin` ve `b03-yuz-deve`: konu yanlara değiyor; `--sigdir` yerine kırparak (cover) işlenmeli, yoksa kenarda kesik çizgi kalır.
   - `b05-kapida-teslim`: Ümmü Eymen Abdülmuttalib'e değil derine doğru yürüyor gibi; yerleşimde bak.
   - b04'teki Halîme/Hâris/Âmine görselleri referans sayfaları gibi düz keçe dokulu, Abdülmuttalib'li görseller eski kırpılmış referans gibi pürüzlü dokulu; karakter içi tutarlılık tamam.
   - **b02 ve b03 işlendi ve yerleştirildi (2026-11-16), commit'lenmedi, Erdem'in önizleme onayı bekliyor** (`İndirilenler\siyer\_onizleme-b02.jpg`, `_onizleme-b03.jpg`). Hamlar `gorsel-ham/b02`, `b03` (eskiler `-tur1.png`). b02: `b02-col` zemini bütün sahnelerde `ayar.gorsel {0.5, 0.27, 1.56}` ile yukarı alındı (ufuk ~0,66; eskiden 0,80'de altyazının altında kalıyordu); yeni 5 figür ayaklarından zemine oturtuldu. b03: Kâbe'ye b01/b02'deki `ayar.gorsel` eklendi (eksikti, kadrajı dolduruyordu); s02, s03, s05, s06 b01 düzeninde: ana görüntü uzak plan (küçük figür + `mekke-zemin`), 1. parçada kadrajlı orta plan çekimi (`gizle` ile küçük figür gizlenir). Gerçek oynatıcıda (web) b03-s02 çekimi ve b02-s12 denendi, önizlemeyle aynı.
   - Değişmeyen eski b03 katmanları (s04, s07, s09-s12) gözden geçirildi, sorun görülmedi.
   - **Erdem önizlemede bariz sorunlar buldu** (Ebrehe montaj gibi, kuşlar her yerde, develer Kâbe'nin dibinde). Bunun üzerine b02/b03'ün bütün sahneleri, eski katmanlar dahil, bileşim sorularıyla yeniden denetlendi (pafta: `İndirilenler\siyer\_denetim-b02.jpg`, `_denetim-b03.jpg`). Bulgular:
     - **Yeni görsel gerekir:**
       - b02-s01: Ebrehe tahtta; altında zemin yok, şehrin önüne yapıştırılmış gibi. Gereken: avlu ya da salonla tek parça mekân görseli.
       - b02-s11 ve b03-s12: Kâbe kapısı yakın planları birbirine ve `kabe-alcak`'a uymuyor (taş rengi, boy, kapı kanadı). b03-s12'de Abdülmuttalib arkadan değil kameraya dönük. Gereken: `kabe-alcak` ile uyumlu tek bir kapı yakın planı ve figürlerin ayrı katmanı.
       - b03-s06: "evin kapısı önünde" denmiş ama boş vadide. Gereken: küçük bir ev cephesi/kapı nesnesi.
     - **Yerleşimle düzelir:**
       - b02-s13 kuşlar: küçült, ordunun üstüne topla.
       - b03-s05 develer: Kâbe'den ayır, öne yay.
       - b02-s08 Abdülmuttalib–Hunâta dev figürler: uzak plan + çekim düzenine geçir.
       - b02-s10: başın üstü kadraj içinde düz kesik.
       - b03-s04 Hayber kafilesi: dağ sırtında yürüyor, altta mavi şerit boşluk var.
       - b02-s02: kilise San'a'da olmalı ama çölde; San'a evleri arkaya eklenip denenecek.
       - b03 s02/s03/s05/s06: dört sahne aynı geniş açıyla açılıyor; kadraj çeşitlenecek.
     - **Karar bekleyen:** Ebrehe'nin tahtı üç sahnede üç farklı (s01 ahşap sade, s06 taş blok, s09 süslü kırmızı minderli).
     - **Küçük:** b03-s08'de kervan yandan gidiyor, tarif "arkadan uzaklaşan Abdullah" diyor; uzakta seçilmiyor.
   - **Kırpılmış 7 referans API ile yeniden üretildi (2026-11-16, Erdem'in isteği):** Abdülmuttalib, Ebrehe, Abdullah, Vehb, Nüfeyl, Habeşli asker, fil. Kimlik için eski kırpıntı da verildi. Abdullah'ın ilk sayfasında yanaktan sakal göründüğü için ikinci kez üretildi; toplam 8 API görseli (~0,9 $). Yeniler `referans/`'a kondu (eskiler git'te); ham hâlleri `İndirilenler\siyer\referans-yeni\`'de.
   - **2026-11-17: Erdem listeyi onayladı; Ebrehe'nin tahtı için s09'daki (b02-ordugah) taht esas.**
     - 7 yerleşim işi yapıldı (önizleme: `İndirilenler\siyer\_duzeltme-b02.jpg`, `_duzeltme-b03.jpg`):
       - b02-s13: kuşlar ordunun üstünde.
       - b02-s10: kesik baş kadraj dışında.
       - b02-s02 ve s03: kilisenin çevresine `mekke-evler` eklendi. `b02-sana-sehir` kendi dağ ve göğünü taşıdığı için kullanılamadı.
       - b02-s08: uzak plan + çekim.
       - b03-s04: çöl zemini eklendi, kafile yere indi.
       - b03-s05: develer Kâbe'nin sağında; ölçek Kâbe ≈ 2 deve boyu.
       - b03-s02 ve s06: kadraj çeşitlendi.
     - Yeni görsel sayısı 5 çıktı (taht birliği s06'yı da gerektirdi; Kâbe kapısında iki ayrı sahne var). Erdem'in kuralı gereği (3'ten fazlaysa elle) **ChatGPT ile elle** üretilecek: `b02-chatgpt.md` ve `b03-chatgpt.md` (`--tur 3`).
       - b02: `ebrehe-taht` (mekân), `sakif-heyet`, `kapi-dua` (mekân).
       - b03: `abdulmuttalib-kabe` (mekân), `vehb-ev` (yeni nesne).
     - Yeni referanslar: `referans/nesne-taht.png`, `nesne-kabe-alcak.png`, `nesne-mekke-evler.png`. `istem_devir.py` artık `ekle` alanında liste kabul ediyor.
     - Görseller gelince: `b03-vehb-ev` s06'da figürlerin arkasına (ana görüntü + çekim) konacak; `kapi-dua` ve `abdulmuttalib-kabe` tam kadraj mekân (`--opak`).
     - b02-s11'in uzak plan açılışı yok, sahne doğrudan kapıda açılıyor. Gerekirse Kâbe'li uzak plan + çekim düzenine geçirilir.
   - **2026-11-17: 5 görsel geldi, denetlendi (red yok), yerleştirildi.**
     - Mekân çekimleri: b02-s01 (San'a uzak plan → Ebrehe avluda), b02-s11 (Mekke vadisi → kapıda dua; ton kapalı), b03-s12 (vadi → Kâbe'ye giriş). Böylece b02-s11'e de uzak plan açılışı geldi.
     - b02-s06: uzak + çekim. b03-s06: Vehb'in evi grubun arkasında; çekimde ayrı, ölçekli katman.
     - Gerçek oynatıcıda b02-s11 ve b03-s06 çekimleri denendi. Eski ham görseller `gorsel-ham/` altında `-turN` adıyla duruyor.
     - Tam önizleme: `İndirilenler\siyer\_onizleme-b02.jpg`, `_onizleme-b03.jpg`.
     - Erdem onayladı, commit'lendi (`999af09`, `c1fc01e`).
   - **2026-11-17: b04 (12), b05 (10), b10 2. tur (10) görselleri işlendi ve yerleştirildi; Erdem onayladı, commit'lendi.**
     - Önizleme: `İndirilenler\siyer\_onizleme-b04.jpg`, `_onizleme-b05.jpg`, `_onizleme-b10.jpg`.
     - Ortak düzeltmeler: bütün bölümlerde eksik Kâbe `ayar.gorsel` eklendi; Mekke sahnelerine `mekke-zemin` eklendi; orta plan sahneler uzak plan + çekim düzenine geçti.
     - b04-s06: çekimde Âmine'nin kapısı olarak doğum evi (`b03-dogum-evi`) kullanıldı.
     - b05-s05 ve s10: kapı görseli yok; tarifler "evlerin önü" olarak düzeltildi.
     - b05-s07/s08: döşek Kâbe'nin hemen yanında.
     - b10-s03: dört kişi kalabalığın önünde çekimde.
     - b10-s06: Kâbe duvarı önünde Mekke arka planı eklendi.
     - b10-s13/s18: mağaradaki mavi şerit, dağ katmanı uzatılarak kapatıldı.
     - Kendi ışığıyla gelen mekânlarda (b04-s10, b05-s09, b10-s10) saat tonu kapatıldı.
     - **Gece tonu (Erdem onayladı):** oynatıcıya `ayar.ton: "gece"` eklendi; işaretli katman ay ışığına çevrilir (koyu, soğuk, az doygun). İşaretlenenler: b01-s06, b01-s12, b04-s04 (çekim dahil), b09-s09, b10-s02, b10-s13, b10-s18'deki dağ, zemin, ev, Kâbe, mağara ve gündüz figürleri. Ateş ve meşale ışıklı katmanlar (b01-konak, b09 siluetleri) ile kendi ışıklı mekânlar (b03-s07, b03-s09, b05-s09) dokunulmadı. Gerçek oynatıcıda henüz denenmedi.

1. ~~OpenAI API anahtarı~~ (2026-11-15 tamam): `OPENAI_API_KEY` çalışıyor.
2. ~~API üretim betiği~~ (2026-11-15 tamam): `tools/gorsel_uret.py` (yeşil perde varsayılan, `--seffaf` isteğe bağlı). İstem metni `istem_devir.mesaj()` ile ChatGPT dosyasıyla aynı. Üslup görseli `istemler/referans/uslup-u01d.png`. Model karşılaştırması (`b03-on-ogul`): `gpt-image-2.6-sunburst` kazandı (10 oğul tam, Abdullah arkadan, düz yeşil); `chatgpt-image-latest` 9 oğul çizdi, yeşil dokulu. Varsayılan sunburst, `high`.
3. **3 görsellik deneme**: üretildi (`İndirilenler\siyer\b03-on-ogul-api-sunburst.png`, `b02-ordu-yuruyus-api.png`, `b05-kabe-dosek-api.png`). Kusur: b02'de fil sol, son asker sağ kenara değiyor; b05'te soldaki oğul kenara yakın. Sırada: Erdem'in bakışı, sonra sahneye yerleştirme + önizleme.
4. **Karakter referans sayfaları** (10 adet, `karakterler-chatgpt.md`), onaylananlar `content/gorseller/istemler/referans/`'a.
5. **b02 ve b03 düzeltmeleri + yerleşim** (her biri 5 görsel), sonra **b04, b05, b10 2. tur**.
6. ~~b06 Ebû Tâlib'in Himayesi~~ (2026-11-17, taslak): 13 sahne, 20 iddia; kaynak denetçisi bulguları düzeltildi, doğrulama 0 hata. Bahîrâ rivayeti çekinceyle anlatılıyor (Erdem kararı). Erdem'in bakacakları `docs/ERDEM_KONTROL.md` → b06. Görsel istemleri hazır (2026-11-17): `istemler/b06.json`, ChatGPT mesajları `b06-chatgpt.md` (12 görsel, Erdem elle üretecek). Yeni karakter referansları API ile üretildi (3 görsel, ~0,33 $): `karakter-bahira.png`, `karakter-fatima_bint_esed.png`, `karakter-ebu_talib.png` (kimlik için b05 görseli verildi); ChatGPT kitaplığına eklenmeli. Bölüm katmanları dosya adlarına bağlandı, `ayar.gorsel` konumları görseller gelince verilecek. Sonra b07 Gençlik (`/bolum-yaz 7`).

**Maliyet kararı (2026-11-15, Erdem):** 4 API görseli 0,45 dolar tuttu (~0,11 $/görsel). Bütün projeyi API ile bitirmek pahalı; duruma göre bazen API (`gorsel_uret.py`), bazen ChatGPT ile elle (`<bölüm>-chatgpt.md` + `gorsel_al.py`). Hangisinin kullanılacağını her seferinde Erdem söyler; API'yi sormadan toplu çalıştırma.

### Dosya yolları

**Üretilecek görsellerin istemleri** (`content/gorseller/istemler/`):
- `b01.json` … `b10.json`: istem kayıtları (asıl kaynak; API betiği bunları okur).
- `b01-chatgpt.md` … `b10-chatgpt.md`: elle üretim için ChatGPT mesajları (`tools/istem_devir.py <kayıt> --chatgpt [--tur N]` ile yeniden üretilir). Bekleyenler: b03 (yeniden), b04, b05 (tümü), b10 2. tur, b02 düzeltmeleri.
- `karakterler.json` + `karakterler-chatgpt.md`: karakter kartları ve 10 referans sayfasının mesajları (henüz üretilmedi).
- `referans/`: üslup görseli (`uslup-u01d.png`) ve onaylı karakter referansları.

**Erdem'in kontrolünü bekleyenler:**
- `docs/ERDEM_KONTROL.md`: atıf, çeviri ve etiket kararları.
- `İndirilenler\siyer\b03-on-ogul-api-sunburst.png`, `b02-ordu-yuruyus-api.png`, `b05-kabe-dosek-api.png`: API denemeleri (Erdem: "iyi"); sahneye yerleştirme + önizleme bekliyor.
- `İndirilenler\siyer\_kontrol.jpg`: son üretimin paftası.
- `content/gorseller/b03-*.webp` (12 dosya, commit'lenmedi): işlenmiş b03 katmanları, yerleşim ve önizleme bekliyor.
- `content/gorseller/istemler/b02-chatgpt.md`: commit'lenmemiş değişiklik (önceki oturumdan).
- `İndirilenler\siyer\_api_kayit.jsonl`: API kullanım kaydı (token).

Erdem'e yalnız çok önemli kararlar sunulur; küçük görsel farkları yeniden üretilmez (bkz. `docs/GORSEL_URETIM.md`).

## Kısaca

Uygulamanın iskeleti ve MVP ekranlarının çoğu çalışıyor (web derlemesinde denendi, telefonda henüz değil). 10 bölümün 8'i taslak (b01-b06, b09, b10). b01 ve b09'un görselleri tam. b02'nin 19 görseli işlendi ama yerleşimi kusurlu; b03'ün 12'si işlendi, commit'lenmedi. Görsel üretimi yeni yönteme ve OpenAI API'ye geçiyor. Yayını engelleyen işler: içerik doğrulaması, görseller, anlatım sesleri.

**Erdem'in bakacakları:** `docs/ERDEM_KONTROL.md` (atıflar, çeviri ve etiket kararları; her bölümde güncellenir).

---

## 1. Tamamlananlar

### Uygulama (`app/`, Flutter)

| Modül | Dosya | Durum |
|---|---|---|
| Bölüm listesi | `lib/ekranlar/bolum_listesi.dart` | İlerleme çubuğu, "tamamlandı" işareti; harita, zaman çizelgesi, şahıslar, ayarlar girişleri |
| Sahne oynatıcı | `lib/oynatici/` | Katmanlı WebP sahneler, parallax kamera (`kamera.dart`), çapraz geçiş, altyazı, sahne tarifi paneli, bölüm sonu kaynak listesi, sahnedeki şahıslara geçiş düğmesi |
| Görsel yerleşimi | `sahne_cizici.dart` | Tam kadraj katman ya da `ayar.gorsel {x, y, olcek}` ile tek nesne yerleşimi |
| Anlatım sesi | `anlatim_sesi.dart`, `zaman_plani.dart` | `just_audio`; süreler dosyadan okunur, altyazı sese orantılı yayılır, ses yoksa süre metinden tahmin. **Gerçek ses dosyasıyla cihazda denenmedi.** |
| İlerleme takibi | `lib/ilerleme/ilerleme.dart` | Cihazda (shared_preferences); kaldığı sahneden devam, Ayarlar'dan sıfırlama |
| Ayarlar + tam kaynakça | `lib/ekranlar/ayarlar.dart` | Kaynak katmanı ve web adresiyle |
| Şahıslar sözlüğü | `lib/ekranlar/sahislar.dart` | Atıflar bölüm iddialarından; atıfsız kayıtta "kaynak bekliyor" |
| Zaman çizelgesi | `lib/ekranlar/zaman_cizelgesi.dart` | Aynı kaynak kuralı |
| Harita | `lib/ekranlar/harita.dart`, `harita_cografya.dart` | Kodla çizilmiş parşömen: kıyı, dağlar, kervan yolları, pusula; Mekke çevresi ayrı ayrıntı haritası (`/harita/mekke`); etiketler çakışmasız |
| Dil | `lib/l10n/` | Arayüz metinleri TR + EN; içerik yalnız TR |
| Testler | `app/test/` | 47 test, hepsi geçiyor; `flutter analyze` temiz |
| Yayın kapısı | `android/app/build.gradle.kts` | Release derlemesi önce içeriği eşitler, sonra `--yayin` denetimi; hata varsa derleme durur |

### Araçlar (`tools/`)

| Araç | İş |
|---|---|
| `icerik_dogrula.dart` | Şema + kaynak denetimi; `--yayin` ile katı mod (doğrulanmamış atıf, eksik görsel/ses = hata) |
| `icerik_esitle.dart` | `content/` → `app/assets/icerik/` (json, webp, mp3/m4a/ogg) |
| `gorsel_katman.py` | Üretilen görseli şeffaf WebP katmana çevirir (yeşil/mavi perde, `--opak`, `--sigdir`) |
| `istem_devir.py` | İstem kaydından ChatGPT (`--chatgpt`) ya da Higgsfield devir metni üretir; `--tur`, `--atla` |

### İçerik (`content/tr/`)

| Dosya | Durum |
|---|---|
| `bolumler/b01-cahiliye-mekkesi.json` | Taslak: 13 sahne, 21 iddia, 62 atıf (doğrulama bekliyor); bütün görsel katmanları ve 13 yakın plan çekimi hazır |
| `bolumler/b09-hakem.json` | Taslak: 14 sahne, 67 atıf (hepsi doğrulama bekliyor); bütün görsel katmanları hazır |
| `bolumler/b02-fil-vakasi.json` | Taslak: 16 sahne, 19 iddia (doğrulama bekliyor); 19 görsel katmanı işlendi (2026-11-15) ama ölçek/yerleşim kusurlu, düzeltme ve kısmi yeniden üretim bekliyor; kayıt `istemler/b02.json` → `uretimler` |
| `bolumler/b03-dogum.json` | Taslak: 12 sahne, 15 iddia (doğrulama bekliyor); görseller üretilmedi, istemler `istemler/b03.json` + `b03-chatgpt.md` |
| `bolumler/b04-sut-anne.json` | Taslak: 10 sahne, 14 iddia (doğrulama bekliyor); görseller üretilmedi, istemler `istemler/b04.json` + `b04-chatgpt.md` |
| `bolumler/b05-yetimlik.json` | Taslak: 10 sahne, 15 iddia (doğrulama bekliyor); görseller üretilmedi, istemler `istemler/b05.json` + `b05-chatgpt.md` |
| `bolumler/b10-hira.json` | Taslak: 18 sahne, 21 iddia, 62 atıf (doğrulama bekliyor); eski 12 sahnenin görselleri hazır, yeni 6 sahnenin 10 görseli 2. turda (`b10-chatgpt.md`) |
| `sahislar.json` | 14 kayıt |
| `yerler.json` | 11 yer, yaklaşık konum + `konumKaynagi` (TDV, doğrulama bekliyor). Benî Sa'd yurdu kaynakta konum olmadığı için yok |
| `zaman-cizelgesi.json` | 4 kayıt (~440 Dârünnedve, 571 doğum, 605 Kâbe inşası, ~605 Hira inzivâsı) |
| `kaynakca.json` | 6 eser: Kur'an meali (Diyanet Vakfı), İbn Hişâm, Buhârî, Müslim, TDV İA, Hadislerle İslâm |
| `content/gorseller/` | 82 WebP katman (b01, b02, b09, b10 + ortak Mekke/Kâbe katmanları) |
| `content/gorseller/istemler/` | b09 ve b10 istem kayıtları (`b09.json`, `b10.json`) + ChatGPT mesaj dosyaları |

### Kararlaşmış konular

- **Temsil kuralı değişti** (2026-11-14, Erdem): Yüz yasağı yalnız Efendimiz'in eşleri, çocukları, anne-babası ve süt annesi Halîme için. Efendimiz nurla kaplı, asaletli boyda, yeşil sarıklı figür ya da onun gözünden; diğer peygamberler yalnız nur; diğer herkes kaynaktaki betimlemeyle yüzüyle çizilebilir (`docs/GORSEL_USLUP.md`). Mevcut uzak plan katmanlar yeniden üretilmeyecek; yüzler yeni orta/yakın çekimlerde.
- **Sahne içi çekimler** (2026-11-14): Uzun sahnede görüntü tek kalmasın diye `gorsel.cekimler[]`; `kadraj` ana görselin katmanlarını derinlikle orantılı büyütür, böylece yakın çekimde arka plan (evler, Kâbe) uzak çekimle tutarlı kalır (`docs/ICERIK_SEMASI.md`). Yakın plan konu yeni katman olarak üstüne gelir. Aile için el ve kumaş ayrıntısı serbest (Erdem, 2026-11-14).
- **Görsel üslup:** Kâğıt kesik (u01-d). Referans görsel, Higgsfield işi `a5e23296-…`.
- **Görsel üretimi:** ChatGPT Go ile elle. Higgsfield hız sınırı yüzünden bırakıldı.
- **Kaynak politikasında istisna** (2026-11-14): Yaygın kabul görmüş, zayıf bulunmamış rivayet tek güçlü kaynağa dayanabilir (`docs/KAYNAK_POLITIKASI.md` 2.1).
- **s14 oranı:** Yüksek Kâbe görseli alçak hâlin 1,6 katı; kaynak 2 kat diyor. Sapma kabul edildi ve kayıtlı.
- **Bölüm indirme:** MVP'de yapılacak, ama ertelendi. Gerekirse "sunucu yok" ilkesi kaldırılabilir.

---

## 2. Son oturum (2026-11-15, görsel üretim yönteminin yenilenmesi)

1. b02'nin 19 görseli işlendi ama sahnelerde ölçek, havada duran figür ve ışık sorunları çıktı; b03 de aynı. Kök neden: figür görselleri kendi zemini ve binalarıyla, kadrajı dolduracak boyda geliyordu.
2. **Yeni yöntem** (`docs/GORSEL_URETIM.md`): katman tipleri (figür/nesne/zemin/mekân), yapılı istemler (kamera, kişi sayısı, yerleşim, çıktı öncesi denetim), **karakter kartları** (`istemler/karakterler.json`) ve karakter referans sayfaları (`karakterler-chatgpt.md`).
3. İstemler yenilendi: b02 (5 yeniden üretim + 2 Erdem kararına bağlı), b03 (5 yeniden üretim), b04 (12), b05 (10), b10 2. tur (10).
4. `tools/gorsel_al.py`: ChatGPT indirmelerini sırayla adlandırır, otomatik ön denetim yapar, pafta çıkarır.
5. Oynatıcıda saat tonu denemesi (`sahne_cizici.dart` → `saatTonuAcik`).
6. b03'ün 12 görseli `content/gorseller/` altında işlendi ama commit'lenmedi: yerleşim yapılmadı, 5'i yeniden üretilecek.
7. Erdem'in kararları: `docs/ERDEM_KONTROL.md` → "Görseller: karakter kartları ve kararlar".

**Sıradaki:** Erdem karakter referans sayfalarını üretir → Claude onaylar → bölüm istemleri. Sonra b02/b03 yerleşimi yeni katmanlarla baştan.

## 2b. Önceki oturum (2026-11-15, b10 genişletme, b02 ve b03 taslakları)

1. **Yeni çalışma düzeni** (Erdem): Görsel üretimi Erdem'i beklerken Claude sıradaki bölümü uçtan uca hazırlar (metin, iddia, atıf, istem); iddia onayı toplu teslimde yapılır.
2. **b10 genişletildi** (Erdem onayladı): b10 sığ bulundu. Eklenen sahneler:
   - put bayramında ayrılan dört kişi (Varaka, Ubeydullah b. Cahş, Osman b. Hüveyris, Zeyd b. Amr)
   - Zeyd'in Şam yolculuğu
   - Zeyd Kâbe'ye yaslanmış (Esmâ'nın rivayeti)
   - Beldah'ta Efendimiz'le karşılaşma
   - Müslim 2277'deki selâm veren taş

   Aile hayatı (çocuklar, Zeyd b. Hârise, Hz. Ali) b08'e alındı (`BOLUM_HARITASI.md`).
3. **Müslim kaynakçada**; `baski` boş (yayın hatası, Buhârî gibi). Hadis metinleri sunnah.com'dan `kaynaklar/sunnah/README.md`'ye kaydedildi.
4. **Putlar** (Erdem): gölge değil, kaynaktaki tasvire benzer taş figür (`GORSEL_USLUP.md`).
5. **b02 Fil Vakası** yazıldı. Kaynaklar:
   - İbn Hişâm s. 28-36, taramadan okundu
   - FİL VAK'ASI, EBREHE
   - Fîl Sûresi (yerel kopyaya eklendi)
   - Buhârî 2731-2732 (Hudeybiye, "fili durduran")
6. **Denetim:** İki bölüm de `kaynak-denetcisi`nden geçti; bulgular düzeltildi. Başlıcaları:
   - Beldah sofrasında rivayet farkı tarafsız anlatıldı.
   - Görsel istemlerinden kaynaksız yaş, sakal ve mimarî ayrıntıları çıkarıldı.
   - Hudeybiye sözü Hadislerle İslâm çevirisiyle aynen verildi.
   - Kuşların taş sayısı dipnota alındı.
7. **b03 Doğum** yazıldı ve denetlendi. İçerik: nesep (Müslim 2276), Abdülmuttalib'in adağı ve yüz deve, Abdullah ile Âmine'nin evliliği, Abdullah'ın vefatı, Fil Yılı'nda doğum, pazartesi hadisi (Müslim 1162b), Abdülmuttalib'in Kâbe'ye girmesi.
   - Kaynaklar: İbn Hişâm s. 3, 97-103 (taramadan); ABDULLAH, ÂMİNE, MEVLİD, MUHAMMED; Duhâ 93/6.
   - Doğum yılı 571 (Müslümanlar arasında yaygın kabul; Erdem, 2026-11-15); 569/570 dipnotta. b02'ye de işlendi.
   - Olağanüstü rivayetler: Âmine'nin rüyası ihtiyatlı verildi, nur rivayeti dipnotta. 'Evliliğin ilk üç günü' bilgisi klasik dayanak bulunamadığı için çıkarıldı.
   - Temsil: bebek Efendimiz hiç çizilmiyor, nur da kullanılmıyor; s12'de Abdülmuttalib arkadan, Kâbe'ye girerken. Abdullah ve Âmine yüzsüz ya da kadraj dışı.
8. **b04 Süt Annenin Yurdu** yazıldı ve denetlendi: Süveybe, Halîme'nin anlatımı (İbn Hişâm s. 103-107), bereket, sütten kesilme, şakk-ı sadr (Müslim 162c; ŞAKK-ı SADR değerlendirmesi okundu, farklı zaman rivayetleri ve cismanî/ruhanî tartışma dipnotta), Mekke'de kaybolma, Âmine'ye teslim. Çocuk Efendimiz, melek ve olay çizilmiyor; Halîme ve Âmine yüzsüz.
9. **FÎL SÛRESİ** maddesi okundu (yerel kopya `kaynaklar/tdv-metin/fil-suresi.md`); b02'de kuşların taşları i-b02-020 olarak ana metne döndü.
10. **b05 Yetimlik** yazıldı ve denetlendi: Yesrib yolculuğu, Âmine'nin Ebvâ'da vefatı (İbn Hişâm s. 107), Ümmü Eymen, kabir ziyareti (Müslim 976b; istiğfar kısmı ve İbn Sa'd'daki söz anlatıma alınmadı, Erdem'e soruldu), Abdülmuttalib'in döşeği (s. 107-108), vefatı (s. 108), Ebû Tâlib'e vasiyet (s. 114). Tek D kaynağına dayanan ayrıntılar (Dârünnedve, seksen iki yaş, kapalı dükkânlar) denetimden sonra, kızlarından ağıt isteme rivayeti Erdem'in kararıyla çıkarıldı; kabir ziyaretindeki söz alınmadı (Erdem onayı). b04'te Süveybe'ye Buhârî 5101 eklendi; şakk-ı sadr anlatımı Erdem'in kararıyla aynen kaldı.
11. **Yerel araçlar:** İbn Hişâm sayfalarını görüntü olarak okumak için PyMuPDF yalnız scratchpad'e kuruldu (proje bağımlılığı değil). Taramadan okumak OCR'dan çok daha güvenilir.

## Önceki oturum (2026-11-14, anlatıcı sesi denemesi)

1. ElevenLabs MCP bağlandı. Hesap **ücretsiz katman** (ayda 10.000 karakter; 1 karakter ≈ 1 kredi, `eleven_v4`). Üç taslak bölümün anlatımı ~8.800 karakter (b01 4.508, b09 2.851, b10 1.440); 10 bölüm için ~30.000 tahmin.
2. Dört Türkçe erkek sesiyle aynı metin (b10 s01 + s03) üretildi: Halil (`Razqs3wH10dOkbWg5isY`), Serkan Yılmaz (`1rkdtuvNN9rVebRnNiUO`), Seyfullah Kartal (`mF7tIc9VLrznhGooGjaT`) başarılı; Ahmet Esen (`XoPigySk4as5cKgN6BJg`) başarısız.
3. **Engel:** ElevenLabs ücretsiz katmanı "olağandışı etkinlik (VPN/proxy ya da birden çok ücretsiz hesap)" gerekçesiyle kapattı; üretim için ücretli abonelik istiyor. Ayrıca ücretsiz katman ticari olmayan kullanım ve atıf şartı taşır; yayın için zaten ücretli plan gerekebilir (Erdem'in kararı).
4. **Kararlar (Erdem):** Anlatıcı sesi **Seyfullah Kartal** (`mF7tIc9VLrznhGooGjaT`, `eleven_v4`). "(s.a.v.)" düzgün okunuyor; metinde açık yazmaya gerek yok. Erdem Starter paket (aylık 30.000 kredi) almayı düşünüyor. **Ses ekleme işi en sona bırakıldı;** öncelik sahneler, metinler ve kaynaklar.

## Önceki oturum (2026-11-14, yakın planlar)

1. **b01 yakın planları:** 13 görsel denetlendi (temsil kuralına uygun), katmana çevrildi, bölüme çekim olarak bağlandı. s07 parça 2 ve s11 parça 2'deki geçici çekimler yenileriyle değişti. s07 ve s13'teki yakın planlar baş kesilmesin diye `ayar.gorsel` ile aşağı kaydırıldı.
2. **`gorsel_katman.py`:** ChatGPT perdesi bazen koyu geliyor (#00AF46); `SEFFAF_ESIK` 110 → 95. Eski eşikle zemin yarı saydam kalıyordu.
3. **Anlatım sesi kararı** (Erdem): ElevenLabs MCP; olgun, hikâye anlatımına uygun bir erkek sesi.
4. **Beden boyunda nur:** `_nur()`'a `boy` ayarı eklendi; nur, Erdem'in isteğiyle kaba insan biçiminde (yuvarlak baş, omuzlar, aşağı açılan giysi) kenarları bulanık bir ışık oldu; yüz, kol, el yok. Alt ucu zemine basar. b01 s02'de Hz. İbrâhim yetişkin, Hz. İsmâil çocuk boyunda; s04'te ikisi yetişkin boyunda, temel duvarının arkasında. `GORSEL_USLUP.md` §2 ve `ICERIK_SEMASI.md` güncellendi.

## Önceki oturum (2026-11-13 / 14)

1. **b09 görselleri:**
   - Üslup seçildi; 5 turda ChatGPT ile üretildi.
   - Yüz ayrıntısı olan kalabalıklar ve fotoğraf gibi çıkanlar yeniden ürettirildi.
   - Yeşil perde temizliği iyileştirildi.
   - Bütün katmanlar `gorsel-ham/`'dan yeniden üretilebilir.
2. **Uygulama:**
   - Eklenenler: ilerleme takibi, Ayarlar ve kaynakça, şahıslar sözlüğü, zaman çizelgesi, parşömen harita, anlatım sesi altyapısı.
   - Android yayın kapısı kuruldu.
   - Aralıklı düşen bir test düzeltildi.
3. **İçerik:**
   - `yerler.json` eklendi.
   - b10 "Hira'nın Eşiği" taslağı `/bolum-yaz` ile yazıldı ve `kaynak-denetcisi` ile denetlendi.
   - b10'un görsel istemleri hazırlandı.
4. **Yöntem dersi:** Not defteri (Gemini Notebook) b10'da yanlış künye verdi ve kaynakta olmayan ayrıntılar ekledi. Atıflar yerel metinlerden okunmalı (bkz. §6).

---

## 3. Eski sıradaki adımlar (2026-11-15 öncesi; güncel liste en üstte)

Sahibi parantez içinde.

1. **Sıradaki oturum, ilk iş (Claude):**
   - **Erdem gelince:** b10 2. tur (10 görsel, `b10-chatgpt.md`) ve b02 (19 görsel, `b02-chatgpt.md`) üretimi; sonra katmana çevirip bağlamak (Claude).
   - **b02 ve b10 iddialarının toplu gözden geçirilmesi** (Erdem). Karar bekleyenler:
     - Müslim 2277 ve Zeyd'in duasının Türkçesi (bizim çeviri)
     - Beldah rivayet farkı (uzman okumasında sorulmalı)
     - Nüfeyl'in sözünün çevirisi
   - **Erdem'in kararı:** b03'te i-b03-015'in (Abdülmuttalib'in Kâbe'ye girmesi; tek ve çekinceli C kaynağı) 'guclu' etiketi; Müslim 2276 ve 1162b Türkçesi; MEVLİD'in 'Sıyâm 197' numarası ile sunnah.com 1162b farkı.
   - **Sıradaki bölüm** (Claude): b06 Ebû Tâlib'in Himayesi (Lihbli kâhin, Şam yolculuğu, Bahîrâ; İbn Hişâm s. 114-117). Sikâye konusunda İbn Hişâm s. 114 ile EBÛ TÂLİB maddesi farklı.
2. **Atıf doğrulaması** (Erdem): b01'de 62, b02'de 60, b03'te 47, b09'da 67, b10'da 62 atıf (dipnot kaynakları dahil). b01 teslim notu: iddiaların `gerekce` alanları; İbn Hişâm s. 50-51, 76, 79-80, 219 taramadan okunmalı; Buhârî atıfları (Enbiyâ 8, 9; Menâkıb 1) ikincil kaynaktan.
   - b01: Hâcer ve Cürhüm ayrıntıları ZEMZEM (c. 44 s. 242) ve ARAP (c. 3 s. 273) ile ikinci kaynağa bağlandı; Sâib'e öğüt ikinci kaynak bulunamadığı için çıkarıldı (2026-11-14, Erdem'in yetkisiyle).
   - b01 Kâbe: Kusay dönemi (s08-s10) hurma dallarıyla örtülü `kabe-ortulu` (KÂBE s. 16); Abdülmuttalib dönemi ve b09 çatısız `kabe-alcak` (İbn Hişâm s. 122).
   b10 teslim notu: `b10-hira.json` iddialarının `gerekce` alanları.
   - İbn Hişâm sayfaları tarama sıra numarası; taramadan görülmeli.
   - MUHAMMED (c. 30) s. 410, Hadislerle İslâm dipnotundan alındı; matbu nüshada bakılmalı.
   - Buhârî numaraları yalnız Hadislerle İslâm'da görüldü.
3. **Kaynakçada Buhârî'nin `baski` alanı** (Erdem): Yayın hatası.
4. **Sonraki bölüm** (Claude, `/bolum-yaz <no>`): Sıra önerisi b06 → b08. b01 (2026-11-14), b02-b05 (2026-11-15) yazıldı. Her bölümde atıflar yerel kaynaklardan.
5. **Anlatım sesleri** (Claude, en sona): ElevenLabs, Seyfullah Kartal sesi. Bütün bölümlerin metni ve kaynakları oturduktan sonra toplu üretilecek. Önce Erdem'in ücretli plana geçmesi gerek (ücretsiz katman kapalı); lisans şartları kayda geçecek.

---

## 4. Açık kararlar ve sorular

| Konu | Not |
|---|---|
| Bölüm indirme barındırması | Seçenekler: Play Asset Delivery + Apple ODR (sunucu ilkesi korunur), Cloudflare Pages, GitHub Releases, R2. İçerik yükleme yalnız `app/lib/icerik/depo.dart` üzerinden geçer |
| Anlatım sesi üretimi | Karar: ElevenLabs, Seyfullah Kartal sesi; en sona bırakıldı (Erdem, 2026-11-14). Açık: plan (Starter düşünülüyor) ve lisans şartları |
| Müzik ve ortam sesi | JSON'da adlar var (`muzik`, `ortam`); oynatıcıda henüz çalınmıyor |
| Parşömen harita | Kodla çizildi (2026-11-19); görsel üretimi gerekmedi |
| Uzman okuması | Bölümler yayın için uzmana okutulmalı (`KAYNAK_POLITIKASI` §6); kim? |
| Müslim | Kaynakçada yok; b10'da Müslim atfı bu yüzden kullanılmadı |

---

## 5. Bilinen sorunlar ve ertelenenler

- **`istemler/b10.json` → `b10-yokus`:** istem s12, s15, s17 için yazılmış ama yalnız s12 kullanıyor (yeniden numaralamadan önce de böyleydi).
- **s07 (b09):** Yarım Kâbe yokuş katmanının zemininin arkasında kalıyor.
- **s01 ve s14 (b09):** Ufuk boyunca hafif zeytin yeşili bir çizgi seçiliyor.
- **Gece sahnelerinde dağlar (b01 s12; b10 s07, s12; b09 gece sahneleri):** `mekke-daglar` gündüz tonunda; yıldızlı gök altında aydınlık duruyor. Gece varyantı ya da oynatıcıda `saat`e göre karartma gerekli.
- **b01 görsel adları:** ChatGPT'den inen dosyalardan dördünün adı kaymıştı (hanif ↔ konak ↔ kervan-cikis ↔ iki-ittifak). `gorsel-ham/b01/`'de düzeltildi; `İndirilenler\siyer`'deki adlar hâlâ yanlış. Yeni partide işlemeden önce içerik adla eşleşiyor mu bak.
- **Eski katmanlarda perde kalıntısı olabilir:** b01/b09/b10'un önceki katmanları `SEFFAF_ESIK` 110 ile çevrildi; perdesi koyu gelenlerde zemin hafif yarı saydam kalmış olabilir (yeni yakın planlarda dosya boyutu yarıya indi). `gorsel-ham/`'dan yeniden çevirip karşılaştırmak gerek.
- **Şerit katmanlar:** Zemin şeridi görselin altında olan katmanlar (kervan, çadır, konak) tam kadrajda altyazının altına düşüyor; b01'de `ayar.gorsel {x 0.5, y 0.35–0.45, olcek 1.2}` ile yukarı kaydırıldı.
- **b01 s04:** Temel taşları ön planda büyük; altyazı üstüne biniyor, kabul edilebilir.
- **b10 s04:** Hira görselinde istenmeden mağara ağzı var; uzak planda, sorun sayılmadı.
- **Görsel çözünürlüğü:** ChatGPT 1536 px veriyor, katman 2304 px; görseller 1,5 kat büyütülüyor. Yakın kamera hareketinde hafif yumuşaklık olabilir.
- **Gerçek cihaz testi yapılmadı:** Yalnız web derlemesi ve headless Chrome ekran görüntüleri.
- **iOS:** Hiç denenmedi. Yayın kapısı da yalnız Android Gradle'da.
- **"Hata bildir" bağlantısı** (`KAYNAK_POLITIKASI` §7) yok.
- **Bağış bağlantısı** yok.

---

## 6. Çalışma notları (yeni oturum için)

- **Kur'an meali:** Diyanet sitesi (Flutter uygulaması) meal seçimini otomasyona açmıyor; `browser_fetch_once` varsayılan "Diyanet Vakfı" mealini verir. b01 ve sonrası bu meali kullanır (`kuran-meal-dv`); eski yerel dosya Başkanlık meali.
- **Kaynak bulma yöntemi:**
  1. Not defterine toplu soru sor, ama cevabı yalnız yol gösterici say.
  2. Atfı şuradan oku: `kaynaklar/tdv-metin/*.md` (künye dosya başında, sayfa için `kaynaklar/tdv/dizin.csv` ve matbu PDF), `kaynaklar/ibn-hisam/…-ocr.md` (Arapça, düzeltilmemiş OCR; tarama sayfa no = atıf sayfası), `kaynaklar/Hadislerle_islam/*.pdf` (`pdftotext` ile; bu PDF'lerde "i/ı" harfleri metne çıkmıyor).
- **Görsel akışı:**
  1. `istemler/bXX.json`'a istem yaz.
  2. `tools/istem_devir.py … --chatgpt` ile mesaj dosyasını üret.
  3. Erdem ChatGPT'de üretip `İndirilenler\siyer`'e kaydeder.
  4. Hamı `gorsel-ham/bXX/`'a kopyala.
  5. `tools/gorsel_katman.py` ile çevir.
  6. Bölüme bağla.
  7. `dart run tools/icerik_esitle.dart` → `flutter build web` → headless Chrome ile ekran görüntüsü al.
- **ChatGPT'nin eğilimleri:**
  - Uzun sohbette üsluptan kayıyor; yeni sohbet aç.
  - Kalabalıklarda yüz ayrıntısı ekliyor; "far away and small" ve düz koyu yüz iste.
  - İstenmeyen yapı ekliyor: merdiven, iskele, bitmiş Kâbe.
- **Nur tonu:** Altın-beyaz yalnız nura ayrılmış. Nur istemeyen istemlerde yasak (`istem_devir.py` bunu otomatik ekler).
- **Efekt katmanları:** `toz` ve `nur` görsel almaz; oynatıcı çizer.
- **Komutlar:** `CLAUDE.md` → Komutlar. Web önizleme: `cd app && flutter build web`, sonra `build/web` klasörünü bir HTTP sunucusuyla aç.

---

## 7. MVP kontrol listesi ve tam sürüm

`YOL_HARITASI.md`'ye taşındı.
