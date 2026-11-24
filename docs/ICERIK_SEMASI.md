# İçerik Şeması

Tüm içerik `content/<dil>/` altında JSON olarak durur. Kimlikler (id) dilden bağımsızdır; İngilizce eklenirken aynı id'ler kullanılır.

```
content/tr/
  bolumler/b01-cahiliye-mekkesi.json ...
  sahislar.json
  yerler.json
  zaman-cizelgesi.json
  kaynakca.json
```

## Bölüm dosyası

Örnek: `content/tr/bolumler/_ornek.json`

| Alan | Açıklama |
|---|---|
| `id` | `b03-dogum` biçiminde |
| `sira` | Bölüm numarası |
| `baslik`, `ozet` | Kullanıcıya görünen metin |
| `durum` | `taslak` → `kaynak-dogrulandi` → `uzman-okudu` → `yayinda` |
| `uzmanOkumasi` | `{ "okuyan": "", "tarih": "" }` |
| `sahneler[]` | Sıralı sahneler |
| `iddialar[]` | Bölümdeki her tarihî bilgi |

### Sahne

| Alan | Açıklama |
|---|---|
| `id` | `b03-s02` |
| `anlatim[]` | `{ "metin": "...", "iddialar": ["i-b03-004"] }` — her anlatım parçası dayandığı iddiaları gösterir |
| `gorsel` | `{ "tarif": "...", "saat": "gunduz", "katmanlar": [...], "kamera": "yavas-yaklasma" }` — aşağıda |
| `ses` | `{ "anlatim": "b03-s02.mp3", "muzik": "huzun-01", "ortam": "col-ruzgari" }`  Anlatım sesi dil başınadır: `content/<dil>/ses/<dosya>`; **ElevenLabs çıktısı olduğu gibi** (MP3 44,1 kHz 128 kbps mono). Hiçbir işlem yapılmaz: sıkıştırma, seviye eşitleme, yeniden kodlama yok (Erdem, 2026-11-24; işlenmiş ses anlatıcının sesini bozuyordu). İsteğe bağlı `duraklar: [{ "an": 6.45, "sure": 6.0 }]`: oynatıcı sesi dosyanın `an`. saniyesinde `sure` saniye bekletir, görüntü akmaya devam eder (izleyici olayı sindirsin, kamera hareketi sığsın; ör. b04-s07). Dosya değişmez. `an` bir sessizliğin ortasına konur, yoksa kelime kesilir: `ffmpeg -i <ses> -af silencedetect=noise=-40dB:d=0.12 -f null -` ile bulunur. Parça süreleri yine sesin içinde kelime sayısıyla paylaştırılır, duraklar bölüm zamanına eklenir; durak bir parçanın ortasındaysa altyazı durak boyunca kalır. Sahne başına bir dosya; süresi uygulama açılınca dosyadan okunur, JSON'a yazılmaz. Dosya yoksa süre metinden tahmin edilir; yayın denetimi bunu hata sayar. |
| `sahislar[]`, `yer` | `sahislar.json` ve `yerler.json` kimlikleri. `sahislar` şahıslar sözlüğünü açar (izleyici bir şahsı ancak onun geçtiği sahneyi görünce sözlükte görür). `yer` oynatıcıdaki harita geçişini belirler: bölüm başında ve uzak bir yere geçilince harita araya girer (Mekke çevresindeki yerler arası hariç); boş `yer` öncekini korur |

Kural: İçinde tarihî bilgi olan her `anlatim` parçasının `iddialar` listesi dolu olmalıdır. Geçiş cümleleri boş bırakılabilir.

### Görsel ve katmanlar

- `saat`: `safak` / `gunduz` / `aksam` / `gece` — ışık ve renk tonu.
- `katmanlar[]`: uzaktan yakına sıralı. `{ "id", "dosya", "yerTutucu", "derinlik", "ayar" }`
  - `dosya`: katmanın WebP görseli (şeffaf arka planlı), `content/gorseller/` altındaki dosya adı (ör. `b09-s01-daglar.webp`). Görseller dilden bağımsızdır. Boşsa ya da dosya bulunamazsa oynatıcı `yerTutucu` tipine göre geçici bir çizim yapar. Görsel 16:9 kadrajdan her yöne %10 taşar (toplam %120).
  - Efekt katmanları (`yerTutucu`: `toz`, `nur`) görsel almaz; oynatıcı kendisi çizer. Doğrulama betiği bunları eksik görsel saymaz. `nur` ayarları: `x`, `y` (merkez, 0–1), `r` (yarıçap, kadraj genişliğine oranla), `guc` (varsayılan 1; açık gündüz zemininde 2–3 verilir, yoksa parıltı seçilmez). Diğer peygamberler için `boy` (yükseklik, kadraj yüksekliğine oranla) verilir: nur o boyda, kaba insan biçiminde (baş, omuz, giysi; kenarlar bulanık) bir ışık olur, `x`, `y` alt ucudur (zemine bastığı yer), `r` (omuz yarı genişliği) verilmezse boydan hesaplanır. Nurun `derinlik`'i bastığı zeminle aynı olmalı, yoksa kamera kayarken zeminde süzülür; bir nesnenin arkasında duracaksa katman listesinde o nesneden önce gelir. Hz. Muhammed'in nurlu figürü için `boy` ile birlikte `"kim": "efendimiz"` verilir: aynı biçim, gövdesi seçilen, kenarları yumuşak, zemine ışık düşüren parlak bir nur olur; peygamberlik öncesinde sarık çizilmez (GORSEL_USLUP.md §1).
  - `derinlik`: 0 (en uzak, gökyüzü) – 1 (en yakın). Kamera hareketi yakın katmanları daha çok kaydırır (parallax).
  - `ayar`: yer tutucuya özel isteğe bağlı ayarlar (konum, ölçek, sayı). Gerçek görsel gelince gereksizleşir.
    - İstisna `ayar.gorsel`: `{ "x", "y", "olcek" }`. Tek nesne görselini (ör. Kâbe) tam kadraj yerine yerleştirir: görselin merkezi kadrajda (`x`, `y`) noktasına (0–1) gelir, genişliği kadraj genişliğinin `olcek` katıdır, yüksekliği görselin oranından gelir. Böyle görseller `tools/gorsel_katman.py --sigdir` ile kırpılmadan hazırlanır.
    - İstisna `ayar.ton`: oynatıcının saat tonu. Gündüz katmanları nötr ışıkta üretilir; şafak ve akşamda oynatıcı tonlar, gece tonlamaz. `false`: kendi ışığıyla üretilmiş katman (kandil ışıklı oda) hiç tonlanmaz. `"gece"`: gece sahnesindeki gündüz ışıklı katman (ortak dağ, zemin, ev, Kâbe ya da gündüz üretilmiş figür) ay ışığına çevrilir; meşale ve ateş ışıklı katmanlara verilmez.
- `kamera`: `yavas-yaklasma`, `yavas-uzaklasma`, `yatay-kayma`, `sabit`, `sabit-gecis`, `yukaridan-yavas-donus`, `yukaridan-yukselis`, `bakis-acisi-yuruyus`, `bakis-acisi-giris`, `donus-kapiya`. Tanımları: `app/lib/oynatici/kamera.dart`.
- `cekimler[]` (isteğe bağlı): Uzun sahnede görüntü tek kalmasın diye ana görselden sonra gelen çekimler. Her biri `{ "parca", "tarif", "saat", "katmanlar", "kamera" }`. `gorsel`'in kendisi ilk çekimdir.
  - `parca`: Çekimin başladığı anlatım parçasının sırası (0'dan sayılır; 1 ile parça sayısı − 1 arasında olmalı, çekimden çekime artmalı). Çekim o cümle başlarken tam görünür; 0,8 sn'lik çapraz geçiş cümleden hemen önce biter. Sesli sahnede de aynı kural geçerlidir, parça süreleri sesten gelir.
  - `saat` verilmezse sahnenin saati kullanılır. Kamera her çekimde baştan başlar.
  - `an` (isteğe bağlı, 0–1, varsayılan 0): çekimin parçanın içinde başladığı yer, parça süresine oranla (0,5 = cümlenin ortası). Parça süresi sesten geldiği için saniye yerine oran. `an` ile `parca` 0 da olabilir (ilk cümlenin içinde); `parca` + `an` çekimden çekime artmalı. Kısa çekimlerle hızlı diziler kurmak için (ör. b04-s07 göz dizisi).
  - `gecis` (isteğe bağlı, saniye, 0,2–5): bu çekime geçişin süresi (varsayılan 0,8). Geçiş çekimin başından önce biter. Geçişi öncekinin geçişiyle üst üste binen çekim atlanır.
  - `yol` (isteğe bağlı): `{ "bas": {x, y, yakinlik}, "son": {x, y, yakinlik}, "egri": "yumusak" | "duz" }`. Verilirse `kamera` yerine kamera çekim boyunca (geçişi dahil) `bas` kadrajından `son`'a gider: (x, y) noktası (kadraja göre 0–1; tam dolu görselde görselin dinlenik kadrajı) ekranın ortasına gelir, `yakinlik` kat büyütülür. Bütün katmanlara aynı uygulanır (parallax yok), böylece "sol gözden sağ göze" gibi kesin hareketler yazılır. Yakınlık oranla değişir (yaklaşma hızı göze sabit). `duz`: doğrusal hız; art arda çekimlerde kayma kesilmesin diye. `yumusak` (varsayılan): başta ve sonda yavaşlar.
  - **Fark edilmeyen geçiş** (yakınlaşarak bir yüzden göz yakın planına): giden çekimin `yol.son`'u ile gelen çekimin `yol.bas`'ı aynı şeyi aynı boyda göstermeli (ör. giden görselde çocuğun gözleri, gelen görselde aynı gözler aynı yerde), ve uzun bir `gecis` (1,5–2,5 sn) verilir; iki görsel üst üste binerken kamera ikisinde de aynı yönde hareket eder.
  - `kadraj` (önerilen): `{ "x", "y", "yakinlik" }`. Çekim ana görselin katmanlarını devralır; (`x`, `y`) noktası (ana görsele göre 0–1) kadrajın ortasına gelir, katmanlar `yakinlik` kadar, derinlikleriyle orantılı büyütülür (gök az, ön plan çok). Böylece yakın çekimde arka plan (dağlar, evler, Kâbe) uzak çekimdekiyle aynı yerde kalır. `gizle: ["kalabalik"]` ana görselden çekimde görünmeyecek katmanları çıkarır (ör. uzak plandaki küçük kervan); çekimin kendi `katmanlar`ı (yakın plan konu) en üste, kadrajsız çizilir.
  - `kadraj` yoksa çekim yalnız kendi `katmanlar`ını çizer (tamamen farklı bir görüntü için).
  - Önceki çekime geçiş süresinden yakın düşen ya da sahne sonuna sığmayan çekim oynatıcıda atlanır; doğrulama betiği geçersiz `parca`'yı hata sayar.
  - Revize için: `#/bolum/<id>?sahne=3&cekim=2&dur=1` 3. sahnenin 2. çekiminde durmuş açılır.

### İddia

| Alan | Açıklama |
|---|---|
| `id` | `i-b03-004` |
| `ifade` | İddianın tek cümlelik, yalın hali |
| `guc` | `kesin` / `guclu` / `ihtilafli` / `zayif` |
| `gerekce` | Gücün neye göre belirlendiği |
| `kaynaklar[]` | Aşağıda |
| `alternatifRivayetler[]` | `{ "ifade": "...", "kaynaklar": [...] }` — dipnot olarak gösterilir |
| `istisna` | İsteğe bağlı. `"tek-kaynak"`: iddia tek bir D kaynağına dayanır (`KAYNAK_POLITIKASI` §2.1 istisnası); `gerekce` kaynağın klasik dayanağını göstermeli. Doğrulama betiği bunu hata değil uyarı sayar |

### Kaynak kaydı

| Alan | Açıklama |
|---|---|
| `eser` | `kaynakca.json` kimliği (ör. `ibn-hisam-sire`) |
| `konum` | `c. 1, s. 158` ya da `Bed'ü'l-vahy, 3`. Ansiklopedide madde adı tırnak içinde: `Salim Öğüt, "HACERÜLESVED", c. 14, s. 433`; farklı maddeler ayrı kaynak sayılır. Matbu sayfası olmayan dijital baskıda: `c. 2, dipnot 1578 (PDF s. 434)` |
| `dogrulama` | `bekliyor` / `dogrulandi` |
| `dogrulayan`, `tarih` | `dogrulandi` ise zorunlu |

## Diğer dosyalar

- `kaynakca.json`: `{ id, yazar, eser, baski, katman (A–E), dil, erisim }`
- `sahislar.json`: `{ id, ad, lakap, yakinlik, ozet, bolumler[], iddialar[], portre?, temsil? }` — `portre`: `gorseller/` altında madalyon görseli (`tools/portre_kirp.py` karakter kartından kırpar). `temsil`: `nur` (Efendimiz, diğer peygamberler, melek) ya da `yuzsuz` (anne-babası, eşleri, çocukları, süt anneleri); bunlara portre konmaz (CLAUDE.md kural 5).
- `yerler.json`: `{ id, ad, harita: { x, y }, ozet, bolumler[], iddialar[] }` — harita gerçek harita değil, ahşap/parşömen illüstrasyonudur. `x`, `y` parşömen üzerindeki yaklaşık konumdur (0–1, sol üst köşe 0,0); yeni yer eklerken enlem-boylamdan `docs/GORSEL_USLUP.md` → Harita'daki izdüşümle hesaplanır, yoksa kıyıyla örtüşmez. Konum göreli olduğundan atıf gerektirmez, ama yerlerin birbirine göre durumu (ör. Cidde'nin Mekke'nin batısında, kıyıda olması) kaynaklarla çelişmemelidir. `ozet` içindeki tarihî bilgi `iddialar` ile bağlanır. İsteğe bağlı `konumKaynagi` (atıf biçiminde: `eser`, `konum`, `dogrulama`), konumun kaynaktaki yön/uzaklıkla uyumunu kontrol etmek içindir; konum yine yaklaşıktır. Kaynakta konumu bulunmayan yer haritaya konmaz.
- `zaman-cizelgesi.json`: `{ id, yil (miladî, yaklaşık ise "yaklasik": true), hicriOncesi, olay, bolum, iddia }`

## Bölüm paketleri (indirme)

Bölüm JSON'ları, kaynakça, sözlük, harita ve zaman çizelgesi her zaman uygulamayla gelir. Ses ve görsellerde ise:

- **Uygulamaya gömülü** (`app/assets/icerik/`): ilk bölümün (`b01`) kullandığı her ses ve görsel (Mekke gök/dağ/zemin/evler gibi ortak arka planlar dahil) ve şahıs portreleri.
- **Bölüm paketi** (`app/android/paketler/<paket>/`, Play Asset Delivery, isteğe bağlı): o bölümün kullanıp uygulamada olmayan ses ve görselleri. Paket adı bölüm kimliğinin ilk parçasıdır (`b02-fil-vakasi` → `b02`). Birden çok bölümün kullandığı görsel her birinin paketine kopyalanır; her paket tek başına yeter.

Dağıtımı `tools/icerik_esitle.dart` bölüm JSON'larındaki dosya adlarından hesaplar; paketlerin Gradle modüllerini ve `paketler.json` (paket boyutları) dosyasını da o üretir. Hiçbir bölümün kullanmadığı medya dosyası uygulamaya alınmaz. Paket içindeki yol gömülü kopyadaki yolla aynıdır (`<paket>/gorseller/x.webp` ↔ `assets/icerik/gorseller/x.webp`). Gömülü bölümler betikte `gomuluBolumler`, uygulamada `gomuluPaketler` (`app/lib/icerik/paketler.dart`) ile aynı tutulmalıdır.

Uygulama bölüm açılınca paketi indirir; inen paket internetsiz çalışır, Ayarlar'dan silinebilir. iOS karşılığı (On-Demand Resources) henüz yok.

## Doğrulama betiği (`tools/icerik_dogrula.dart`)

Şunları denetler:

1. Her anlatım parçasındaki iddia kimliği bölümde tanımlı
2. Her iddianın en az bir kaynağı var ve `eser` kimliği kaynakçada mevcut
3. `guc: zayif` olan iddia hiçbir `anlatim` parçasına bağlı değil
4. `durum: yayinda` olan bölümde `dogrulama: bekliyor` yok ve `uzmanOkumasi` dolu
5. Şahıs ve yer kimlikleri mevcut
6. Diller arasında bölüm, sahne ve iddia kimlikleri eşleşiyor
