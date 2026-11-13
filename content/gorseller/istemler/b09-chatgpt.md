# b09-hakem: ChatGPT ile görsel üretimi

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

## Mesaj 1: m01b-gok-gunduz

*Kontrol: tam dolu görsel, perde yok*

```text
Scene m01b-gok-gunduz. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Sky only, clear midday: pale dusty blue, slightly lighter and warmer near the horizon, a few faint thin clouds, no land.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: m01c-gok-aksam

*Kontrol: tam dolu görsel, perde yok*

```text
Scene m01c-gok-aksam. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Sky only, dusk just after sunset: muted violet-grey at the top fading to dull apricot and rose near the horizon, a few thin dark clouds, no land.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: m01d-gok-gece

*Kontrol: tam dolu görsel, perde yok; Ay yok: s09 tarifindeki ayın evresi kaynakta yok; gerekirse oynatıcı çizer.*

```text
Scene m01d-gok-gece. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Sky only, night: deep indigo, many small faint stars, a soft lighter haze near the horizon, no moon, no land.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: m07b-kabe-yuksek

*Kontrol: yeşil perde; nesne kenarlara değmemeli; m07 basık çıktı (yükseklik alçak hâlin 1,47 katı); Erdem (a) seçeneğini seçti (2026-11-13).*

```text
Scene m07b-kabe-yuksek. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The finished cube-shaped stone building, clearly about twice as tall as its earlier low version: its walls are TALLER THAN THEY ARE WIDE. Flat roof, courses of dark stone alternating with thin wooden beams, a single-leaf wooden door set high in the wall with no stairs or steps, no covering cloth, no decoration. Straight vertical walls, sharp square corners. Only a thin strip of ground under it. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: m04b-evler-uzak

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Eski evler katmanı ön plan ölçeğindeydi; Kâbe her sahnede küçük görünüyordu. Önce eski görseli ayar.gorsel ile küçültmek denendi (2026-11-13): katmanın kendi zemin şeridi sert kenarlı bir dikdörtgen gibi görünüyor; yeniden üretim gerekli.*

```text
Scene m04b-evler-uzak. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from far away across an open space: a long, low, loose row of small flat-roofed houses of mudbrick and rough stone, single storey, small in the frame, along the foot of the valley; a wide empty gap in the middle of the row. Houses occupy only the middle third of the image height. The ground under the houses fades out to the edges of the image so no hard edge shows. No people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: s02-kabe-isli

*Kontrol: tam dolu görsel, perde yok; Kaynak: TDV KUREYŞ s. 443 (yangın ve sel).*

```text
Scene s02-kabe-isli. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close-up of an old wall of rough, dry-stacked dark stones without mortar: soot stains blackening the stones, worn and cracked surfaces, dry earth washed into the gaps between stones, and a dried flood line with a crust of silt along the base of the wall. No people, no hands.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: s03-deniz

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Gök ayrı katman; ufkun üstü yeşil perde.*

```text
Scene s03-deniz. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Red Sea coast at noon: a calm sea stretching to a flat horizon, a wide sandy beach in the foreground, small low waves at the shoreline, no boats, no ships, no buildings. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: s03-gemi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Gemi tipi kaynakla netleşmedi; ayrıntı çizilmez.*

```text
Scene s03-gemi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A broken wooden ship hull lying on its side on sand, split open, with loose planks scattered around it. Keep the ship generic and simple: no sails, no rigging, no flags, no carvings, no identifiable ship type. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: s03-tasiyanlar

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s03-tasiyanlar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Five very small distant human silhouettes walking in a line, carrying long wooden planks on their shoulders; no facial features at all. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: s04-kalabalik

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s04-kalabalik. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A gathering of about fifteen older men in simple robes and head cloths standing in an open courtyard at middle-far distance, facing the viewer, their faces in deep shadow with no visible features. No coins, purses or money anywhere. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: s04-konusan

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ebû Vehb b. Amr; yüz kesinlikle görünmez.*

```text
Scene s04-konusan. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from behind at close range, lower center of the frame: the head, shoulders and upper back of one man in a robe and head cloth, cut off at the waist by the bottom edge, one hand slightly raised as if speaking. His face is not visible at all. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: s05-kalabalik

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s05-kalabalik. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At dusk, a group of about twelve men in robes standing well back at a distance, hesitant, some turned half away; small in the frame, dark silhouettes against the evening light, no facial features. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 13: s05-kazmali

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Velîd b. Muğîre; duvarın üstüne ayar.gorsel ile yerleştirilecek.*

```text
Scene s05-kazmali. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A single small dark silhouette of a man in a robe seen from behind, standing, holding a pickaxe raised above his head, with a little puff of stone dust. Full body inside the frame with empty margin around it. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 14: s06-temel

*Kontrol: tam dolu görsel, perde yok; Kaynak: i-b09-009 (İbn Hişâm s. 124: deve hörgücüne benzeyen yeşil taşlar).*

```text
Scene s06-temel. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Top-down view of an excavated pit: large greenish stones with rounded backs shaped like camel humps set closely together in the ground, a thin layer of fine dust on them, dug-out earth around the edges, and a pickaxe lying at one edge. No people, no hands, no feet.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 15: s07-gruplar

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s07-gruplar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Several very small distant groups of two or three human silhouettes, each carrying stones on their shoulders, spread across the width of the image; no facial features. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 16: s08-iki-grup

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s08-iki-grup. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Two groups of men in robes and head cloths at middle-far distance facing each other across an empty gap in the middle, tense postures, harsh midday shadows; no visible facial features. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 17: s09-siluetler

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s09-siluetler. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At night, a loose ring of dark human silhouettes sunk in shadow, seen at middle distance, lit only faintly from the side by warm torchlight; an empty space in the center of the ring. No facial features, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 18: s09-kap

*Kontrol: yeşil perde; nesne kenarlara değmemeli*

```text
Scene s09-kap. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A plain dark wide bowl standing on the ground, seen from a low side angle so its inside is not visible, faint warm torchlight on its rim. Nothing inside visible, no liquid, no blood. Fully inside the frame with empty margin. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 19: s09-mesale

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Alev oynatıcıda ayrıca titretilebilir.*

```text
Scene s09-mesale. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A simple wooden torch with a cloth-wrapped head, burning with a small flame, standing upright. Fully inside the frame with empty margin. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 20: s10-giris

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Kapının o dönemki biçimi kaynakta yok.*

```text
Scene s10-giris. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Across an open courtyard: a plain narrow gap between two mudbrick houses with bright daylight coming through it. No arch, no gate, no frame, no decoration. No people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 21: s10-kalabalik

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene s10-kalabalik. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A crowd of about eighteen men in robes at far distance, standing and listening, facing the viewer; too far for any facial features, faces in shadow. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 22: s10-yasli

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ebû Ümeyye b. Muğîre; yüz görünmez.*

```text
Scene s10-yasli. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from behind at close range on the left side of the frame: the shoulders and back of an old man in a robe and head cloth, standing upright, cut off by the bottom edge. His face is not visible at all. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
