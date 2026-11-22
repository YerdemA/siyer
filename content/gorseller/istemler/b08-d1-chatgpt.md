# b08-el-emin: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 595-605 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone and the low, roofless Ka'ba) and, once, the edge of a town in southern Syria (Busra) with a stone monastery. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b08-d-emanet

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s01 tek devralınmış görsel 18 sn; 'el-Emîn' cümlesi. Dayanak: b08-s01 parça 1; i-b08-002.*

```text
Scene b08-d-emanet. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, in front of a house in Mecca: two men of Quraysh hold out a tied, sealed bundle of goods towards the right, trusting; at the right, a place is left empty at the height of a tall man: a tall figure will be added there later by the app, so keep that spot completely empty: no person, no object, no shadow, no glow.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. 2 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the left, holding out the bundle.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, coins with writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b08-d-rahip-meysere

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-meysere.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s05 tek görsel 16 sn. Dayanak: b08-s05 parça 1; i-b08-007.*

```text
Scene b08-d-rahip-meysere. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, beside the stone monastery near Busra: the monk speaks to Maysara and points towards a large shade tree in the distance; Maysara listens.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. an old Christian monk of Syria with a long white beard and short white hair; NO hood: bare head with a small round black cap; a long, plain robe of undyed light-grey wool with a thin black sash; a plain wooden walking staff; no cross, no jewellery. He must look clearly different from Bahira (who wears a dark-brown hood and dark-brown robe). Pose and place: at the left, pointing to the right.
2. Maysara, a young servant man of about 25 with a short, sparse black beard; a plain undyed off-white head cloth tied simply; a knee-length undyed wool tunic and a short sand-brown cloak; a plain rope belt; simple sandals. Pose and place: at the right, listening.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, crosses, anyone under the tree

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b08-d-kizlar

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-hatice.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s10 tek görsel 40 sn (en uzun durağan çekimlerden). Dayanak: b08-s10 parça 1; i-b08-015.*

```text
Scene b08-d-kizlar. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the courtyard of Khadija's house: four young girls of different ages sit together on a mat, seen strictly from behind: one spins wool, one holds a small basket, two talk; Khadija sits behind them in the shade, also from behind.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. 4 × girls of about 6 to 14 seen strictly from behind, simple dresses in muted colours and head coverings. Pose and place: seated in a row on the mat.
2. Khadija, a dignified woman ALWAYS seen from behind, in silhouette or completely in shadow, face never visible; wrapped in a long deep wine-red-brown cloak of fine wool with a narrow woven border, and a cream head covering that hides her hair and the sides of her face. Pose and place: seated behind them, strictly from behind.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any face or profile, glow

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b08-d-kasim-kabir

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahne: Kâsım'ın vefatı. Dayanak: b08-s10 parça 2; i-b08-016.*

```text
Scene b08-d-kasim-kabir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dusk, a small, simple grave marked by a few stones in a quiet place at the foot of a bare hill near Mecca; no one there.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, writing, flowers, glow

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b08-d-hicret-yolu

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı sahne: kızlarının hicreti. Dayanak: b08-s10 parça 3; i-b08-017.*

```text
Scene b08-d-hicret-yolu. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Dawn, a long desert road leading north: a few women on camels travel in a small group, seen very small and from behind.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. 3 × women wrapped in dark cloaks, seen from behind on camels. Pose and place: small, far on the road.
2. 3 × camels. Pose and place: carrying them.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, faces, glow

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b08-d-zeyd-kacirilis

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s11'in ikinci çekimi aynı görsel (20 sn). Dayanak: b08-s11 parça 1; i-b08-018.*

```text
Scene b08-d-zeyd-kacirilis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, desert: a band of mounted raiders leads away a small boy on foot by the hand; the boy is seen from behind; in the distance, a woman on a camel reaches out after him.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. 3 × raiders on horses, dark wrapped head cloths covering most of their faces. Pose and place: at the right, riding away.
2. a boy of about 8 seen from behind, plain tunic. Pose and place: led by the hand.
3. a woman wrapped in a dark cloak on a camel, from behind. Pose and place: far at the left.
4. camel. Pose and place: carrying the woman.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, weapons in use, chains

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b08-d-hatice-oda

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-hatice.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s07 tek avlu görseli; haber evin içinden gönderiliyor (iç mekân önerisi). Dayanak: b08-s07 parça 1; i-b08-009.*

```text
Scene b08-d-hatice-oda. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Evening, a room inside Khadija's house: plain plastered walls, a woven mat, cushions, a small oil lamp in a wall niche, a window with a cloth curtain. Khadija sits on a cushion seen strictly from behind; before her a woman messenger, also seen from behind, bows slightly as she receives the message.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Khadija, a dignified woman ALWAYS seen from behind, in silhouette or completely in shadow, face never visible; wrapped in a long deep wine-red-brown cloak of fine wool with a narrow woven border, and a cream head covering that hides her hair and the sides of her face. Pose and place: seated at the right, strictly from behind.
2. a woman messenger wrapped in a plain sand-coloured cloak and head covering, seen strictly from behind. Pose and place: standing at the left, bowing slightly.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: evening interior: warm browns and dusk-blue at the window; the only warm light is the small oil lamp; no moon glow, no halo.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any face or profile, any man

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b08-d-kitlik

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s14'ün ikinci çekimi 19 sn aynı görsel. Dayanak: b08-s14 parça 0; i-b08-023.*

```text
Scene b08-d-kitlik. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, a dry courtyard in Mecca during a famine: empty storage jars stand open, a single thin goat, a few dry date stones on a mat.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. thin goat. Pose and place: at the right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, bodies, bones

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b08-d-hatira

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s15 tek ortak Kâbe görseli 16 sn. Dayanak: b08-s15 parça 0; i-b08-024.*

```text
Scene b08-d-hatira. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Night, inside the room of a house, lit by a small oil lamp: a cushion on a mat with a folded deep wine-red-brown cloak of fine wool laid on it; a spindle and a small wooden box beside it; nobody in the room.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: night: deep indigo blues; the only warm light is the small orange-red flame described in the scene; no moon glow, no halo.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, faces, glow around objects

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
