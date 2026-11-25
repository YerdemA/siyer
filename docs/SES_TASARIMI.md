# Fon müziği ve ortam sesi

Kararlar (Erdem, 2026-11-25): müzik MVP'de; çalgılı, sade belgesel müziği; Ayarlar'da "Müzik ve ortam sesi" ile kapatılabilir. Sesler ElevenLabs ile üretilir, her parçayı Erdem dinleyip onaylar; toplu üretimden önce sorulur.

## Oynatıcıda

- İki kanal: müzik (düzey 0,16) ve ortam (0,32); anlatım 1. `lib/oynatici/fon_sesi.dart`.
- Sahnenin `ses.muzik` / `ses.ortam` adı → `content/fon/muzik/<ad>.mp3`, `content/fon/ortam/<ad>.mp3`. Uygulamaya gömülür (`tools/icerik_esitle.dart`), bütün dillerde ortak.
- Döngüde çalar. Ad değişince eskisi 1,8 sn'de kısılarak biter, yenisi açılarak başlar; aynı ad sahne geçişinde kesilmez. Duraklatınca hemen susar, bölüm sonunda susar.
- Dosya yoksa o kanal sessiz kalır; doğrulama betiği eksikleri uyarı (yayında hata) olarak listeler.
- Düzeyler telefonda dinlenip ayarlanacak.

## Dosya biçimi

- MP3, 44,1 kHz, stereo ya da mono, 128 kbps. Anlatım sesindeki kural burada da geçerli: ElevenLabs çıktısına işlem yapılmaz (kesme dışında). Döngü dikişi duyulursa yalnız uçlar kısa bir kısma/açmayla birleştirilir, Erdem onaylarsa.
- Müzik: 90–120 sn, enstrümantal (`instrumental: true`), sonu başına bağlanabilir (aynı akor, sakin bitiş).
- Ortam: 30 sn, ses efekti modelinin `loop: true` seçeneğiyle (dikişsiz döngü).
- Toplam boyut hedefi ~20 MB (11 müzik × ~1,5 MB + 13 ortam × ~0,5 MB).

## Lisans

ElevenLabs ücretli planlarında üretilen sesin ticari kullanım hakkı var; uygulama ücretsiz ve reklamsız olsa da Play'de yayımlandığı için **üretimden önce planın müzik kullanım koşulu kontrol edilecek** (Starter planda Music için kısıt olabilir). Kaynakça gibi Ayarlar → Hakkında'da "Müzik ve ortam sesleri: ElevenLabs ile üretildi" satırı.

## Kredi hesabı (2026-11-25, ElevenLabs fiyat sayfasına göre)

- Müzik ~900 kredi/dk; ses efekti süre verilince 40 kredi/sn. Her deneme ayrı ücretlenir.
- Tablodaki süreler (müzik 8×90 + 3×120 sn = 18 dk; ortam 13×30 sn): müzik ~16.200 + ortam ~15.600 = **~31.800 kredi** (tek deneme). Yeniden üretimlerle ~45.000.
- Tasarruflu plan (öneri): müzik 60 sn (11 dk ≈ 9.900), ortam 15 sn döngü (13×15×40 ≈ 7.800) = **~17.700 kredi**; yeniden üretim payıyla ~25.000, Starter'ın bir aylık kredisine sığar. Starter'da aylık müzik indirme sınırı 30 dk (18 dk yeter).
- Eleven Music koşulları (Starter): çevrimiçi/çevrimdışı ticari kullanım izinli, film/TV/radyo/stüdyo oyunları hariç; dağıtımda "Eleven Music" ile üretildiği belirtilmeli → Ayarlar → Hakkında'ya satır. Yayından önce güncel koşul sayfası yeniden okunacak.

## Kredi

2026-11-25: Starter plan, 39.331 kredinin 39.107'si kullanılmış; yenilenme ~2026-12-21. Üretim yenilenmeden sonra ya da plan yükseltilince. Her parçayı tek tek üret, dinlet, onay al (`generations_count` 1).

## Müzik (11)

Ortak ek her isteme: *Instrumental only, no vocals, no choir, no percussion kit, no drums. Calm documentary underscore that sits beneath a spoken narrator: sparse, low register, slow, no melody that competes with speech. Middle Eastern / Arabian 6th-century atmosphere with ney (reed flute), oud and soft low string drone; no modern synths. Seamless loop: ends on the same chord and texture it begins with.*

| Ad | Sahne | Süre | İstem |
|---|---|---|---|
| `acilis` | 6 | 90 sn | Opening of an episode: a slow, spacious ney phrase over a warm low drone, like dawn over a desert valley; dignified and gentle. |
| `dusunceli` | 34 | 120 sn | Reflective, contemplative: soft oud arpeggios with long pauses, a quiet low drone; neutral, neither sad nor happy. |
| `sakin-isik` | 23 | 120 sn | Serene and luminous: high soft strings and a gentle ney, sense of peace and quiet light. |
| `sicak-ev` | 13 | 90 sn | Warm, intimate, domestic: plucked oud and soft frame-drum heartbeat (very light), tender family warmth. |
| `umut` | 9 | 90 sn | Gentle hope: a slowly rising ney melody over warm strings, quietly uplifting, never triumphant. |
| `yalnizlik` | 9 | 90 sn | Loneliness and loss: a single ney with long silences over a very low drone, restrained grief, not melodramatic. |
| `gerilim-hafif` | 16 | 90 sn | Light unease: low sustained strings with slow dissonant swells, a distant muted pulse; tension without threat. |
| `gerilim` | 10 | 90 sn | Rising danger: deep low strings, slow ominous pulse, darker oud tremolo; restrained, cinematic, no horror. |
| `yolculuk` | 4 | 120 sn | Journey by caravan: a steady slow rhythm like camels walking (soft hand drum), oud melody, wide open desert. |
| `husu` | 6 | 90 sn | Awe and prayer: very still, a long soft drone and a few sparse ney notes, reverent and quiet. |
| `kapanis` | 4 | 90 sn | Closing of an episode: a calm resolved phrase on oud and ney over strings, gentle sense of completion. |

## Ortam (13)

Ortak ek: *Natural ambience only, no music, no voices speaking words, no modern sounds (no engines, no birdsong of non-desert species). Seamless loop.*

| Ad | Sahne | İstem |
|---|---|---|
| `ruzgar` | 30 | Soft steady desert wind over open ground, occasional light gusts. |
| `col-ruzgari` | 9 | Stronger dry desert wind with fine sand hissing across rocks. |
| `safak` | 20 | Quiet desert dawn: very light breeze, a few distant sparrows, stillness. |
| `gece` | 11 | Desert night in a small town: crickets, faint breeze, a distant dog once, deep quiet. |
| `sehir-gunduz` | 8 | Small ancient Arabian town by day: distant indistinct voices, a goat bleating, footsteps on gravel, a wooden door. |
| `aksam-sehir` | 19 | Evening in a small ancient town: low distant murmur, a fire crackling somewhere, settling sounds, a light breeze. |
| `kalabalik` | 20 | Crowd gathered outdoors in a courtyard: indistinct low murmuring of many people, no clear words. |
| `kalabalik-gergin` | 2 | Tense crowd outdoors: agitated low murmuring, shuffling feet, occasional raised indistinct voice. |
| `kervan` | 4 | Camel caravan passing in the distance: soft camel bells, hooves on sand, creaking ropes and leather. |
| `ordu` | 6 | Ancient army camp and march: many footsteps, clinking of spears and leather, distant camel and elephant sounds, no battle. |
| `ic-mekan` | 3 | Inside a quiet stone room: faint room tone, cloth rustling, a small oil lamp flickering. |
| `deniz` | 1 | Calm sea shore: gentle waves on a sandy beach, light wind. |
| `insaat` | 2 | Ancient construction: stone blocks being placed, chisels and picks on stone, distant workers' indistinct voices. |
