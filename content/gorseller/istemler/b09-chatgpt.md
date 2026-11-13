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

## Mesaj 1: s03b-deniz

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İlk deniz görselinde kumsal yalnız alt %10’daydı; gemi ve taşıyanlar suyun üstünde kalıyordu.*

```text
Scene s03b-deniz. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Red Sea coast at noon seen from the beach: a wide, flat sandy beach fills the lower 40% of the image; a calm sea above it, with the flat horizon slightly above the middle of the image. Small low waves at the shoreline. No boats, no ships, no buildings. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: s04b-kalabalik

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Önceki deneme orta planda sakal, bıyık ve el-çene ayrıntısı gösterdi; uzaklık ve yüz tarifi değiştirildi.*

```text
Scene s04b-kalabalik. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Far away and small in the frame: a gathering of about fifteen men in simple robes and head cloths standing together in an open courtyard, facing the viewer. Faces are flat dark shapes under the head cloths: no eyes, no noses, no beards, no mouths, no profiles with visible features. No coins, purses or money anywhere. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: s08b-iki-grup

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Önceki denemede birbirine dönük figürler profilden burun ve sakal gösterdi; uzaklık kaldıraç.*

```text
Scene s08b-iki-grup. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Far away and small in the frame: two groups of men in robes and head cloths standing apart with an empty gap between them, the groups turned toward each other, tense postures, harsh midday shadows. Faces are flat dark shapes under the head cloths: no eyes, no noses, no beards, no mouths, no profiles with visible features. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
