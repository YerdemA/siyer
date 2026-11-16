# b06-ebu-talib: ChatGPT ile görsel üretimi

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

## Mesaj 1: b06-avlu

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-ebu_talib.png`

*Kontrol: tam dolu görsel, perde yok; TDV EBÛ TÂLİB s. 238 (çocukları), MUHAMMED s. 407 (kalabalık aile). Çocukların sayısı, yaşı ve evin biçimi kaynakta yok; sade. Efendimiz çizilmez.*

```text
Scene b06-avlu. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime in Mecca: the plain courtyard of a modest flat-roofed house of stone and mudbrick, built like the houses in the attached reference. Abu Talib stands in the courtyard; his children are around him, some sitting on an old reed mat, one carrying a small water jar. A few plain clay jars stand against the wall. Simple and tidy, without any luxury. Above the courtyard wall the bare mountains of Mecca under a clear sky.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing slightly left of centre, looking kindly at the children; full figure, feet on the courtyard ground.
2. 4 × children of Abu Talib, boys and girls aged about 5 to 14, in plain undyed or light-brown tunics; the girls with simple head cloths. Pose and place: two sitting on the reed mat at the right, one standing beside Abu Talib, one carrying a small water jar at the far right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, other adults, servants, rich carpets, gold, domes, arches, inscriptions.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b06-ev-ici

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`, `karakter-fatima_bint_esed.png`

*Kontrol: tam dolu görsel, perde yok; MUHAMMED s. 407: Ebû Tâlib onu çok sever, Fâtıma bint Esed ona kendi çocuklarından çok özen gösterir. Sofra sahnesi bu özenin görselleştirilmesi; kaynakta sahne yok. Onun gözünden: Efendimiz çizilmez. Fâtıma bint Esed'in yüzü çizilebilir (temsil kuralı 4).*

```text
Scene b06-ev-ici. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: Evening inside Abu Talib's simple house, lit by a small clay oil lamp. The viewer is sitting on the floor at a low meal spread laid on a woven cloth. Across the spread Abu Talib sits cross-legged and looks at the viewer with warm affection; beside him Fatima bint Asad leans forward and holds out a wooden bowl of food towards the viewer. At the side two of their children sit eating. Mudbrick walls, a wooden beam, a few clay jars and a folded blanket.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: sitting cross-legged on the far side of the meal spread, centre, looking at the viewer with a kind smile.
2. Fatima bint Asad, wife of Abu Talib: a woman of about 35 with a calm, kind face drawn simply; a long deep-blue head covering draped over her head and shoulders, hair not visible; a long plain sand-coloured dress under a dark-brown outer wrap; no jewellery. Pose and place: sitting beside him at the right, leaning forward, both hands holding out a wooden bowl towards the viewer.
3. 2 × two of their children, a boy of about 10 and a girl of about 7, in plain tunics; the girl with a simple head cloth. Pose and place: sitting at the left side of the spread, eating.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: warm, soft light from a small clay oil lamp on the floor beside the spread; the rest of the room in gentle dusk shadow; no glow, no light rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, the viewer's hands, arms, feet or body, other adults, rich furniture, chairs, tables.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b06-yamac

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`

*Kontrol: tam dolu görsel, perde yok; MUHAMMED s. 407; Buhârî, İcâre, 2. Onun gözünden. s05'te aynı görsel akşam tonuyla kullanılır.*

```text
Scene b06-yamac. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: A bare, rocky hillside above the valley of Mecca. The viewer is standing on the slope among a small flock of sheep and goats that graze on sparse dry tufts close in front; further down, far below, the narrow valley with tiny flat-roofed houses and the low, roofless Ka'ba as a small dark block; bare mountains all around under a clear sky.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. about 12 × sheep and goats, cream, brown and black, grazing. Pose and place: spread loosely across the lower half of the image in front of the viewer, heads down.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: people, shepherd, the Prophet, any glowing figure, halo, the viewer's hands, arms, feet or body, stick, trees, green fields, domes, minarets.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b06-kervan-hazirlik

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 115; EBÛ TÂLİB s. 237. Kervanın büyüklüğü kaynakta yok. s07'de onun gözünden sahnenin arka planı.*

```text
Scene b06-kervan-hazirlik. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Early morning, merchants of Quraysh preparing a trading caravan for Syria: camels kneel while men tie bundles and water skins onto their saddles; Abu Talib stands among them.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing in the middle, one hand resting on a camel's saddle; full figure.
2. 4 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: two tying bundles onto the saddles of kneeling camels at the left, two lifting a bundle at the right.
3. 4 × camels with saddles, some already loaded with bundles and water skins. Pose and place: kneeling side by side in one row.

LAYOUT: All camels and men stand or kneel side by side on one horizontal foot line in the lower part of the image, at the same distance from the camera. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, children, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b06-ebu-talib-egilmis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 115: Ebû Tâlib'in yüreği yumuşar (rakka lehû). Onun gözünden; Efendimiz çizilmez.*

```text
Scene b06-ebu-talib-egilmis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Abu Talib, moved and tender, bends forward towards a child standing in front of him (the child is the viewer and is not drawn), one hand reaching out gently with the palm open, as if saying 'come with me'.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing, upper body bent forward towards the viewer, looking down into the viewer's eyes with a soft, moved expression; full figure.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, a child, any other person, camels, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b06-kervan-yol

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 115-117. Gidişte ve dönüşte (s12 çekimi, s13) aynı katman.*

```text
Scene b06-kervan-yol. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: A long trading caravan travelling through the desert, seen from the side at a distance, moving from left to right: loaded camels in a line, some men riding, others walking beside them.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 10 × camels loaded with bundles and water skins. Pose and place: walking in one long line from left to right.
2. about 8 × small, undetailed men of Quraysh in off-white head cloths and muted brown cloaks. Pose and place: some riding on the camels, some walking beside them.

LAYOUT: The whole caravan forms one long horizontal band in the lower part of the image, all feet on the same horizontal line, seen exactly from the side. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any child, ground, sand dunes, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b06-busra

*Kontrol: tam dolu görsel, perde yok; BUSRÂ s. 470: verimli ova, Cebelidürûz'un batı yamacı, surlu şehir. Yapıların biçimi kaynakta yok; sade taş.*

```text
Scene b06-busra. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Busra in southern Syria, seen from far away across a wide, fertile plain with fields: a walled town of stone with flat-roofed stone houses and a few larger, plain stone buildings rising above them; low hills behind. A small trading caravan of camels approaches the town along a track in the foreground plain.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. about 8 × a small caravan of loaded camels with a few tiny, undetailed travellers. Pose and place: approaching the town along the track in the lower third.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: domes, minarets, crescents, crosses, church towers, arches, columns, Roman temples, inscriptions, modern buildings, the Prophet, any glowing figure, halo.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b06-manastir

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 115; BAHÎRÂ s. 486: küçük manastır, bulutun gölgelemesi, ağacın dallarının eğilmesi. Ağacın altı boş kalır: Efendimiz'i oynatıcı nur olarak çizer. Haç çizilmez (emin olunmayan ayrıntı).*

```text
Scene b06-manastir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: In Busra: a small, plain stone monastery, a low building of rough stone with a simple wooden door and one small window, at the left of the image. At the right stands a large old shady tree whose lower branches bend unusually low over an empty patch of ground beneath it; that patch lies in the soft shadow of a single small white cloud that hangs low just above the tree. In the middle distance the camels of a trading caravan kneel with their bundles on the ground. Dry, sandy ground, a few stones, low hills far behind.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. 5 × camels of a caravan, kneeling, with bundles beside them. Pose and place: kneeling in the middle distance between the monastery and the tree.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: people, monks, the Prophet, any glowing figure, halo, crosses, bells, domes, towers, arches, inscriptions, light rays from the cloud.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b06-bahira-bakis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-bahira.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 115: Bahîrâ manastırından bakarken bulutu ve ağacı görür.*

```text
Scene b06-bahira-bakis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Bahira the monk stands still and gazes intently into the distance at the right, one hand raised to shade his eyes, surprised and thoughtful.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Bahira, a Christian monk of Arab descent who lives in a small stone monastery in Syria: a man of middle age with a full, dark-brown beard; a plain dark-brown hood over his head; a long, plain dark-brown woollen robe tied with a simple rope belt; brown sandals; no cross, no jewellery, no book in hand. Pose and place: standing, turned three-quarters to the right, one hand shading his eyes; full figure.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any other person, cross, book, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b06-sofra

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-bahira.png`, `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 115-116; BAHÎRÂ s. 486: kafileyi yemeğe davet, Kureyşlilerin şaşkınlığı. Efendimiz bu katmanda yok (ağaç altında, oynatıcı nur çizer).*

```text
Scene b06-sofra. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A meal laid out by Bahira for the whole caravan: men of Quraysh sit on the ground around a large cloth spread with bread, dates and bowls of food; Bahira stands at the left welcoming them with an open hand; Abu Talib sits among the guests.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 6 people in total). Keep every listed colour and feature exactly as written:
1. Bahira, a Christian monk of Arab descent who lives in a small stone monastery in Syria: a man of middle age with a full, dark-brown beard; a plain dark-brown hood over his head; a long, plain dark-brown woollen robe tied with a simple rope belt; brown sandals; no cross, no jewellery, no book in hand. Pose and place: standing at the left, one hand open in welcome; full figure.
2. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: sitting cross-legged at the cloth, centre.
3. 4 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: sitting cross-legged around the cloth, some reaching for food, some looking at Bahira in surprise.

LAYOUT: Bahira stands at the left; the seated men sit side by side in one row behind and beside the cloth, all on the same horizontal base line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the food cloth with bread, dates and bowls on which they sit around, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, any child, wine, cross, ground, buildings, tree.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 6 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b06-bahira-egilmis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-bahira.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 116; BAHÎRÂ s. 486. Karşısındaki Efendimiz'i oynatıcı nur olarak çizer; görselde çocuk yok.*

```text
Scene b06-bahira-egilmis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Bahira bends slightly forward and looks down with deep attention and respect at someone of a twelve-year-old child's height standing in front of him at the left (that person is not drawn), his hands folded calmly.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Bahira, a Christian monk of Arab descent who lives in a small stone monastery in Syria: a man of middle age with a full, dark-brown beard; a plain dark-brown hood over his head; a long, plain dark-brown woollen robe tied with a simple rope belt; brown sandals; no cross, no jewellery, no book in hand. Pose and place: standing at the right half, upper body bent slightly forward, facing left, gaze directed down to a point at child's head height; full figure.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, a child, any other person, cross, book, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b06-bahira-ebu-talib

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-bahira.png`, `karakter-ebu_talib.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 116-117; BAHÎRÂ s. 486: Yahudilerden koru uyarısı.*

```text
Scene b06-bahira-ebu-talib. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Bahira speaks earnestly to Abu Talib, one hand raised in warning; Abu Talib listens with a worried, serious face.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Bahira, a Christian monk of Arab descent who lives in a small stone monastery in Syria: a man of middle age with a full, dark-brown beard; a plain dark-brown hood over his head; a long, plain dark-brown woollen robe tied with a simple rope belt; brown sandals; no cross, no jewellery, no book in hand. Pose and place: standing at the left, facing right, one hand raised in earnest warning; full figure.
2. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing at the right, facing left, listening with a worried face; full figure.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, a child, any other person, cross, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
