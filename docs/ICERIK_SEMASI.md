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
| `ses` | `{ "anlatim": "b03-s02.mp3", "muzik": "huzun-01", "ortam": "col-ruzgari" }` |
| `sahislar[]`, `yer` | `sahislar.json` ve `yerler.json` kimlikleri |

Kural: İçinde tarihî bilgi olan her `anlatim` parçasının `iddialar` listesi dolu olmalıdır. Geçiş cümleleri boş bırakılabilir.

### Görsel ve katmanlar

- `saat`: `safak` / `gunduz` / `aksam` / `gece` — ışık ve renk tonu.
- `katmanlar[]`: uzaktan yakına sıralı. `{ "id", "dosya", "yerTutucu", "derinlik", "ayar" }`
  - `dosya`: katmanın WebP görseli (şeffaf arka planlı), `content/gorseller/` altındaki dosya adı (ör. `b09-s01-daglar.webp`). Görseller dilden bağımsızdır. Boşsa ya da dosya bulunamazsa oynatıcı `yerTutucu` tipine göre geçici bir çizim yapar. Görsel 16:9 kadrajdan her yöne %10 taşar (toplam %120).
  - `derinlik`: 0 (en uzak, gökyüzü) – 1 (en yakın). Kamera hareketi yakın katmanları daha çok kaydırır (parallax).
  - `ayar`: yer tutucuya özel isteğe bağlı ayarlar (konum, ölçek, sayı). Gerçek görsel gelince gereksizleşir.
    - İstisna `ayar.gorsel`: `{ "x", "y", "olcek" }`. Tek nesne görselini (ör. Kâbe) tam kadraj yerine yerleştirir: görselin merkezi kadrajda (`x`, `y`) noktasına (0–1) gelir, genişliği kadraj genişliğinin `olcek` katıdır, yüksekliği görselin oranından gelir. Böyle görseller `tools/gorsel_katman.py --sigdir` ile kırpılmadan hazırlanır.
- `kamera`: `yavas-yaklasma`, `yavas-uzaklasma`, `yatay-kayma`, `sabit`, `sabit-gecis`, `yukaridan-yavas-donus`, `yukaridan-yukselis`, `bakis-acisi-yuruyus`, `bakis-acisi-giris`, `donus-kapiya`. Tanımları: `app/lib/oynatici/kamera.dart`.

### İddia

| Alan | Açıklama |
|---|---|
| `id` | `i-b03-004` |
| `ifade` | İddianın tek cümlelik, yalın hali |
| `guc` | `kesin` / `guclu` / `ihtilafli` / `zayif` |
| `gerekce` | Gücün neye göre belirlendiği |
| `kaynaklar[]` | Aşağıda |
| `alternatifRivayetler[]` | `{ "ifade": "...", "kaynaklar": [...] }` — dipnot olarak gösterilir |

### Kaynak kaydı

| Alan | Açıklama |
|---|---|
| `eser` | `kaynakca.json` kimliği (ör. `ibn-hisam-sire`) |
| `konum` | `c. 1, s. 158` ya da `Bed'ü'l-vahy, 3`. Ansiklopedide madde adı tırnak içinde: `Salim Öğüt, "HACERÜLESVED", c. 14, s. 433`; farklı maddeler ayrı kaynak sayılır. Matbu sayfası olmayan dijital baskıda: `c. 2, dipnot 1578 (PDF s. 434)` |
| `dogrulama` | `bekliyor` / `dogrulandi` |
| `dogrulayan`, `tarih` | `dogrulandi` ise zorunlu |

## Diğer dosyalar

- `kaynakca.json`: `{ id, yazar, eser, baski, katman (A–E), dil, erisim }`
- `sahislar.json`: `{ id, ad, lakap, yakinlik, ozet, bolumler[], iddialar[] }`
- `yerler.json`: `{ id, ad, harita: { x, y }, ozet, bolumler[], iddialar[] }` — harita gerçek harita değil, ahşap/parşömen illüstrasyonudur. `x`, `y` parşömen üzerindeki yaklaşık konumdur (0–1, sol üst köşe 0,0). Konum göreli olduğundan atıf gerektirmez, ama yerlerin birbirine göre durumu (ör. Cidde'nin Mekke'nin batısında, kıyıda olması) kaynaklarla çelişmemelidir. `ozet` içindeki tarihî bilgi `iddialar` ile bağlanır.
- `zaman-cizelgesi.json`: `{ id, yil (miladî, yaklaşık ise "yaklasik": true), hicriOncesi, olay, bolum, iddia }`

## Doğrulama betiği (`tools/icerik_dogrula.dart`)

Şunları denetler:

1. Her anlatım parçasındaki iddia kimliği bölümde tanımlı
2. Her iddianın en az bir kaynağı var ve `eser` kimliği kaynakçada mevcut
3. `guc: zayif` olan iddia hiçbir `anlatim` parçasına bağlı değil
4. `durum: yayinda` olan bölümde `dogrulama: bekliyor` yok ve `uzmanOkumasi` dolu
5. Şahıs ve yer kimlikleri mevcut
6. Diller arasında bölüm, sahne ve iddia kimlikleri eşleşiyor
