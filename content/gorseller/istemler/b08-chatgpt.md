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

## Mesaj 1: b08-hatice-ev

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 119), HATİCE (s. 465): Hatice zengin bir tacirdi, adamlarını malıyla ticarete gönderirdi. Evin görünüşü kaynakta yok; sade, geniş. Hatice yalnız perde ardında belli belirsiz gölge.*

```text
Scene b08-hatice-ev. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the wide courtyard of Khadija's house in Mecca, a plain but spacious two-storey house of stone and mudbrick like the attached reference. The courtyard is busy with trade: rolled bales of cloth, stacked leather bundles, a large balance scale on a wooden frame, sacks and clay jars; two workers tie up loads. On the upper floor, a small window is covered by a cloth curtain; behind it, only a faint, dark shadow of a standing woman can be guessed. Leave the courtyard gateway at the right open and clear, with empty ground in front of it, where a tall figure will be added later. Bare mountains of Mecca above the walls.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. 2 × two working men in plain undyed tunics and head cloths. Pose and place: at the left, bending over a load of bales, tying it with rope.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, Khadija's face, any woman's face, any figure in the gateway, gold, rich carpets, arches, domes, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b08-meysere

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-meysere.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 119): Meysere yolculukta onunla gidecekti.*

```text
Scene b08-meysere. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Maysara stands beside a few tied bundles of goods, ready for the journey, looking respectfully towards the right, where someone stands at the gate.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Maysara, a young servant man of about 25 with a short, sparse black beard; a plain undyed off-white head cloth tied simply; a knee-length undyed wool tunic and a short sand-brown cloak; a plain rope belt; simple sandals. Pose and place: standing at the left, three-quarter view facing right, one hand resting on the bundles, attentive.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: three tied bundles of cloth and leather on the ground beside him, which are drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any other person, camels, ground, walls.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b08-busra-agac

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 119-120): rahibin manastırına yakın bir ağacın gölgesine indi. BUSRÂ (s. 470): olay Busrâ'da. Ağacın ve manastırın görünüşü kaynakta yok; Busrâ bazalt taşıyla bilinir (yerelde kaynak yok, seçim).*

```text
Scene b08-busra-agac. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the edge of a small town in southern Syria (Busra): at the left, a single large, old shade tree with a broad, low canopy and a wide patch of shade beneath it; at the right, a modest stone monastery building with a small doorway and a low wall, built of grey-black basalt stone. A few loaded camels kneel and rest some distance behind the tree. Leave the shade under the tree completely empty — no one sits or stands there; a tall figure will be added later. Leave the ground in front of the monastery doorway empty too.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. about 5 × camels with loads. Pose and place: kneeling and resting in the middle distance behind the tree.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, any person, anyone under the tree, crosses, bells, church domes, icons, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b08-rahip

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-meysere.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 120), BUSRÂ (s. 470): rahip Meysere'ye ağacın altındakini sordu. Görünüşler kaynakta yok.*

```text
Scene b08-rahip. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: The old monk stands in his doorway and speaks to Maysara, pointing towards the left with one hand, as if asking who is resting under the tree there; Maysara turns his head to look where he points.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. an old Christian monk of Syria with a long white beard; a plain dark-brown woollen robe and a dark hood; a simple cord belt; no cross, no jewellery. Pose and place: standing at the right, facing left, one arm stretched out, pointing left, an earnest look.
2. Maysara, a young servant man of about 25 with a short, sparse black beard; a plain undyed off-white head cloth tied simply; a knee-length undyed wool tunic and a short sand-brown cloak; a plain rope belt; simple sandals. Pose and place: standing at the left, body facing the monk, head turned back over his shoulder to the left.

LAYOUT: Both stand side by side on one horizontal foot line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, crosses, any other person, tree, building, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b08-amcalar

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 120): Hamza; HATİCE (s. 465): Ebû Tâlib ve kardeşleri. Anlatım tarafsız ('amcaları'); görselde iki amca. Ebû Tâlib 535 doğumlu (EBÛ TÂLİB) → ~61.*

```text
Scene b08-amcalar. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Two uncles walk side by side through Mecca with calm, purposeful steps, as if going to ask for a bride: Abu Talib, now older, and Hamza. Leave a clear empty gap at the right of the pair, about one person wide, where a tall figure walking with them will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: walking at the left, facing right; he is now about 60, his beard mostly grey.
2. Hamza ibn Abd al-Muttalib, a strong, broad-shouldered man of about 30 with a short black beard; an off-white head cloth with a dark cord band; a cream tunic and a long rust-brown cloak; a leather belt; brown sandals. Pose and place: walking beside him in the middle, facing right.

LAYOUT: Both walk on one horizontal foot line in the lower part of the image; leave an empty gap about one person wide at their right. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any figure in the gap, weapons, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b08-nikah

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `b08-hatice-ev.png`, `nesne-mekke-evler.png`, `karakter-ebu_talib.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 120): mehir yirmi genç dişi deve. Nikâhın biçimi kaynakta yok. Hatice çizilmez. 'b08-hatice-ev' önce üretilmeli.*

```text
Scene b08-nikah. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, in front of Khadija's house in Mecca (plain stone and mudbrick house like the attached references): a small gathering of relatives, older men of Quraysh, stands in a loose half circle; from the left, young she-camels are led in on ropes as the bride gift. Calm, joyful, dignified. Leave a clear empty space at the centre, on the ground, about one person wide, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 8 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing at the centre-left, facing right, now about 60 with a mostly grey beard.
2. 5 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: relatives standing at the right in a loose half circle, turned to the centre.
3. about 20 × young she-camels with simple rope halters. Pose and place: led in from the left by two herdsmen, standing in a loose group.
4. 2 × two herdsmen in plain undyed tunics. Pose and place: leading the camels at the left.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, Khadija's face, any woman's face, women, any figure in the empty centre, gold, jewellery, music, dancing, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 8 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b08-aile

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-hatice.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 120-121), HATİCE (s. 465): çocukları. Temsil kuralı: eşi ve çocukları yüzsüz. Oynatıcıda ton: false.*

```text
Scene b08-aile. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Evening, inside a plain Meccan house lit by a single clay oil lamp on the floor: warm lamplight, reed mats, a few cushions of undyed wool, clay jars and a simple wooden chest. Several small children play quietly near the lamp, seen only from behind and in silhouette against the light; their faces are never visible. In the background at the left, a woman in a long wine-red-brown cloak sits with her back to the viewer, watching them. Leave a clear empty space beside the doorway at the right, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Khadija, a dignified woman ALWAYS seen from behind, in silhouette or completely in shadow, face never visible; wrapped in a long deep wine-red-brown cloak of fine wool with a narrow woven border, and a cream head covering that hides her hair and the sides of her face. Pose and place: sitting on a mat in the background at the left, seen from behind, face not visible.
2. 4 × small children (girls and a little boy), seen only from behind or in dark silhouette, faces never visible, in simple tunics. Pose and place: sitting and playing around the lamp in the middle, backs to the viewer.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: warm light from one small clay oil lamp on the floor only; the rest of the room in soft shadow. Faces stay in darkness or turned away.

DO NOT DRAW: the Prophet, any glowing figure, halo, any visible face, any figure by the doorway, toys of modern kind, books, writing, rich carpets.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b08-koleler

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_harise.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 160): Hakîm b. Hizâm Şam'dan köleler getirdi, Hatice Zeyd'i seçti. Zincir, kırbaç gibi şiddet öğesi çizilmez.*

```text
Scene b08-koleler. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Hakim ibn Hizam has just arrived with a few young slaves from a journey; he stands beside them, presenting them. Among the young slaves stands Zayd, tired but upright, his eyes lowered.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Hakim ibn Hizam, a prosperous merchant of about 35 with a trimmed black beard; a white head cloth with a dark cord band; a cream tunic and a long ochre-brown travelling cloak. Pose and place: standing at the left, facing right, one open hand gesturing towards the youths.
2. Zayd ibn Haritha as a youth of about 16, slim, beardless, with short curly black hair partly under a plain cream head cloth; a plain undyed wool tunic to the knee and a light sand-coloured cloak; a simple cord belt; bare feet or plain sandals. Pose and place: standing in the middle of the youths, upright, eyes lowered.
3. 2 × two young male slaves of about 16 to 18 in worn, plain undyed tunics. Pose and place: standing to the left and right of Zayd, heads slightly bowed.

LAYOUT: All four stand side by side on one horizontal foot line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, Khadija's face, any woman's face, chains, ropes on people, whips, wounds, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b08-harise

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_harise.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 160-161), ZEYD (s. 319): babası Hârise ve amcası Kâ'b fidyeyle geldi; Zeyd kalmayı seçti.*

```text
Scene b08-harise. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Zayd's father Haritha and his brother, dusty from the road, have come to Mecca to take Zayd home. Haritha stretches out his hands towards his son, hopeful; Zayd stands a step apart, turned towards the right, where someone stands whom he has chosen to stay with. Leave a clear empty gap at the right of Zayd, about one person wide, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Haritha, Zayd's father, a weathered desert tribesman of about 45 with a greying black beard; a dusty dark head cloth; a worn grey-brown travelling cloak over an undyed tunic; a staff. Pose and place: standing at the left, facing right, both hands held out towards his son.
2. Haritha's brother Ka'b, a desert tribesman of about 40 with a black beard, a dusty grey head cloth and a dark brown travelling cloak, holding a small leather pouch. Pose and place: standing just behind Haritha at the left.
3. Zayd ibn Haritha as a youth of about 16, slim, beardless, with short curly black hair partly under a plain cream head cloth; a plain undyed wool tunic to the knee and a light sand-coloured cloak; a simple cord belt; bare feet or plain sandals. Pose and place: standing in the middle-right, body turned to the right towards the empty gap, head turned back to his father, gentle but decided.

LAYOUT: All three stand on one horizontal foot line in the lower part of the image; leave an empty gap about one person wide at Zayd's right. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any figure in the gap, coins spilling, weapons, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b08-zeyd-yuruyus

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_harise.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 160), ZEYD (s. 319): âzat edilip evlat edinildi, 'Zeyd b. Muhammed' diye anıldı. Yürüyüş sahnesi temsilî.*

```text
Scene b08-zeyd-yuruyus. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Zayd walks calmly and contentedly through Mecca in the late afternoon, beside someone taller who walks at his left. Leave a clear empty gap at Zayd's left, about one person wide, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Haritha as a youth of about 16, slim, beardless, with short curly black hair partly under a plain cream head cloth; a plain undyed wool tunic to the knee and a light sand-coloured cloak; a simple cord belt; bare feet or plain sandals. Pose and place: walking at the right, facing left, a calm, content look, slightly turned towards the empty gap at his left.

LAYOUT: Zayd walks on a horizontal foot line in the lower part of the image; leave an empty gap about one person wide at his left. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any figure in the gap, any other person, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b08-ali

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 159), ALİ (s. 371): kıtlıkta Efendimiz Ali'yi, Abbas Ca'fer'i aldı. Ebû Tâlib 535 doğumlu → ~605'te 70; Ali ~5 (ALİ s. 371).*

```text
Scene b08-ali. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A year of famine in Mecca: in front of his house, the old Abu Talib stands in his doorway, tired and grateful. Al-Abbas has his hand on the shoulder of the boy Ja'far, ready to take him home. The little boy Ali stands at the right, looking up towards an empty space beside him. Two empty clay water jars lie on the dry ground. Leave a clear empty gap beside Ali at the far right, about one person wide, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing at the left, facing right; he is now about 70, his beard white, a little stooped, leaning on a staff.
2. al-Abbas ibn Abd al-Muttalib, a well-to-do, composed man of about 37 with a neat black beard; a white head cloth with a dark cord band; a fine cream tunic and a long dark green-grey cloak with a narrow border. Pose and place: standing at the centre-left, facing right, one hand on Ja'far's shoulder.
3. Ja'far ibn Abi Talib as a boy of about 14, slim, beardless, with black hair under a small off-white head cloth; a plain cream tunic and a short brown cloak. Pose and place: standing beside Abbas, facing right.
4. Ali ibn Abi Talib as a small boy of about 5, with short black hair, bare-headed; a simple knee-length off-white tunic; bare feet. Pose and place: standing at the centre-right, looking up to the right towards the empty gap.

LAYOUT: All four stand on one horizontal foot line in the lower part of the image; leave an empty gap about one person wide at the far right, next to Ali. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: two empty clay water jars lying on their sides near Abu Talib's feet, which are drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any figure in the gap, food, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
