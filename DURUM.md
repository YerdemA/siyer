# Proje Durumu

Son güncelleme: 2026-11-14. Her çalışma oturumunun sonunda güncellenir. Kurallar `CLAUDE.md`'de, ayrıntılar `docs/` altında; bu dosya yalnız **nerede olduğumuzu** anlatır.

**Kısaca:** Uygulamanın iskeleti ve MVP ekranlarının çoğu çalışıyor (web derlemesinde denendi, telefonda henüz değil). 10 bölümün 3'ü taslak hâlinde yazıldı (b01, b09, b10); üçünün de görselleri bağlandı. Yayını engelleyen işler büyük ölçüde içerik doğrulaması ve anlatım sesleri.

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
| `bolumler/b10-hira.json` | Taslak: 12 sahne, 12 iddia, 35 atıf (doğrulama bekliyor); bütün görsel katmanları hazır |
| `sahislar.json` | 14 kayıt |
| `yerler.json` | 11 yer, yaklaşık konum + `konumKaynagi` (TDV, doğrulama bekliyor). Benî Sa'd yurdu kaynakta konum olmadığı için yok |
| `zaman-cizelgesi.json` | 3 kayıt (~440 Dârünnedve, 605 Kâbe inşası, ~605 Hira inzivâsı) |
| `kaynakca.json` | 5 eser: Kur'an meali (Diyanet Vakfı), İbn Hişâm, Buhârî, TDV İA, Hadislerle İslâm |
| `content/gorseller/` | 63 WebP katman (b01, b09, b10 + ortak Mekke/Kâbe katmanları) |
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

## 2. Son oturum (2026-11-14, yakın planlar)

1. **b01 yakın planları:** 13 görsel denetlendi (temsil kuralına uygun), katmana çevrildi, bölüme çekim olarak bağlandı. s07 parça 2 ve s11 parça 2'deki geçici çekimler yenileriyle değişti. s07 ve s13'teki yakın planlar baş kesilmesin diye `ayar.gorsel` ile aşağı kaydırıldı.
2. **`gorsel_katman.py`:** ChatGPT perdesi bazen koyu geliyor (#00AF46); `SEFFAF_ESIK` 110 → 95. Eski eşikle zemin yarı saydam kalıyordu.
3. **Anlatım sesi kararı** (Erdem): ElevenLabs MCP; olgun, hikâye anlatımına uygun bir erkek sesi.

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

## 3. Sıradaki adımlar

Sahibi parantez içinde.

1. **Sıradaki oturum, ilk iş (Claude):**
   - **Nuru beden boyunda yap** (Erdem, 2026-11-14): Diğer peygamberlerin nuru (s02, s04) tek nokta değil, ayakta bir insan boyunda, dikey uzunca yumuşak bir ışık olsun ki varlıkları gerçekçi sezilsin. İnsan hatları, baş, kol çizilmez; yalnız boy. `yer_tutucu.dart` `_nur()`'a dikey biçim (ör. `ayar.boy`) ekle; zemine basan alt ucu ve boyu sahnedeki insan ölçeğine (kervan, evler) göre ayarla; s02'de İsmâil küçük çocuk boyunda. `docs/GORSEL_USLUP.md` §2'deki "yalnız parıltı" tarifini "beden boyunda, hatları olmayan nur" olarak güncelle.
2. **Atıf doğrulaması** (Erdem): b01'de 62, b09'da 67, b10'da 35 atıf. b01 teslim notu: iddiaların `gerekce` alanları; İbn Hişâm s. 50-51, 76, 79-80, 219 taramadan okunmalı; Buhârî atıfları (Enbiyâ 8, 9; Menâkıb 1) ikincil kaynaktan.
   - b01: Hâcer ve Cürhüm ayrıntıları ZEMZEM (c. 44 s. 242) ve ARAP (c. 3 s. 273) ile ikinci kaynağa bağlandı; Sâib'e öğüt ikinci kaynak bulunamadığı için çıkarıldı (2026-11-14, Erdem'in yetkisiyle).
   - b01 Kâbe: Kusay dönemi (s08-s10) hurma dallarıyla örtülü `kabe-ortulu` (KÂBE s. 16); Abdülmuttalib dönemi ve b09 çatısız `kabe-alcak` (İbn Hişâm s. 122).
   b10 teslim notu: `b10-hira.json` iddialarının `gerekce` alanları.
   - İbn Hişâm sayfaları tarama sıra numarası; taramadan görülmeli.
   - MUHAMMED (c. 30) s. 410, Hadislerle İslâm dipnotundan alındı; matbu nüshada bakılmalı.
   - Buhârî numaraları yalnız Hadislerle İslâm'da görüldü.
3. **Kaynakçada Buhârî'nin `baski` alanı** (Erdem): Yayın hatası.
4. **Sonraki bölüm** (Claude, `/bolum-yaz <no>`): Sıra önerisi b02 → b08. b01 yazıldı (2026-11-14). Her bölümde atıflar yerel kaynaklardan.
5. **Anlatım sesleri** (Claude): ElevenLabs MCP ile (Erdem, 2026-11-14). Olgun, hikâye anlatımına uygun erkek sesi seçilip Erdem'e dinletilecek; lisans ve ücretsiz kullanım şartları kayda geçecek. MCP sunucusu bu oturumda bağlı değildi; kurulması gerek.

---

## 4. Açık kararlar ve sorular

| Konu | Not |
|---|---|
| Bölüm indirme barındırması | Seçenekler: Play Asset Delivery + Apple ODR (sunucu ilkesi korunur), Cloudflare Pages, GitHub Releases, R2. İçerik yükleme yalnız `app/lib/icerik/depo.dart` üzerinden geçer |
| Anlatım sesi üretimi | Karar: ElevenLabs MCP, olgun erkek anlatıcı sesi (Erdem, 2026-11-14). Açık: hangi ses, lisans ve ticari olmayan/ücretsiz kullanım şartları |
| Müzik ve ortam sesi | JSON'da adlar var (`muzik`, `ortam`); oynatıcıda henüz çalınmıyor |
| Parşömen harita illüstrasyonu | Zemin şimdilik kodla çiziliyor; görsel üretimi bekliyor |
| Uzman okuması | Bölümler yayın için uzmana okutulmalı (`KAYNAK_POLITIKASI` §6); kim? |
| Müslim | Kaynakçada yok; b10'da Müslim atfı bu yüzden kullanılmadı |

---

## 5. Bilinen sorunlar ve ertelenenler

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

## 7. MVP kontrol listesi

MVP = peygamberlik öncesi dönem, 10 bölüm, Türkçe, Android.

### Uygulama
- [x] Bölüm oynatıcı (katman, kamera, geçiş, altyazı)
- [x] Bölüm sonu kaynak listesi
- [x] Ayarlar'da tam kaynakça
- [x] Şahıslar sözlüğü
- [x] Zaman çizelgesi
- [x] Harita ekranı (geçici zemin)
- [x] İlerleme takibi
- [x] Anlatım sesi altyapısı
- [ ] Anlatım sesiyle gerçek cihazda deneme
- [ ] Müzik ve ortam sesi çalma
- [ ] Bölümlerin tek tek indirilmesi ve çevrimdışı çalışması (barındırma kararı bekliyor)
- [ ] Parşömen harita illüstrasyonu
- [ ] "Hata bildir" bağlantısı
- [ ] İsteğe bağlı bağış bağlantısı
- [ ] Uygulama simgesi, açılış ekranı, mağaza görselleri
- [ ] Android imzalama (`key.properties`) ve Play Store kaydı
- [ ] Gerçek cihazlarda test (en az bir telefon ve bir tablet)

### İçerik (bölüm başına: taslak → görseller → atıf doğrulama → ses → uzman okuması → `yayinda`)

| Bölüm | Taslak | Görsel | Atıf doğrulama | Ses | Uzman |
|---|---|---|---|---|---|
| b01 Câhiliye Mekke'si | ✓ | ✓ | 0/62 | – | – |
| b02 Fil Vakası | – | – | – | – | – |
| b03 Doğum | – | – | – | – | – |
| b04 Süt Annenin Yurdu | – | – | – | – | – |
| b05 Yetimlik | – | – | – | – | – |
| b06 Ebû Tâlib'in Himayesi | – | – | – | – | – |
| b07 Gençlik | – | – | – | – | – |
| b08 el-Emîn | – | – | – | – | – |
| b09 Hakem | ✓ | ✓ | 0/67 | – | – |
| b10 Hira'nın Eşiği | ✓ | ✓ | 0/35 | – | – |

### Yan veriler ve yayın kapısı
- [ ] Kaynakçada Buhârî `baski` alanı
- [ ] Her bölümün şahıs, yer ve zaman çizelgesi kayıtları (b09–b10 var)
- [ ] `yerler.json` konum atıflarının doğrulanması
- [ ] `dart run tools/icerik_dogrula.dart --yayin` → 0 hata (Buhârî baskısı; b09–b10'da ses ve atıf doğrulaması)

---

## 8. Tam sürüm (MVP sonrası)

- **İngilizce:** İçerik (`content/en/`, aynı kimlikler) ve İngilizce anlatım sesi; Ayarlar'da dil seçimi. Arayüz metinleri zaten iki dilde.
- **Dönemler** (`docs/BOLUM_HARITASI.md`): Mekke dönemi (ilk vahiy → hicret), Medine dönemi (hicret → Hudeybiye), Fetih ve vedâ. Her dönem ayrı sürüm ve ayrı not defteri.
- **iOS:** Derleme, test, App Store; yayın kapısının iOS karşılığı.
- **Kaynakça büyümesi:** İbn Sa'd, Taberî, Müslim ve diğer Kütüb-i Sitte; baskı bilgileriyle.
- **Uzman okuması süreci** ve "Hakkında"da okuyanların listesi.
- **Sürüm notlarında hata düzeltme kaydı** (`KAYNAK_POLITIKASI` §7).
