# Yol Haritası

Projenin genel planı: hangi aşamadayız, MVP'ye ve tam sürüme ne kaldı. Günlük durum ve sıradaki adımlar `DURUM.md`'de; kurallar `CLAUDE.md`'de; bölüm içerikleri `docs/BOLUM_HARITASI.md`'de.

Son güncelleme: 2026-11-15.

---

## Aşamalar

| # | Aşama | Durum |
|---|---|---|
| 0 | Altyapı: Flutter iskeleti, oynatıcı, içerik şeması, doğrulama araçları | ✓ Tamam |
| 1 | MVP içerik: 10 bölümün kaynaklı metni | 10/10 taslak |
| 2 | Görseller: yöntem, karakter kartları, üretim | Yöntem yenilendi; OpenAI API'ye geçiliyor |
| 3 | Atıf doğrulaması (Erdem) ve uzman okuması | Başlamadı |
| 4 | Anlatım sesi, müzik, ortam sesi | Ses kararı verildi (ElevenLabs); en sona |
| 5 | Yayın hazırlığı: Android, mağaza, cihaz testi | Başlamadı |
| 6 | Tam sürüm: İngilizce, sonraki dönemler, iOS | MVP sonrası |

---

## MVP: peygamberlik öncesi dönem, 10 bölüm, Türkçe, Android

### İçerik
Bölüm başına sıra: taslak → görseller → atıf doğrulama → ses → uzman okuması → `yayinda`.

| Bölüm | Taslak | Görsel | Atıf doğrulama | Ses | Uzman |
|---|---|---|---|---|---|
| b01 Câhiliye Mekke'si | ✓ | ✓ | 0/62 | – | – |
| b02 Fil Vakası | ✓ | 19 işlendi; 5 yeniden + yerleşim | 0/60 | – | – |
| b03 Doğum | ✓ | 12 işlendi (commit'siz); 5 yeniden + yerleşim | 0/47 | – | – |
| b04 Süt Annenin Yurdu | ✓ | istem (yeni yöntem) | 0/45 | – | – |
| b05 Yetimlik | ✓ | istem (yeni yöntem) | 0/42 | – | – |
| b06 Ebû Tâlib'in Himayesi | ✓ | ✓ | 0/50 | – | – |
| b07 Gençlik | ✓ | ✓ | 0/73 | – | – |
| b08 el-Emîn | ✓ | 11 istem, 3 kart (API) | 0/73 | – | – |
| b09 Hakem | ✓ | ✓ | 0/67 | – | – |
| b10 Hira'nın Eşiği | ✓ | 12/18 sahne; 10 istem | 0/62 | – | – |

### Görsel üretimi (aşama 2)
- [x] Yeni yöntem: katman tipleri, yapılı istem, karakter kartları (`docs/GORSEL_URETIM.md`)
- [x] Kabul edilmiş karakterler için kırpılmış referanslar (`content/gorseller/istemler/referans/`)
- [x] OpenAI API hesabı ve 10 dolar kredi (Erdem, 2026-11-15)
- [ ] API anahtarının ortam değişkenine kaydı ve doğrulanması
- [ ] API ile üretim betiği (`tools/gorsel_uret.py`): istem → API → şeffaf PNG → adlandırma → denetim → pafta
- [ ] 3 görsellik deneme: `b03-on-ogul`, `b02-ordu-yuruyus`, `b05-kabe-dosek`
- [ ] 10 karakter referans sayfası
- [ ] b02 ve b03 düzeltmeleri, sahne yerleşimi (uzak plan + kadraj çekimi)
- [ ] b04, b05, b10 2. tur
- [ ] b06–b08 görselleri (b06, b07 tamam; b08 ChatGPT'de üretilecek)
- Tahmini: ~100 görsel, yeniden üretimlerle 150–200 üretim, ~10–30 dolar.

### Uygulama
- [x] Bölüm oynatıcı (katman, kamera, geçiş, altyazı)
- [x] Bölüm sonu kaynak listesi
- [x] Ayarlar'da tam kaynakça
- [x] Şahıslar sözlüğü
- [x] Zaman çizelgesi
- [x] Harita ekranı (geçici zemin)
- [x] İlerleme takibi
- [x] Anlatım sesi altyapısı
- [x] Saat tonu (deneme; akşam ve şafak)
- [ ] Anlatım sesiyle gerçek cihazda deneme
- [ ] Müzik ve ortam sesi çalma
- [ ] Bölümlerin tek tek indirilmesi ve çevrimdışı çalışması (barındırma kararı bekliyor)
- [ ] Parşömen harita illüstrasyonu
- [ ] "Hata bildir" bağlantısı
- [ ] Uygulama simgesi, açılış ekranı, mağaza görselleri
- [ ] Android imzalama (`key.properties`) ve Play Store kaydı
- [ ] Gerçek cihazlarda test (en az bir telefon ve bir tablet)

### Yan veriler ve yayın kapısı
- [ ] Kaynakçada Buhârî ve Müslim `baski` alanı
- [ ] Her bölümün şahıs, yer ve zaman çizelgesi kayıtları (b09–b10 var)
- [ ] `yerler.json` konum atıflarının doğrulanması
- [ ] `dart run tools/icerik_dogrula.dart --yayin` → 0 hata

---

## Tam sürüm (MVP sonrası)

- **İngilizce:** İçerik (`content/en/`, aynı kimlikler) ve İngilizce anlatım sesi; Ayarlar'da dil seçimi. Arayüz metinleri zaten iki dilde. Görseller dilden bağımsız, yeniden üretilmez.
- **Dönemler** (`docs/BOLUM_HARITASI.md`): Mekke dönemi (ilk vahiy → hicret), Medine dönemi (hicret → Hudeybiye), Fetih ve vedâ. Her dönem ayrı sürüm ve ayrı not defteri. Bütün siyer için tahminen ~1.500 görsel üretimi (100–200 dolar).
- **Bağış bağlantısı:** İsteğe bağlı; MVP'de yok (Erdem, 2026-11-19).
- **iOS:** Derleme, test, App Store; yayın kapısının iOS karşılığı.
- **Kaynakça büyümesi:** İbn Sa'd, Taberî, Müslim ve diğer Kütüb-i Sitte; baskı bilgileriyle.
- **Uzman okuması süreci** ve "Hakkında"da okuyanların listesi.
- **Sürüm notlarında hata düzeltme kaydı** (`KAYNAK_POLITIKASI` §7).
