# b05-yetimlik: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 576-579 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone) and the desert road north toward Yathrib. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b05-yol-zemin

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Mekke-Yesrib yolu; ortak zemin.*

```text
Scene b05-yol-zemin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Desert road toward Yathrib: flat sandy and stony plain with a faint caravan track running across it from left to right, a few low dry bushes, low bare hills along the horizon.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: This is a ground layer. The horizon is a perfectly straight, horizontal line at 45% of the image height from the top; the ground fills everything below it to the bottom edge and to both side edges. Everything above the horizon is perfectly flat, uniform chroma green (#00B140): no sky, no clouds, no distant mountains. No green tint on the ground.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: people, animals, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b05-kervan

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-amine.png`, `karakter-ummu_eymen.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Âmine ve Ümmü Eymen; ikisi de arkadan. Çocuk görünmez.*

```text
Scene b05-kervan. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A small caravan travelling north, seen from behind, moving away from the viewer; Amina and Umm Ayman ride among the travellers.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Amina, a woman ALWAYS seen from behind or completely in shadow, face never visible; wrapped in a long deep indigo-blue cloak with a sand-coloured head covering that hides her hair and the sides of her face. Pose and place: riding the camel on the left, seen strictly from behind, no face.
2. Umm Ayman, an Abyssinian woman, seen from behind in these scenes; wrapped in a long sand-beige cloak with a brown head covering. Pose and place: riding the camel second from the right, seen strictly from behind, no face.
3. 2 × small travellers in off-white head cloths and brown cloaks. Pose and place: walking beside the camels, seen from behind.
4. 4 × camels with saddles and bundles. Pose and place: side by side, walking away from the viewer.

LAYOUT: All camels and travellers move away from the viewer side by side, feet on one horizontal line in the lower part of the image, at the same distance from the camera. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: child, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b05-yesrib-uzak

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Yesrib; kaynakta görünüş betimi yok, uzak ve ayrıntısız.*

```text
Scene b05-yesrib-uzak. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: A distant settlement of low, flat-roofed mudbrick houses and a few palm trees spread along a flat plain, seen from eye level, undetailed.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: The settlement is one long, low horizontal band in the lower part of the image, its base a straight horizontal line. Draw only the object: no ground, cast shadow, people, hands or background; perfectly flat, uniform chroma green (#00B140) everywhere else, no green tint on the object.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: people, minarets, domes, ground in front.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b05-ebva-konak

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ummu_eymen.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Ebvâ; Âmine'nin vefatı gösterilmez. Kadın Ümmü Eymen. Akşam, çadır, develer sahnelemedir, kaynakta yok.*

```text
Scene b05-ebva-konak. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: A desert halt at Abwa seen from the side at a distance: a few camels kneeling, one small low tent; Umm Ayman sits alone in front of the tent.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Umm Ayman, an Abyssinian woman, seen from behind in these scenes; wrapped in a long sand-beige cloak with a brown head covering. Pose and place: sitting on the ground in front of the tent, seen strictly from behind.
2. 3 × kneeling camels. Pose and place: beside the tent.
3. one small low tent of dark woven cloth. Pose and place: in the middle.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the one small low tent of dark woven cloth listed above, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: body, burial, grave, child, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b05-ebva-kabir

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Resûlullah'ın gözünden kabir ziyareti (Müslim 976b; EBVÂ). Kabir sade.*

```text
Scene b05-ebva-kabir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: This scene is set in 628 CE. A low, simple mound of earth, edged with a few plain stones, seen at eye level from a few steps away.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: The object is shown complete with clear flat green space on all four sides (at least one tenth of the image). Draw only the object: no ground, cast shadow, people, hands or background; perfectly flat, uniform chroma green (#00B140) everywhere else, no green tint on the object.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: hands, arms, feet or body of the viewer, light, glow, inscription, building, ground around the mound.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b05-kapida-teslim

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-ummu_eymen.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Ümmü Eymen Efendimiz'i Abdülmuttalib'e teslim eder; çocuk görünmez.*

```text
Scene b05-kapida-teslim. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Umm Ayman walks toward Abdul-Muttalib, who stands waiting calmly.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing at the right, facing left, calm.
2. Umm Ayman, an Abyssinian woman, seen from behind in these scenes; wrapped in a long sand-beige cloak with a brown head covering. Pose and place: walking toward him from the left, seen strictly from behind.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: child, door, house, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b05-kabe-dosek

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 107: Kâbe'nin gölgesinde Abdülmuttalib'in döşeği; oğulları üstüne oturmaz.*

```text
Scene b05-kabe-dosek. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abdul-Muttalib sits on his own plain flat mat; his sons sit on the bare ground around it, never on the mat.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: sitting cross-legged on the mat in the centre.
2. 4 × the sons of Abdul-Muttalib: grown men aged roughly 20 to 50, all clearly younger than their father; mixed beard lengths, all beards black or dark brown except the eldest with a little grey; off-white or sand head cloths and plain cloaks in muted brown, grey-blue and ochre. Pose and place: sitting cross-legged on the ground, two at the left and two at the right, off the mat.

LAYOUT: The plain flat mat lies at the bottom centre, seen from eye level; everyone sits at the same ground level. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the plain flat mat under Abdul-Muttalib, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: child, wall, Kaaba, ground other than the mat.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b05-dosek-yakin

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 107-108: 'Bırakın oğlumu'. Çocuk çizilmez.*

```text
Scene b05-dosek-yakin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abdul-Muttalib, seated on his mat, raises one open hand to stop two of his sons, who pause and look at him.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: sitting cross-legged on the mat at the right, one hand raised palm outward.
2. 2 × the sons of Abdul-Muttalib: grown men aged roughly 20 to 50, all clearly younger than their father; mixed beard lengths, all beards black or dark brown except the eldest with a little grey; off-white or sand head cloths and plain cloaks in muted brown, grey-blue and ochre. Pose and place: standing at the left, half-turned toward him, paused mid-step.

LAYOUT: The plain flat mat lies at the bottom right, seen from eye level; the standing men's feet are on the same ground level as the mat. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the plain flat mat under Abdul-Muttalib, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: child, light, glow, ground other than the mat.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b05-son-gece

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 108: Abdülmuttalib'in vefatı. Kızlarından ağıt isteme rivayeti çıkarıldı (Erdem, 2026-11-15).*

```text
Scene b05-son-gece. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Interior of a simple mudbrick room at night: Abdul-Muttalib lies on a low bed under a blanket, eyes closed, calm.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: lying on his back on the bed, head on a cushion at the left; his white-grey beard visible, face calm, partly in shadow.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: night interior lit only by one small dim orange oil lamp; deep soft shadows; no golden-white glow, no halo.

DO NOT DRAW: other people, women, child, glow.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b05-ebu-talib-kapi

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Ebû Tâlib; kaynakta görünüş betimi yok, sade. Çocuk görünmez.*

```text
Scene b05-ebu-talib-kapi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abu Talib stands calmly, waiting.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing in the centre, facing slightly left.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: child, door, house, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
