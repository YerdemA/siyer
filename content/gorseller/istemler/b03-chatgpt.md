# b03-dogum: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 570 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b03-on-ogul

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-abdullah.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 97: oğulları onu koruyacak yaşa gelmiştir (hepsi yetişkin). Görünüş kaynakta yok.*

```text
Scene b03-on-ogul. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abdul-Muttalib stands and speaks to his ten grown sons. The camera stands behind the sons: we see the sons' backs in the foreground and Abdul-Muttalib facing them and the viewer.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 11 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing in the centre, beyond the sons, facing the viewer, one hand slightly raised as he speaks.
2. 9 × the sons of Abdul-Muttalib: grown men aged roughly 20 to 50, all clearly younger than their father; mixed beard lengths, all beards black or dark brown except the eldest with a little grey; off-white or sand head cloths and plain cloaks in muted brown, grey-blue and ochre. Pose and place: standing in a shallow arc in the foreground with their backs to the viewer, some heads turned slightly so a cheek shows; faces drawn simply where visible.
3. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: standing in the arc, seen strictly from behind (back of the head and back only).

LAYOUT: The sons stand in one shallow arc in the lower part of the image, feet near the same horizontal line; Abdul-Muttalib stands just beyond them, his feet a little higher, fully visible between them. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: ground, buildings, Kaaba, idols, knives.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 11 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b03-kureys-itiraz

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-abdullah.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 98: Kureyş toplantı yerlerinden kalkıp onu durdurur. Abdullah yüzsüz (arkadan).*

```text
Scene b03-kureys-itiraz. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Men of Quraysh have risen from their gatherings and surround Abdul-Muttalib, raising their open hands in protest and urging him to stop; his young son stands in the foreground with his back to the viewer.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing in the centre, facing the viewer, calm and grave.
2. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: standing in the foreground slightly right of centre, seen strictly from behind (back of the head and back only), facing his father.
3. 5 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: standing on both sides of Abdul-Muttalib, facing him and partly the viewer, open palms raised toward him.

LAYOUT: Abdullah's feet are on the lowest horizontal line; the others stand just beyond him in one row, feet on a horizontal line slightly higher; everyone complete from head to feet. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: knife, weapon, idol, blood, ground, buildings, Kaaba.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b03-yuz-deve

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-abdullah.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 99-100: yüz deve. Kesim gösterilmez.*

```text
Scene b03-yuz-deve. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: A great herd of camels gathered on open ground; in the foreground at the left, Abdul-Muttalib and his young son stand with their backs to the viewer, looking at the herd.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing in the left foreground, seen from behind and slightly to the side (a little of his grey-white beard shows at the cheek), looking toward the herd.
2. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: standing beside him in the left foreground, seen strictly from behind, looking toward the herd.
3. about 30 × a great many camels (the source says one hundred) of sandy and light-brown colours, standing and kneeling, without saddles or loads. Pose and place: filling the band to the right.

LAYOUT: Seen from eye level, the camera standing just behind the two men: the herd forms a broad horizontal band across the image beyond them; the two men's feet are on the lowest horizontal line, the herd's feet on a horizontal line slightly higher. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: slaughter, blood, knives, saddles, ground, buildings, Kaaba.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b03-vehb-kapi

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-abdullah.png`, `karakter-vehb.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 100. Âmine kadrajda yok; Abdullah yüzsüz.*

```text
Scene b03-vehb-kapi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Wahb, the host, greets Abdul-Muttalib and his young son with an open hand. The camera stands behind the two guests.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing in the left foreground, seen from behind and slightly to the side (a little of his grey-white beard shows at the cheek), facing Wahb.
2. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: standing beside him in the foreground, seen strictly from behind, facing Wahb.
3. Wahb ibn Abd Manaf, chief of the Banu Zuhra: a dignified man of about 55 with a short, neat dark-brown beard with a little grey; an off-white head cloth with a dark brown cord band; a cream tunic and a long brown cloak without a coloured border. Pose and place: standing beyond them at the right, facing them and the viewer, one open hand raised in welcome.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: women, door, wall, house, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b03-kervan-uzak

*Kontrol: yeşil perde; nesne kenarlara değmemeli; ABDULLAH s. 76: Şam'a ticaret yolculuğu. Abdullah ayrıca belirtilmez.*

```text
Scene b03-kervan-uzak. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: A small trading caravan seen from the side at a great distance, moving from left to right: a few loaded camels led by travellers on foot.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. 3 × small travellers in off-white head cloths and brown cloaks, undetailed. Pose and place: walking right beside the camels.
2. 5 × loaded camels with bundles and saddle bags. Pose and place: in a single file walking right.

LAYOUT: The caravan is one horizontal file in the lower half of the image, all feet on the same horizontal line, seen exactly from the side; it never rises toward the top of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: ground, road, mountains.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
