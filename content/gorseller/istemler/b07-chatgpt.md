# b07-genclik: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

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

## Mesaj 1: b07-ukaz

*Kontrol: tam dolu görsel, perde yok; UKÂZ (c. 42, s. 61-62): Tâif ile Nahle arasında, taşlık, su kaynakları olan geniş vadi; kabilelerin bayrak ya da işaretle belirlenmiş yerleri; şairler kırmızı deriden çadırlarda şiir okurdu. Panayırın görünüşü başka ayrıntıda kaynakta yok.*

```text
Scene b07-ukaz. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: The Ukaz fair seen from a distance: a wide, stony valley with a few small springs and low scrub, ringed by low bare hills under a clear sky. Across the valley stands a large seasonal fair: simple cloth awnings on poles, low tents of dark goat hair and a few of red leather, goods laid out on mats (bales of cloth, leather, jars, baskets), kneeling camels, and a crowd of small, undetailed people moving between them. Here and there a plain cloth banner on a pole marks where a tribe has camped. Keep the foreground in the lower third mostly open, sandy ground.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 60 × small, undetailed Arab men and a few women in muted brown, sand and grey-blue clothes. Pose and place: spread across the fair in small groups, walking, trading, talking.
2. about 12 × camels, some with loads. Pose and place: kneeling or standing among the tents.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, buildings of stone, domes, minarets, writing or lettering on banners, crosses, idols, blood.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b07-sair

*Kontrol: yeşil perde; nesne kenarlara değmemeli; UKÂZ (s. 62), ARAP (c. 3, s. 324): şairler en güzel şiirlerini Ukâz'da okurdu. Kişilerin görünüşü kaynakta yok.*

```text
Scene b07-sair. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: At the fair: a poet stands and recites with one hand raised, while a small group of men of different tribes listens, some sitting, some standing. Calm, peaceful.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. a poet, a man of about 40 with a short black beard, a grey-blue cloak over a cream tunic, an off-white head cloth. Pose and place: standing at the left, one hand raised as he recites, facing right.
2. 4 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: two sitting cross-legged and two standing at the right, all turned towards the poet, listening.

LAYOUT: The poet stands at the left; the listeners sit or stand side by side at the right; everyone's feet or seated base on one horizontal line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, women, children, scrolls, writing, tents, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b07-tartisma

*Kontrol: yeşil perde; nesne kenarlara değmemeli; FİCÂR (s. 52): birinci Ficâr Ukâz'da bir adamın 'Arapların en şereflisi benim' diye övünmesiyle başladı. Sahnede saldırı ya da yara gösterilmez.*

```text
Scene b07-tartisma. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A quarrel breaking out at the fair: two groups of men face each other angrily, one man in the middle boasting with his chest out; two older men step between the groups with open hands to calm them. No one is hit or hurt.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 9 people in total). Keep every listed colour and feature exactly as written:
1. a boastful man of about 30 with a black beard, sand-coloured cloak, off-white head cloth. Pose and place: in the centre-left, chin raised, one hand on his chest.
2. 3 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the left behind the boastful man, frowning.
3. 3 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the right, facing them angrily, fists clenched at their sides.
4. 2 × two older men with grey beards in brown cloaks. Pose and place: in the middle between the groups, arms out, palms open, calming them.

LAYOUT: All nine men stand side by side on one horizontal foot line in the lower part of the image; the two groups face each other with the two peacemakers between them. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, weapons drawn, swords, blood, wounds, women, children, ground, tents, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 9 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b07-berrad

*Kontrol: yeşil perde; nesne kenarlara değmemeli; FİCÂR (s. 52), İbn Hişâm (s. 118): Kinâneli Berrâd b. Kays, Urve'yi takip edip öldürdü. Öldürme anı çizilmez; görünüşü kaynakta yok (kötü bilinen biri).*

```text
Scene b07-berrad. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A lone man crouches behind a large rock, half-hidden, watching something far away to the left with a cold, determined look.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. a lean man of about 35 with an unkempt black beard, a dark-brown cloak, a dark head cloth pulled low; a sheathed sword at his side. Pose and place: crouching behind the rock at its right side, looking left over it.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the single large sand-coloured rock he hides behind, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, drawn sword, blood, horse, camel, any other person, ground, sky.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b07-takip

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 118): Kureyş Ukâz'dan ayrıldı, Hevâzin peşlerine düştü, Harem'e girene kadar çarpıştılar. Binek ve sayı kaynakta yok; atlı çizilmez.*

```text
Scene b07-takip. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Two groups of men in the desert at a distance, seen from the side: at the left a group of Quraysh men hurrying away to the left with a few loaded camels; at the right, some distance behind, a larger group of Hawazin men running after them with bows and spears raised. Dust kicked up at their feet.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 8 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: the left group, hurrying left, some looking back over their shoulders.
2. 3 × camels with loads. Pose and place: walking quickly among the left group.
3. about 12 × small, undetailed Hawazin tribesmen in dark brown and grey cloaks and head cloths, with simple bows and spears. Pose and place: the right group, running left after them.

LAYOUT: All figures form one long horizontal band in the lower part of the image, seen exactly from the side, all feet on the same horizontal line, with a clear gap between the two groups. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: a little dust at the feet of the runners.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, horses, fighting, blood, fallen people, ground, buildings, sky.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b07-ebu-talib-ikna

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebu_talib.png`, `karakter-abdullah_b_cudan.png`, `karakter-zubeyr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; FİCÂR (s. 52), KUREYŞ (s. 443): Ebû Tâlib haram aylar gerekçesiyle razı olmadı; Abdullah b. Cüd'ân ve Harb ısrar etti; Hâşimoğulları Zübeyr komutasında katıldı. Yüzler çizilebilir.*

```text
Scene b07-ebu-talib-ikna. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Four men of Quraysh in earnest discussion: Abu Talib stands serious and unwilling, one hand slightly raised as if saying 'not in the sacred months'; Harb ibn Umayya and the old Abdullah ibn Jud'an speak to him insistently; Zubayr stands a little behind, listening.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abu Talib, a man of about 42 with a full, short black beard; an off-white head cloth with a dark brown cord band; a cream tunic and a long olive-brown cloak with a thin dark border; brown sandals. Pose and place: standing at the left, facing right, serious, one hand raised slightly.
2. Harb ibn Umayya, a powerful chieftain of Quraysh of about 50 with a full black beard streaked with grey; an off-white head cloth with a black cord band; a cream tunic and a long dark red-brown cloak; a stern, commanding look. Pose and place: standing centre-right, facing left, gesturing firmly with an open hand.
3. Abdullah ibn Jud'an, a very old, wealthy and dignified chieftain of Quraysh, about 75, slightly stooped; a long white beard; a white head cloth with a brown cord band; a long cream tunic and a finely woven saffron-ochre cloak with a narrow woven border; he leans on a plain wooden staff; no jewellery, no gold. Pose and place: standing at the right, facing left, leaning on his staff, speaking.
4. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: standing between Abu Talib and Harb, one step behind them, listening.

LAYOUT: All four stand side by side on one horizontal foot line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, weapons, children, women, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b07-hasimogullari

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zubeyr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 118), FİCÂR (s. 52): amcaları onu yanlarında götürdü. Efendimiz'i oynatıcı nurlu figür olarak boşluğa koyar; görselde çizilmez.*

```text
Scene b07-hasimogullari. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: The men of the Hashim clan ready to set out with Zubayr: Zubayr in front, the others behind him with simple bows and round leather shields. Calm and serious. Leave a clear empty gap at the right of the group, about one person wide, where someone of a young man's height will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 5 people in total). Keep every listed colour and feature exactly as written:
1. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: standing at the left front, facing right, a round leather shield on his arm.
2. 4 × men of the Hashim clan, Arab men aged 30 to 50 with black or greying beards, in off-white head cloths and muted brown, grey and ochre cloaks, each with a simple bow or a round leather shield. Pose and place: standing side by side to the right of Zubayr.

LAYOUT: Everyone stands side by side on one horizontal foot line in the lower part of the image; leave an empty gap about one person wide at the right end of the row, then green space. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, a young man or boy, any figure in the gap, drawn swords, blood, horses, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 5 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b07-ok-toplama

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 119): 'Amcalarıma ok verirdim.' FİCÂR (s. 52): atılan okları kalkanla karşılayıp toplayarak onlara verirdi. Onun gözünden; Efendimiz çizilmez.*

```text
Scene b07-ok-toplama. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: A desert battlefield seen through the eyes of a young man standing just behind his uncles: in the foreground, three men stand with their backs to the viewer, holding round leather shields and bows; far in the distance a large cloud of dust where two crowds clash, small and undetailed. On the sand in front of the viewer lie several spent arrows, scattered. Bare hills, clear sky.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. 3 × the viewer's uncles, Arab men seen only from behind, in off-white head cloths and muted brown, indigo-grey and ochre cloaks, with round leather shields and bows. Pose and place: standing in the middle ground with their backs to the viewer, facing the distant battle; no faces visible.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, the viewer's hands, arms, feet or body, blood, wounds, fallen people, arrows sticking in anyone, faces of the three uncles, horses, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b07-dagilan

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 119), FİCÂR (s. 52): Kureyş ve Kinâne kazandı. Ölü ve yaralı gösterilmez.*

```text
Scene b07-dagilan. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: After the battle: two crowds of men walking slowly away from each other across the desert, one to the left and one to the right, tired, some carrying shields; a gap of empty space between them. Small and undetailed.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 10 × small, undetailed Arab men in muted brown and grey cloaks. Pose and place: the left group, walking away to the left.
2. about 10 × small, undetailed Arab men in darker brown and grey cloaks. Pose and place: the right group, walking away to the right.

LAYOUT: Both groups form one long horizontal band in the lower part of the image, all feet on the same horizontal line, with an empty gap in the middle. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, fallen people, blood, wounds, horses, ground, sky.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b07-tuccar-as

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zubeydli_tuccar.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; HİLFÜ'L-FUDÛL (s. 31-32), Hadislerle İslâm c. 3: Zübeydli tüccar malını Âs b. Vâil'e sattı, parasını alamadı.*

```text
Scene b07-tuccar-as. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: In the market of Mecca: the Yemeni merchant stands beside his bundled goods, holding out an open hand and asking to be paid; al-As ibn Wa'il turns half away with a dismissive wave of his hand, refusing.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. a merchant from the Zubayd tribe of Yemen, a man of about 35 with a short black beard; a dark-brown head cloth wound into a small, simple wrap; a knee-length undyed tunic and a cloak woven in narrow stripes of indigo and natural wool; a small leather pouch at his belt; brown sandals. Pose and place: standing at the left, facing right, one hand held out, palm up, a pleading look; bundles of cloth and leather at his feet.
2. al-As ibn Wa'il, a wealthy, proud man of Quraysh of about 45 with a neatly trimmed black beard; a white head cloth with a dark cord band; a fine cream tunic and a deep crimson-brown cloak with a narrow woven border; no jewellery. Pose and place: standing at the right, body turned half away to the right, head turned back, one hand waving dismissively.

LAYOUT: Both men stand side by side on one horizontal foot line in the lower part of the image, with clear space between them. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the merchant's three bundles of goods on the ground beside him, which are drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, money, coins, other people, ground, buildings, stalls.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b07-ebukubeys

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `nesne-kabe-alcak.png`, `karakter-zubeydli_tuccar.png`

*Kontrol: tam dolu görsel, perde yok; HİLFÜ'L-FUDÛL (s. 32): tüccar Ebûkubeys tepesine çıkıp mağduriyetini şiirle dile getirdi. Tepenin biçimi kaynakta yok; sade, kayalık.*

```text
Scene b07-ebukubeys. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Early morning in Mecca, wide view across the valley: on the top of a bare, rocky hill rising beside the town, a single small man stands with both arms raised, calling out loudly over the town. Below, the flat-roofed houses built like the attached reference and the low, roofless Ka'ba as a small dark block; a few tiny people in front of the houses look up towards the hill.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (1 individually listed people). Keep every listed colour and feature exactly as written:
1. a merchant from the Zubayd tribe of Yemen, a man of about 35 with a short black beard; a dark-brown head cloth wound into a small, simple wrap; a knee-length undyed tunic and a cloak woven in narrow stripes of indigo and natural wool; a small leather pouch at his belt; brown sandals. Pose and place: very small, standing on the hilltop at the upper right, both arms raised, facing the town.
2. about 8 × tiny, undetailed townspeople. Pose and place: in front of the houses, looking up towards the hill.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: soft early-morning daylight, low sun from the left; no glow, no light rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, minarets, domes, crowds on the hill, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b07-cudan-avlu

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-abdullah_b_cudan.png`, `karakter-zubeyr.png`

*Kontrol: tam dolu görsel, perde yok; HİLFÜ'L-FUDÛL (s. 32), İbn Hişâm (s. 85): toplantı Abdullah b. Cüd'ân'ın evinde. Evin görünüşü kaynakta yok; sade. Efendimiz bu görselde çizilmez.*

```text
Scene b07-cudan-avlu. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the courtyard of Abdullah ibn Jud'an's house in Mecca, a plain house of stone and mudbrick like the attached reference but larger, with a wide courtyard. The old Abdullah ibn Jud'an sits on a low bench against the wall; Zubayr bends towards him and speaks earnestly; around the courtyard, men of Quraysh sit on the ground and listen. Bare mountains of Mecca above the courtyard wall.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 8 people in total). Keep every listed colour and feature exactly as written:
1. Abdullah ibn Jud'an, a very old, wealthy and dignified chieftain of Quraysh, about 75, slightly stooped; a long white beard; a white head cloth with a brown cord band; a long cream tunic and a finely woven saffron-ochre cloak with a narrow woven border; he leans on a plain wooden staff; no jewellery, no gold. Pose and place: sitting on a low stone bench at the centre-left, both hands on his staff, listening.
2. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: standing in front of him, bending slightly forward, one hand open, speaking.
3. 6 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: sitting cross-legged on the ground in a loose half circle to the right, turned towards the two.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, women, children, gold, rich carpets, cushions, arches, domes, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 8 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 13: b07-yemin

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `b07-cudan-avlu.png`, `nesne-mekke-evler.png`, `karakter-abdullah_b_cudan.png`, `karakter-zubeyr.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm (s. 85-86), HİLFÜ'L-FUDÛL (s. 32): yemin. Yemin biçimi kaynakta yok; el birleştirme çizilmez. Efendimiz'i oynatıcı nurlu figür olarak boşluğa koyar. 'b07-cudan-avlu' önce üretilmeli.*

```text
Scene b07-yemin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: The same courtyard as in the attached wide image: the men of Quraysh now stand in a group around the old Abdullah ibn Jud'an and Zubayr, serious and solemn, as they swear an oath together. Leave a clear empty space on the ground at the right-centre, about one person wide, where a tall figure will be added later.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 8 people in total). Keep every listed colour and feature exactly as written:
1. Abdullah ibn Jud'an, a very old, wealthy and dignified chieftain of Quraysh, about 75, slightly stooped; a long white beard; a white head cloth with a brown cord band; a long cream tunic and a finely woven saffron-ochre cloak with a narrow woven border; he leans on a plain wooden staff; no jewellery, no gold. Pose and place: standing at the centre-left, leaning on his staff.
2. Zubayr ibn Abd al-Muttalib, a vigorous man of about 45 with a full, short black beard with a few grey hairs; an off-white head cloth with a black cord band; a cream tunic and a long dark indigo-grey cloak with a thin brown border; a plain leather belt; brown sandals. Pose and place: standing beside him at the centre.
3. 6 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: standing around them, three at the left and three at the far right, solemn faces turned to the centre; leave the right-centre empty.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even, neutral daylight from the front-left, soft shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, any figure in the empty space, joined hands, raised swords, cups, women, children, writing.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 8 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
