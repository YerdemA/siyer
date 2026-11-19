# Uygulama simgesi ve açılış ekranı taslakları

Taslaktır; seçim Erdem'in. Renkler uygulamanın paletinden (`app/lib/tema.dart` → `Palet`):
parşömen, mürekkep, kına kırmızısı, şafak altını, gece laciverdi.

- Hepsine bir arada bakmak için: `onizleme.html` (tarayıcıda aç) ya da `onizleme.png`.
- Kaynaklar SVG; PNG'ler önizleme içindir.
- Yeniden üretmek için: `python tasarim/simge-acilis/uret.py`. Renk ve biçim değişiklikleri bu betikte yapılır.

## Simge (1024×1024)

| Dosya | Fikir | Not |
|---|---|---|
| `simge-1-muhur` | Ana sayfadaki numara mührünün büyüğü: kına kırmızısı, çift halka, ortada sekiz köşeli yıldız | 48 px'te en okunaklı olan; uygulamanın "damga" dilini taşır |
| `simge-2-pusula` | Haritadaki pusula gülü, altın halka, noktalı yol | Yolculuk fikri; dinî sembol taşımaz; küçükte ince kollar silikleşir |
| `simge-3-yol` | Ana sayfanın kendisi: noktalı yol ve kına kırmızısı çarpı | Anlatıya en yakını; 48 px'te noktalar kaybolur, çarpı kalır |
| `simge-4-gece-muhur` | Mührün koyu sürümü: gece laciverdi zemin, altın mühür | Karanlık temada ve parlak simgeler arasında öne çıkar |

Sekiz köşeli yıldız, İslâm sanatında yaygın bir geometrik motiftir; istenmezse yerine pusula ya da düz bir halka konabilir.

## Açılış ekranı (1080×1920)

| Dosya | Fikir |
|---|---|
| `acilis-1-parsomen` | Uygulamanın kendi zemini: parşömen, ortada mühür, altta başlık ve aşağı inen noktalı yol. Uygulamaya en tutarlı geçiş |
| `acilis-2-gece` | Gece laciverdi, seyrek yıldızlar, altın pusula, parşömen renginde başlık |
| `acilis-3-harita` | Haritadan bir kesit: Kızıldeniz kıyısı, Şam'dan Mekke'ye kervan yolu, Mekke'de çarpı |

## Öneri

**`simge-1-muhur` + `acilis-1-parsomen`.**

- Mühür küçük boyutta en iyi okunan simge ve ana sayfadaki mührün aynısı. Kullanıcı simgeye dokunur, aynı mührü açılışta, sonra bölüm kartlarında görür.
- Android 12 ve sonrasında açılış ekranı yalnız ortadaki simgeyi ve zemin rengini gösterir. Bu yüzden zemin `#E6D3A8` (parşömen), ortada mühür olur. Tam ekran taslak eski Android sürümleri içindir.

## Uygulamaya geçirmek için

- Seçimden sonra iki geliştirme paketi gerekir: `flutter_launcher_icons` (uyarlanabilir simge: ön plan mühür, arka plan parşömen) ve `flutter_native_splash` (açılış). Paket eklemek Erdem'in onayına bağlı (CLAUDE.md → Teknik yön).
- Uyarlanabilir simgede önemli öğeler ortadaki %66'lık dairede kalmalı; mühür buna göre ölçeklendi.
- Başlıklarda Noto Serif kullanıldı (yoksa Georgia). Simgede yazı yok.
