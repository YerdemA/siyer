# b07-genclik: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da `content/gorseller/istemler/referans/uslup-u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `b02-d-kasva.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 585-590 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone and the low, roofless Ka'ba) and the open, stony valley of the Ukaz fair between Ta'if and Nakhla. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b07-d-ukaz-yakin

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s01 tek uzak görsel 19 sn. 2026-11-24 yeniden (isteğe bağlı): ilk üretimde mantarlı, şeffaf cam şişeler günümüzden kalma gibi duruyordu. Dayanak: b07-s01 parça 1; i-b07-001.*

```text
Scene b07-d-ukaz-yakin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Daytime, close view inside the fair of Ukaz: goods laid out on mats: rolls of cloth, leather goods, small clay jars and leather flasks of perfume and oil sealed with cloth and cord, dates; traders' hands weigh goods on a small balance.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. 2 × traders, only their hands and forearms in plain sleeves visible. Pose and place: weighing at the centre.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, faces, writing, coins with writing, glass bottles, clear glass, corks, stoppers

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b07-d-silah-birakma

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s02 tek görsel 15 sn; haram ayda savaşın kesilmesi. Dayanak: b07-s02 parça 1; i-b07-002.*

```text
Scene b07-d-silah-birakma. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, at the fair of Ukaz: men of different tribes lay their swords in their scabbards and their spears on the ground beside a tent; two of them greet each other with clasped hands.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 6 people in total). Keep every listed colour and feature exactly as written:
1. 3 × Bedouin men in plain undyed wool tunics and loosely wrapped dark head cloths. Pose and place: at the left, laying down weapons.
2. 3 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: at the right, two clasping hands.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, fighting

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 6 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b07-d-ovunen

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s03 tek görsel 26 sn. Dayanak: b07-s03 parça 1; i-b07-003.*

```text
Scene b07-d-ovunen. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, at the fair of Ukaz: a proud man stands on a low rock, chest out, one arm raised, boasting loudly; the crowd below reacts: some men angry, some pointing at him.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (1 individually listed people). Keep every listed colour and feature exactly as written:
1. a proud Arab man of about 35 with a black beard, a red-brown head cloth and a fine ochre cloak. Pose and place: on the rock in the centre.
2. about 8 × Bedouin men in plain undyed wool tunics and loosely wrapped dark head cloths; men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: around the rock, reacting.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, weapons in use, women

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b07-d-toz-savas

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı sahne: Ficâr savaşları. Dayanak: b07-s03 parça 2; i-b07-004.*

```text
Scene b07-d-toz-savas. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Late afternoon, a wide plain: in the distance two masses of men clash in a thick cloud of dust; nothing is seen clearly; the sky is dull orange.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 30 × tiny figures in dust. Pose and place: far away, blurred by dust.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, bodies, close fighting

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b07-d-iki-saf

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s04 tek görsel 22 sn. Dayanak: b07-s04 parça 0; i-b07-005.*

```text
Scene b07-d-iki-saf. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, a wide plain: two tribal armies face each other in long lines, a stretch of empty ground between them; camels and a few horses; nobody has attacked yet.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 20 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool (Quraysh and Kinana). Pose and place: a long line at the left.
2. about 20 × Bedouin men in plain undyed wool tunics and loosely wrapped dark head cloths (Qays Aylan). Pose and place: a long line at the right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, banners with writing

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b07-d-toplanma

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-zubeyr.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s12 tek avlu görseli 22 sn. Dayanak: b07-s12 parça 1; i-b07-016, i-b07-017.*

```text
Scene b07-d-toplanma. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Late afternoon, the gate of Abdullah ibn Jud'an's house in Mecca: elders of several clans of Quraysh arrive and enter one by one; Zubayr greets them at the gate.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: at the gate, greeting.
2. 6 × elderly men of Quraysh with grey beards, off-white head cloths, cloaks in muted brown, grey-blue and ochre. Pose and place: arriving from the left, in pairs.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, the Prophet, weapons

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b07-d-genc-katilim

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdullah_b_cudan.png`, `karakter-zubeyr.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s13 tek görsel 29 sn. Dayanak: b07-s13 parça 1; i-b07-019.*

```text
Scene b07-d-genc-katilim. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the courtyard of Abdullah ibn Jud'an: men of Quraysh stand in a circle for the oath; Abdullah ibn Jud'an and Zubayr among them; in the circle, between Zubayr and another man, a place is left empty at the height of a tall young man: a tall figure will be added there later by the app, so keep that spot completely empty: no person, no object, no shadow, no glow.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 8 people in total). Keep every listed colour and feature exactly as written:
1. Abdullah ibn Jud'an, a very old, wealthy and dignified chieftain of Quraysh, about 75, slightly stooped; a long white beard; a white head cloth with a brown cord band; a long cream tunic and a finely woven saffron-ochre cloak with a narrow woven border; he leans on a plain wooden staff; no jewellery, no gold. Pose and place: at the left of the circle.
2. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: right of the empty place.
3. 6 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: completing the circle.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, weapons, blood, swearing over fire

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 8 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b07-d-hak-teslim

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı sahne: antlaşmadan sonra hakların geri alınması (genel). Dayanak: b07-s13 parça 2; i-b07-020, i-b07-021.*

```text
Scene b07-d-hak-teslim. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, a market lane in Mecca: a few members of the alliance stand behind a stranger in foreign travelling clothes as a rich man hands him back a bundle of goods; the stranger holds it with relief.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. a stranger from outside Mecca of about 40 with a short beard, a dusty grey head cloth and a striped cloak. Pose and place: in the centre, receiving the bundle.
2. a rich man of Quraysh in a fine dark cloak. Pose and place: at the right, handing over the bundle.
3. 3 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: at the left behind the stranger.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, coins with writing, weapons

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b07-d-kizil-develer

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s14 tek ortak Kâbe görseli 21 sn; 'kızıl develer' sözü görsel bir benzetme. Dayanak: b07-s14 parça 1; i-b07-023.*

```text
Scene b07-d-kizil-develer. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Late afternoon, a herd of fine red-brown camels grazing on a stony plain, their coats glowing warm in the low sun; no herdsman in sight.

ANIMALS AND OBJECTS: draw exactly these and no people:
1. about 12 × red-brown camels. Pose and place: grazing across the plain.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
