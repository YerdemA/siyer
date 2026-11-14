# b10-hira: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about 7th-century Mecca. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, hands, faces turned away, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b10-hira-dagi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; HİRA maddesi: dik, sivri, çıplak ve kaygan kayalar; bitki örtüsü dikenli çalılar.*

```text
Scene b10-hira-dagi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A single steep, sharp, bare rocky mountain peak, noticeably steeper and more pointed than the hills around it, made of naked, smooth, slippery-looking rock with only a few scattered thorny shrubs. Seen from far away across a valley; the peak stands alone in the middle of the image. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b10-yokus

*Kontrol: yeşil perde, zemin düz yeşil olmalı; HİRA maddesi: mağaraya tabii kayalardan yüksek basamaklarla çıkılır. Üç sahnede ortak; ışık nötr tutulmalı.*

```text
Scene b10-yokus. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Eye-level view up a steep mountain path of high, irregular natural rock steps among bare boulders, climbing toward a rocky summit. No people. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b10-magara

*Kontrol: yeşil perde, zemin düz yeşil olmalı; HİRA maddesi: iki tarafı açık, sivri tonozlu tünele benzer, kaya blokları arasında boşluk. Açıklık yeşil perde; gök ve vadi arkadaki katmanlardan gelir.*

```text
Scene b10-magara. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from inside a narrow cave looking out: an irregular gap between huge stacked rock blocks, like a rough pointed tunnel open at one end, just tall enough for a standing person and long enough to lie down. The rock walls frame the left, right and top of the image in deep shadow; the opening in the center shows only flat chroma green (the sky and valley are separate layers). No people, no lamps, no light source. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b10-pencere

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Sadık rüyalar sahnesi: dışarıdaki gök geceden sabaha döner. Altın-beyaz ışık yok.*

```text
Scene b10-pencere. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Inside a dark, simple mudbrick room: a small, plain rectangular window opening in the wall, no frame, no glass, no shutters, no decoration. The wall fills the image in deep shadow; the window opening shows only flat chroma green (the sky is a separate layer). No people, no furniture. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b10-abdulmuttalib

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Abdülmuttalib; yüz kesinlikle görünmez. ayar.gorsel ile yamaca yerleştirilecek.*

```text
Scene b10-abdulmuttalib. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A single elderly man in a simple robe and head cloth, seen from behind at a distance, walking up a bare rocky slope, his face not visible at all. Full body inside the frame with empty margin around it. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b10-hatice-kapi

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Hz. Hatice; yalnız arkadan siluet, yüz yok. Kıyafette süs ve takı çizilmez.*

```text
Scene b10-hatice-kapi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A woman in a long, modest, simple dress and a head covering that hides her hair, seen from behind, standing in a plain wooden doorway of a mudbrick house, holding a small knotted cloth bundle of food. Her face is not visible at all; no hands of anyone else. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b10-hatice-yokus

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Hz. Hatice; yalnız arkadan siluet, yüz yok.*

```text
Scene b10-hatice-yokus. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A woman in a long, modest, simple dress and a head covering that hides her hair, seen from behind, walking up a rocky mountain path, a few steps ahead of the viewer. Her face is not visible at all. Full body inside the frame with empty margin around it. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b10-yoksullar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Uzak plan; ayar.gorsel ile yokuşa yerleştirilecek.*

```text
Scene b10-yoksullar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Four very small distant human silhouettes in simple worn clothes climbing a mountain path one after another, one of them carrying an empty bowl; no facial features at all. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
