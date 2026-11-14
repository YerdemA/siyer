# Proje Durumu

Son güncelleme: 2026-11-15. Her çalışma oturumunun sonunda güncellenir. Kurallar `CLAUDE.md`'de, ayrıntılar `docs/` altında; bu dosya yalnız **nerede olduğumuzu** anlatır.

**Kısaca:** Uygulamanın iskeleti ve MVP ekranlarının çoğu çalışıyor (web derlemesinde denendi, telefonda henüz değil). 10 bölümün 5'i taslak hâlinde yazıldı (b01, b02, b03, b09, b10). b01 ve b09'un görselleri tam; b10'un 10 yeni görseli, b02'nin 19 ve b03'ün 12 görseli istemi hazır, üretim bekliyor. Yayını engelleyen işler büyük ölçüde içerik doğrulaması ve anlatım sesleri.

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
| `bolumler/b02-fil-vakasi.json` | Taslak: 16 sahne, 19 iddia (doğrulama bekliyor); görseller üretilmedi, istemler `istemler/b02.json` + `b02-chatgpt.md` |
| `bolumler/b03-dogum.json` | Taslak: 12 sahne, 15 iddia (doğrulama bekliyor); görseller üretilmedi, istemler `istemler/b03.json` + `b03-chatgpt.md` |
| `bolumler/b10-hira.json` | Taslak: 18 sahne, 21 iddia, 62 atıf (doğrulama bekliyor); eski 12 sahnenin görselleri hazır, yeni 6 sahnenin 10 görseli 2. turda (`b10-chatgpt.md`) |
| `sahislar.json` | 14 kayıt |
| `yerler.json` | 11 yer, yaklaşık konum + `konumKaynagi` (TDV, doğrulama bekliyor). Benî Sa'd yurdu kaynakta konum olmadığı için yok |
| `zaman-cizelgesi.json` | 4 kayıt (~440 Dârünnedve, ~570 Fil Yılı ve doğum, 605 Kâbe inşası, ~605 Hira inzivâsı) |
| `kaynakca.json` | 6 eser: Kur'an meali (Diyanet Vakfı), İbn Hişâm, Buhârî, Müslim, TDV İA, Hadislerle İslâm |
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

## 2. Son oturum (2026-11-15, b10 genişletme, b02 ve b03 taslakları)

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
   - Olağanüstü rivayetler: Âmine'nin rüyası ihtiyatlı verildi, nur rivayeti dipnotta. 'Evliliğin ilk üç günü' bilgisi klasik dayanak bulunamadığı için çıkarıldı.
   - Temsil: bebek Efendimiz hiç çizilmiyor, nur da kullanılmıyor; s12'de Abdülmuttalib arkadan, Kâbe'ye girerken. Abdullah ve Âmine yüzsüz ya da kadraj dışı.
8. **FÎL SÛRESİ** maddesi okundu (yerel kopya `kaynaklar/tdv-metin/fil-suresi.md`); b02'de kuşların taşları i-b02-020 olarak ana metne döndü.
9. **Yerel araçlar:** İbn Hişâm sayfalarını görüntü olarak okumak için PyMuPDF yalnız scratchpad'e kuruldu (proje bağımlılığı değil). Taramadan okumak OCR'dan çok daha güvenilir.

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

## 3. Sıradaki adımlar

Sahibi parantez içinde.

1. **Sıradaki oturum, ilk iş (Claude):**
   - **Erdem gelince:** b10 2. tur (10 görsel, `b10-chatgpt.md`) ve b02 (19 görsel, `b02-chatgpt.md`) üretimi; sonra katmana çevirip bağlamak (Claude).
   - **b02 ve b10 iddialarının toplu gözden geçirilmesi** (Erdem). Karar bekleyenler:
     - Müslim 2277 ve Zeyd'in duasının Türkçesi (bizim çeviri)
     - Beldah rivayet farkı (uzman okumasında sorulmalı)
     - Nüfeyl'in sözünün çevirisi
   - **Erdem'in kararı:** b03'te i-b03-015'in (Abdülmuttalib'in Kâbe'ye girmesi; tek ve çekinceli C kaynağı) 'guclu' etiketi; Müslim 2276 ve 1162b Türkçesi; MEVLİD'in 'Sıyâm 197' numarası ile sunnah.com 1162b farkı.
   - **Sıradaki bölüm** (Claude): b04 Süt Annenin Yurdu (Halîme; şakk-ı sadr için D değerlendirmesi önce okunmalı).
2. **Atıf doğrulaması** (Erdem): b01'de 62, b02'de 60, b03'te 47, b09'da 67, b10'da 62 atıf (dipnot kaynakları dahil). b01 teslim notu: iddiaların `gerekce` alanları; İbn Hişâm s. 50-51, 76, 79-80, 219 taramadan okunmalı; Buhârî atıfları (Enbiyâ 8, 9; Menâkıb 1) ikincil kaynaktan.
   - b01: Hâcer ve Cürhüm ayrıntıları ZEMZEM (c. 44 s. 242) ve ARAP (c. 3 s. 273) ile ikinci kaynağa bağlandı; Sâib'e öğüt ikinci kaynak bulunamadığı için çıkarıldı (2026-11-14, Erdem'in yetkisiyle).
   - b01 Kâbe: Kusay dönemi (s08-s10) hurma dallarıyla örtülü `kabe-ortulu` (KÂBE s. 16); Abdülmuttalib dönemi ve b09 çatısız `kabe-alcak` (İbn Hişâm s. 122).
   b10 teslim notu: `b10-hira.json` iddialarının `gerekce` alanları.
   - İbn Hişâm sayfaları tarama sıra numarası; taramadan görülmeli.
   - MUHAMMED (c. 30) s. 410, Hadislerle İslâm dipnotundan alındı; matbu nüshada bakılmalı.
   - Buhârî numaraları yalnız Hadislerle İslâm'da görüldü.
3. **Kaynakçada Buhârî'nin `baski` alanı** (Erdem): Yayın hatası.
4. **Sonraki bölüm** (Claude, `/bolum-yaz <no>`): Sıra önerisi b04 → b08. b01 (2026-11-14), b02 ve b03 (2026-11-15) yazıldı. Her bölümde atıflar yerel kaynaklardan.
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
| b02 Fil Vakası | ✓ | istem | 0/60 | – | – |
| b03 Doğum | ✓ | istem | 0/47 | – | – |
| b04 Süt Annenin Yurdu | – | – | – | – | – |
| b05 Yetimlik | – | – | – | – | – |
| b06 Ebû Tâlib'in Himayesi | – | – | – | – | – |
| b07 Gençlik | – | – | – | – | – |
| b08 el-Emîn | – | – | – | – | – |
| b09 Hakem | ✓ | ✓ | 0/67 | – | – |
| b10 Hira'nın Eşiği | ✓ | 12/18 sahne | 0/62 | – | – |

### Yan veriler ve yayın kapısı
- [ ] Kaynakçada Buhârî ve Müslim `baski` alanı
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
