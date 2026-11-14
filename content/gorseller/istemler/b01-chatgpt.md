# b01-cahiliye-mekkesi: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about 7th-century Mecca. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: the valley of Mecca, Hijaz, in the centuries before 600 CE — a valley among bare, rocky, almost treeless mountains; where a scene allows, small flat-roofed houses of mudbrick and rough stone, otherwise tents or open ground. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, faces, hands, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b01-s01-kurak

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s01-kurak. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close foreground: a few dry, thorny desert shrubs and scattered stones on cracked sandy ground, filling only the bottom third of the frame; nothing above them. No people, no animals, no water. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b01-s03-curhum

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-curhum-kervan.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Hâcer ve Hz. İsmâil çizilmez: kadın, çocuk ya da kuyu çıkarsa yeniden ürettir.*

```text
Scene b01-s03-curhum. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. Men of a Yemeni tribe arriving in a bare valley and setting up low dark tents: one man drives a tent peg, another unloads a cloth bundle from a kneeling camel, a third holds a tent pole. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. No women, no children, no well, no water. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b01-s04-tas

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-temel.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Peygamberler çizilmez: kişi, el, gölge ya da ayak izi çıkarsa yeniden ürettir.*

```text
Scene b01-s04-tas. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Close-up: the lower courses of a wall of large rough grey stones laid without mortar, rising from sandy ground across the lower half of the frame; a few loose stones at its base and a little dust in the air. No people, no hands, no tools, no shadows of people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b01-s05-huzaa

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s05-huzaa. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Medium-wide: a column of tribesmen of Khuza'a and Kinana arriving on foot and on camels, walking toward the right across open ground, spears held upright; determined, no fighting, no blood. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b01-s06-amr

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Putun kendisi çıkarsa yeniden ürettir.*

```text
Scene b01-s06-amr. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. A man of authority (Amr ibn Luhayy) standing in the left third of the frame in three-quarter view, looking toward the right; his robe and head cloth finer than ordinary people's. On the ground before him fall long dark shadows of tall upright shapes standing outside the frame. Do not show the idols themselves. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b01-s07-hakem

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-cadirlar.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s07-hakem. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. An older arbiter (Ya'mur ibn Awf) standing at the center between two groups of men and raising one open hand as he gives his judgment; the two groups stand at the left and right edges, listening. No weapons raised. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b01-s08-nedve-ic

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-darunnedve.png`

*Kontrol: tam dolu görsel, perde yok*

```text
Scene b01-s08-nedve-ic. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Inside a plain mud-brick council house: elders of Quraysh, men over forty, sitting on mats in a circle along the walls; one speaks with an open hand, the others listen. Daylight comes through a doorway on the right. Plain walls, no decoration, no furniture. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Fill the whole frame; no green background.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b01-s09-gruplar

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-iki-ittifak.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s09-gruplar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. Two groups of Quraysh men facing each other, tense: the sons of Abd al-Dar on the left, the sons of Abd Manaf on the right; one man on each side steps forward. Leave the center of the frame empty. No weapons drawn. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b01-s10-hanif

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-hanif.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s10-hanif. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. A man of Mecca who keeps away from the idols (a hanif), in the right third of the frame, seen in three-quarter view from the side and looking left; calm and thoughtful, head slightly lowered, wearing the same head cloth and plain robe as in the attached image. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b01-s11-kervan

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-kervan-cikis.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Yük ayrıntısı verilmez.*

```text
Scene b01-s11-kervan. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: Quraysh traders leading a line of loaded camels toward the right; a man in front holds the lead rope, another walks beside a camel; loads are bundles wrapped in cloth and rope. Figures cut at the knees by the lower edge. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b01-s12-ates

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-konak.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s12-ates. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Night, medium shot: men of a desert tribe sitting close together around a small fire, wrapped in cloaks, faces lit warm orange from below; one man speaks, the others listen. Figures cut at the chest by the lower edge. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. No weapons, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b01-s13-abdulmuttalib

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-abdulmuttalib-avlu.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s13-abdulmuttalib. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium close shot of Abd al-Muttalib, leader of the Banu Hashim of Mecca, in the left third of the frame: an elderly, dignified man with a grey beard, in three-quarter view looking right, wearing the same cream head cloth with a dark cord, rust-red shawl and brown robe and holding the same wooden staff as in the attached image; calm, respected bearing. Face visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expression; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 13: b01-s13-zemzem

**Bu mesaja ekle** (proje klasöründen, uzak çekim): `gorsel-ham/b01/b01-abdulmuttalib-avlu.png`

*Kontrol: yeşil perde, zemin düz yeşil olmalı*

```text
Scene b01-s13-zemzem. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The image attached to this message is the wide shot of the same scene: keep the same people's clothing, colors and setting so the two shots match; do not copy its composition. Medium shot: figures cut at the waist or knees by the lower edge of the frame, heads in the upper-middle part. A group of men re-opening an old, filled-in well: two dig with simple wooden shovels, one lifts a basket of earth, and the rough stones of the well rim are being uncovered; an elderly man in the same clothing as in the attached image watches and directs them. No water spraying, no light. Faces are visible and simply drawn in the same flat paper cut-out style: plain shapes, calm dignified expressions, adult men with short dark beards; not photorealistic, no caricature. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
