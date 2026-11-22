# b10-hira: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da `content/gorseller/istemler/referans/uslup-u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `b02-d-kasva.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b10-d-tepeden

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-yuksek.png`, `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s01 tek ortak Kâbe görseli 9 sn. Dayanak: b10-s01 parça 0; i-b10-001.*

```text
Scene b10-d-tepeden. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: Late afternoon, seen through his eyes from a rocky hillside above Mecca: the valley below with its houses and the tall rebuilt Ka'ba; the viewer's body, hands and feet never appear. The Ka'ba looks exactly like the attached reference: rebuilt, clearly taller, with a flat roof and a single-leaf door set high above the ground.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, the viewer's hands, arms or feet, any close person

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b10-d-tavaf-put

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `b10-put-bayrami.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s03'ün ikinci çekimi 19 sn aynı bileşim. Dayanak: b10-s03 parça 1; i-b10-013.*

```text
Scene b10-d-tavaf-put. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, an open area in the Mecca valley: a crowd walks in a circle around a crudely carved stone idol (the same idol as in the attached festival image); some tie cloth strips to it. No slaughter shown.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 16 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: walking in a circle around the idol.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, sacrifice, knives

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b10-d-dagilis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-varaka.png`, `karakter-ubeydullah.png`, `karakter-osman_huveyris.png`, `karakter-zeyd_amr.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s04 tek görsel 29 sn. Dayanak: b10-s04 parça 1; i-b10-014.*

```text
Scene b10-d-dagilis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Dawn, a crossroads outside Mecca: four men part ways, each walking off along a different road; two look back over their shoulders.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Waraqa ibn Nawfal, a man of about 60 with a long grey beard; an off-white head cloth with a dark cord; a cream tunic and a long dark-grey cloak. Pose and place: walking to the far left.
2. Ubaydallah ibn Jahsh, a young man of about 25 with a short black beard; a sand-coloured head cloth with a brown cord; a light tunic and an ochre cloak. Pose and place: walking to the near left.
3. Uthman ibn al-Huwayrith, a man of about 40 with a medium black beard; a white head cloth with a dark cord; a cream tunic and a grey-blue cloak. Pose and place: walking to the near right.
4. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: walking to the far right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, weapons

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b10-d-varaka-kitap

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-varaka.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahne: Varaka'nın kitaplardan bilgi edinmesi. Dayanak: b10-s04 parça 2; i-b10-015.*

```text
Scene b10-d-varaka-kitap. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Night, a small room lit by an oil lamp: Waraqa sits on a mat reading a long scroll (no readable writing, only faint marks); more scrolls lie beside him.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Waraqa ibn Nawfal, a man of about 60 with a long grey beard; an off-white head cloth with a dark cord; a cream tunic and a long dark-grey cloak. Pose and place: seated, reading.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: night: deep indigo blues; the only warm light is the small orange-red flame described in the scene; no moon glow, no halo.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, crosses, readable writing, icons

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b10-d-osman-bizans

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-osman_huveyris.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı parça: Osman'ın Bizans'a gidişi. Dayanak: b10-s04 parça 2; i-b10-015.*

```text
Scene b10-d-osman-bizans. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, the great stone gate of a Byzantine city with high walls: Uthman ibn al-Huwayrith arrives on a camel, looking up at the walls; guards in plain tunics at the gate.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Uthman ibn al-Huwayrith, a man of about 40 with a medium black beard; a white head cloth with a dark cord; a cream tunic and a grey-blue cloak. Pose and place: on a camel, at the left.
2. 2 × Byzantine guards in plain tunics and simple helmets. Pose and place: at the gate.
3. camel. Pose and place: carrying Uthman.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, crosses, icons, domes, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b10-d-yahudi-alim

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_amr.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s05'in ikinci çekimi aynı dua görseli 25 sn. Dayanak: b10-s05 parça 1; i-b10-017.*

```text
Scene b10-d-yahudi-alim. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the shaded portico of a stone house in Syria: Zayd ibn Amr sits on a mat listening to an old Jewish scholar with a long grey beard, a dark robe and a striped prayer shawl over his shoulders, who holds a closed scroll.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: seated at the left, listening.
2. an old Jewish scholar with a long grey beard, a dark robe and a cream shawl with dark stripes over his shoulders. Pose and place: seated at the right, holding a closed scroll.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, writing, symbols, stars, menorahs

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b10-d-hristiyan-alim

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_amr.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı parça: ardından bir Hıristiyan âlimle konuşma. Dayanak: b10-s05 parça 1; i-b10-017.*

```text
Scene b10-d-hristiyan-alim. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, in front of a small stone monastery in Syria: Zayd ibn Amr stands before an old monk with a white beard in a long dark-grey robe, who raises one open hand as he speaks.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: at the left, listening.
2. an old monk with a white beard, a long dark-grey robe and a small black cap. Pose and place: at the right, speaking.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, crosses, icons, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b10-d-zeyd-yuz-cevirme

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-zeyd_amr_yasli.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s06 tek görsel 38 sn (en uzun durağan çekim). Dayanak: b10-s06 parça 0; i-b10-016.*

```text
Scene b10-d-zeyd-yuz-cevirme. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, near a crudely carved stone idol in Mecca: men offer pieces of meat on a flat stone before the idol; Zayd ibn Amr turns away from them, raising one hand in refusal.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr in old age: an old man of about 70 with a full white beard; the same undyed off-white head cloth without a cord, plain undyed wool tunic and simple brown cloak as in his younger days. Pose and place: at the right, turning away.
2. 3 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: at the left by the idol.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, slaughter, knives

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b10-d-kiz-kurtarma

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-zeyd_amr_yasli.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahne: kız çocuğunu kurtarması. Dayanak: b10-s06 parça 1; i-b10-016.*

```text
Scene b10-d-kiz-kurtarma. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, at the edge of Mecca: Zayd ibn Amr gently takes the hand of a small girl (seen from behind) from a stern man and leads her towards himself; the man stands aside.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr in old age: an old man of about 70 with a full white beard; the same undyed off-white head cloth without a cord, plain undyed wool tunic and simple brown cloak as in his younger days. Pose and place: at the right, holding the girl's hand.
2. a small girl of about 5 seen strictly from behind, plain dress and head covering. Pose and place: in the centre.
3. a stern Arab man of about 40 with a black beard and a dark cloak. Pose and place: at the left, stepping aside.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, digging, graves, violence

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b10-d-zeyd-kabir

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s07 tek görsel 24 sn; Zeyd'in vefatı. Dayanak: b10-s07 parça 2; i-b10-020.*

```text
Scene b10-d-zeyd-kabir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Dusk, a simple grave of heaped stones in a dry valley; a lone thornbush beside it; no one there.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, writing, glow

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
