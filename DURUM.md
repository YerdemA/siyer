# Proje Durumu

**Claude Code: oturuma başlarken ilk bu dosyayı oku.** Son yapılanlar ve sıradaki adımlar burada. Genel plan `YOL_HARITASI.md`'de, kurallar `CLAUDE.md`'de. Oturum sonunda bu dosyayı güncelle.

Son güncelleme: 2026-11-18.

## Sıradaki adımlar (öncelik sırasıyla)

**Kaldığımız yer (2026-11-18).** b06'nın 12 görseli geldi, işlendi ve yerleştirildi; Erdem onayladı, commit'lendi (önizleme `İndirilenler\siyer\_onizleme-b06.jpg`; paftadaki nur kaba bir taklit, oynatıcıdakinden sert görünür).

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
- **Sonra:** b08 el-Emîn (`/bolum-yaz 8`).

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
| Harita | `lib/ekranlar/harita.dart` | Kodla çizilmiş **geçici** parşömen; yerler `yerler.json`'dan, etiketler çakışmasız |
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
| Parşömen harita illüstrasyonu | Zemin şimdilik kodla çiziliyor; görsel üretimi bekliyor |
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
