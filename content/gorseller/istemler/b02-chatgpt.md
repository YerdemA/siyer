# b02-fil-vakasi: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 570 CE — Yemen (San'a) and the Hijaz desert road to Mecca; Mecca is a narrow valley among bare, rocky, almost treeless mountains with small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b02-ebrehe-taht

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebrehe.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 28: kısa boylu, etli; s. 29: kaş, göz, burun ve dudağı yarıldığı için el-Eşrem; s. 31: halîm (yumuşak huylu). Taht (sarîr) s. 34. Giysi ve taht malzemesi kaynakta yok.*

```text
Scene b02-ebrehe-taht. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abraha seated calmly on a simple, plain wooden throne with a straight back, hands resting on the armrests; calm, composed face.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a split scar running vertically through his upper lip and the tip of his nose; short, tightly curled black hair and a short, close-cropped curly black beard streaked with grey; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a narrow golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: seated on the throne in the centre, facing the viewer.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: animal skins, leopard pattern, crown, jewels, cross, carved ornaments on the throne.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b02-ordu-yuruyus

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 31: Habeşliler ve fil. Tek fil (FİL VAK'ASI: kaynakların çoğu tek fil der).*

```text
Scene b02-ordu-yuruyus. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: The army on the march, seen from the side at a great distance: a long column moving from right to left, with the single elephant at its head on the left.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: at the left end of the column, walking left.
2. about 40 × small Abyssinian soldiers on foot (dark skin, white caps, cream tunics, red cloaks), simple and undetailed. Pose and place: walking left in a long single band behind the elephant.
3. about 4 × small mounted soldiers on brown horses, same clothing. Pose and place: spaced along the band.

LAYOUT: The whole column is one long horizontal band across the lower half of the image, all feet on the same horizontal line, seen exactly from the side; the column never rises, curves or recedes toward the top of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: banners, text, crosses, detailed weapons, ground, mountains, a second elephant.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b02-fil-coken

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`, `karakter-nufeyl.png`, `karakter-habes_askeri.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 35: Nüfeyl filin kulağını tutar; fil çöker. Dövülme gösterilmez.*

```text
Scene b02-fil-coken. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: The elephant has knelt down on the ground and refuses to rise; puzzled soldiers stand around it; Nufayl leans close to the elephant's ear, holding it gently and speaking into it.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: kneeling in the centre, side view facing right, head low.
2. Nufayl ibn Habib of Khath'am, the army's guide: an Arab man of about 45 with a short dark beard; an off-white head cloth wrapped loosely without a cord; a cream tunic and a red cloak with a narrow white edge. Pose and place: standing at the elephant's head on the right, leaning to its ear.
3. 4 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: two standing at the left, two at the far right, looking puzzled, spears pointing up.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: beating, raised weapons, blood, a second elephant.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b02-ordu-dagilan

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Kuşlar ayrı katman.*

```text
Scene b02-ordu-dagilan. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: The army breaking apart in panic, seen from the side at a distance: small soldiers running and scattering left and right, some ducking with arms over their heads.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 25 × small Abyssinian soldiers (dark skin, white caps, cream tunics, red cloaks), simple and undetailed. Pose and place: running in different directions, all on the same ground level.
2. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: standing still near the right, side view, calm.

LAYOUT: All figures are in one broad horizontal band in the lower half of the image, feet on roughly the same horizontal line, seen from eye level from the side; nobody is higher in the image than the band. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: birds (separate layer), tents, camels, injuries, bodies, blood, a second elephant, view from above.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b02-donus

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 36: Ebrehe yaralı olarak taşındı. Yara ayrıntısı yok.*

```text
Scene b02-donus. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: The defeated army trudging home at a distance, seen from the side, moving from left to right: small, tired, scattered groups; in the middle, four soldiers carry a covered litter with a person lying under a cloth.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (4 individually listed people). Keep every listed colour and feature exactly as written:
1. about 12 × small tired Abyssinian soldiers (dark skin, white caps, cream tunics, red cloaks), heads bowed. Pose and place: walking right in three loose groups.
2. 4 × soldiers of the same look carrying a litter on their shoulders. Pose and place: in the middle; the litter is covered with a red cloth, no body or face visible.

LAYOUT: All groups walk in one horizontal band in the lower half of the image, all feet on the same horizontal line, seen exactly from the side; the line never rises toward the top of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: wounds, blood, visible body of the carried person, ground, mountains.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
