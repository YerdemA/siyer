# Proje Durumu

**Claude Code: oturuma başlarken ilk bu dosyayı oku.** Son yapılanlar ve sıradaki adımlar burada. Genel plan `YOL_HARITASI.md`'de, kurallar `CLAUDE.md`'de. Oturum sonunda bu dosyayı güncelle.

Son güncelleme: 2026-11-22.

## Sıradaki adımlar (öncelik sırasıyla)

**Erdem'in telefon notları işlendi (2026-11-22, gece; Play Console'da henüz proje yok, sürüm yüklenmedi).**
- **Sahne düzeltmeleri** (yalnız katman yerleşimi, görsel değişmedi): b06-s07 kervan zemine indi (`y .42→.53`, `olcek .62→.66`); b09-s09 halka + duvar + kap birlikte aşağı ve küçük (arka sıra evlerin önündeki zemine basıyor); b09-s10 kalabalık iki evin arasındaki geçitte, uzak plan (`x .515, y .668, olcek .16`, derinlik `.7→.42` geçitle birlikte kaysın diye). Önizleme betiği oynatıcının yerleşim hesabını kopyalar (geçici; oturum klasöründe). Bütün bölümlerin ana görselleri paftayla tarandı: kesin hata yok; Erdem bakmalı: **b09-s07** (soldaki kaya havada gibi), **b04-s01** (öndeki küçük kervan yerine göre küçük). Çekimler (`cekimler[]`) taranmadı.
- **Ekran kapanınca bölüm sürer** (yalnız ekran kapanınca; başka uygulamaya geçince yine durur). Ekran kapalıyken kare çizilmediği için saati 100 ms'lik zamanlayıcı ilerletir (`Timer.tick` ile; harita geçişi atlanır, ilerleme hemen kaydedilir), `PARTIAL_WAKE_LOCK` (en çok 30 dk; bitince/durunca bırakılır) sahne aralarındaki sessizlikte işlemci uyumasın diye. Oynarken ekran kendiliğinden kararmaz (`FLAG_KEEP_SCREEN_ON`). Köprü: `lib/oynatici/ekran.dart` ↔ `MainActivity.kt` (`siyer/ekran`). Manifest'e `WAKE_LOCK` (normal izin, Play beyanı gerekmez). Ön plan servisi/kilit ekranı kontrolleri yok: Xiaomi gibi agresif pil yönetimli telefonlarda uzun süre ekran kapalıyken sistem uygulamayı durdurabilir; olursa `audio_service` paketi (Erdem onayı) gerekir.
- **Harita geçişi** yalnız bölümün kalanında (o sahne dahil) en az iki sahnenin geçtiği yere açılır (`kaliciYer`); tek sahnelik uğrak (b03-s09 Yesrib kabri) ne gidişte ne dönüşte harita açtırır.
- **Ana sayfa ve oynatıcı dışı her ekran dikey** (`main.dart`); oynatıcı kapanınca dikeye döner.
- Gizlilik metni (indirme Google Play'den; uyanık tutma izni, e-posta) yayında: https://yerdema.github.io/siyer-gizlilik/ . Mağaza ekran görüntüleri `magaza/ekran-goruntuleri/` (4 adet). Sıradaki: Play Console adımları (`magaza/MAGAZA_METINLERI.md` sonu), hedef kitle kararı. Not: harita sekmesinde dikeyde üst/alt siyah boşluk var. Testler 89/89.

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
- Telefon testi 2: ses düzgün (v2 doğrulandı). Bölüm sonu yumuşatıldı: son sahne 4 sn sürer, son 3 sn görüntü kararır, sonra bölüm adı kartı, ardından kaynaklar. Anlatıcı sesindeki ani iniş çıkışlar `tools/ses_dengele.py` ile giderildi (hafif sıkıştırıcı + -16 LUFS; sahneler arası fark 5,5 dB → 0, iç dalgalanma en çok 7,9 → 3,7 LU). Yeni seslerden sonra bu betik çalıştırılmalı. APK: `siyer-sesli-b01-b04-v3.apk` — telefonda doğrulanmadı.
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
  - Gerçek oynatıcıda (web) henüz denenmedi. Ham görseller `gorsel-ham/b08`, kayıt `istemler/b08.json` → `uretimler`; `yeni\` boşaltıldı, görseller `arsiv08\`.
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
