# b10-hira: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

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

## Mesaj 1: b10-put-bayrami

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 143: Kureyş'in yılda bir bayram yaptığı, etrafında döndüğü taş put; adı verilmiyor. Put kaba yontulmuş taş (GORSEL_USLUP). Kan ve kesim yok.*

```text
Scene b10-put-bayrami. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A pagan festival: a crowd circles a crudely carved stone idol.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 10 people in total). Keep every listed colour and feature exactly as written:
1. a crudely carved stone idol about the height of a man, roughly hewn, weathered grey-brown stone, only a vague hint of head and shoulders, on a low rough stone base Pose and place: in the centre.
2. 10 × Meccan men and women in simple 6th-century Arabian clothes, muted colours, the women in head coverings Pose and place: walking in a loose circle around the idol, some in front, some partly behind it.

LAYOUT: Seen from eye level; the crowd's feet are close to one horizontal line in the lower part of the image; the idol's base is on the same line. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: blood, animals being slaughtered, fire, inscriptions, ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 10 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b10-dort-kisi

**Bu mesaja ekle:** `karakter-varaka.png`, `karakter-ubeydullah.png`, `karakter-osman_huveyris.png`, `karakter-zeyd_amr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Varaka, Ubeydullah b. Cahş, Osman b. Hüveyris, Zeyd b. Amr (İbn Hişâm s. 143). Kaynakta görünüş yok; belirgin özellik uydurulmaz.*

```text
Scene b10-dort-kisi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Four men walk quietly away together from left to right, seen from the side, glancing back over their shoulders; serious, thoughtful faces.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Waraqa ibn Nawfal, a man of about 60 with a long grey beard; an off-white head cloth with a dark cord; a cream tunic and a long dark-grey cloak. Pose and place: first in the row.
2. Ubaydallah ibn Jahsh, a young man of about 25 with a short black beard; a sand-coloured head cloth with a brown cord; a light tunic and an ochre cloak. Pose and place: second.
3. Uthman ibn al-Huwayrith, a man of about 40 with a medium black beard; a white head cloth with a dark cord; a cream tunic and a grey-blue cloak. Pose and place: third.
4. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: last, glancing back.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: ground, buildings, idols.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b10-dort-kisi-yakin

**Bu mesaja ekle:** `karakter-varaka.png`, `karakter-ubeydullah.png`, `karakter-osman_huveyris.png`, `karakter-zeyd_amr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; s03'teki dört kişiyle aynı kıyafet ve yaşlar korunmalı (aynı sohbette üret).*

```text
Scene b10-dort-kisi-yakin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: The same four men stand close together, heads leaned toward each other, talking in low voices; serious, thoughtful faces, no exaggerated expressions.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Waraqa ibn Nawfal, a man of about 60 with a long grey beard; an off-white head cloth with a dark cord; a cream tunic and a long dark-grey cloak. Pose and place: far left.
2. Ubaydallah ibn Jahsh, a young man of about 25 with a short black beard; a sand-coloured head cloth with a brown cord; a light tunic and an ochre cloak. Pose and place: second from left.
3. Uthman ibn al-Huwayrith, a man of about 40 with a medium black beard; a white head cloth with a dark cord; a cream tunic and a grey-blue cloak. Pose and place: second from right.
4. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: far right.

LAYOUT: The figure is cut at mid-chest by the bottom edge of the image; clear flat green space above the head and on both sides. No background of any kind: perfectly flat, uniform chroma green (#00B140) behind the figure, no green tint on the figure.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: walls, houses, background.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b10-sam-arazi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Şam yolu; arazi ayrıntısı kaynakta yok, belirgin bitki ve yapı çizilmez. Ufkun üstü yeşil perde.*

```text
Scene b10-sam-arazi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: An open plain near Syria with low rolling hills along the horizon and a dirt road crossing it, a few scattered low shrubs; flatter and less rocky than the steep bare mountains of Mecca.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: This is a ground layer. The horizon is a perfectly straight, horizontal line at 40% of the image height from the top; the ground fills everything below it to the bottom edge and to both side edges. Everything above the horizon is perfectly flat, uniform chroma green (#00B140): no sky, no clouds, no distant mountains. No green tint on the ground.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: buildings, people, crosses.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b10-zeyd-dua

**Bu mesaja ekle:** `karakter-zeyd_amr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Buhârî 3827: Zeyd ellerini kaldırıp dua eder. Yaş ve görünüş kaynakta yok.*

```text
Scene b10-zeyd-dua. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Zayd stands in open country and raises both open hands toward the sky in prayer, calm and resolute.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: standing in the centre, slightly from the side, a small travel bag over his shoulder.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: ground, buildings.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b10-kabe-duvar

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Kâbe duvarının bir parçası; malzeme, yükseklik ve örtü belirtilmez (anın tarihi kaynakta yok).*

```text
Scene b10-kabe-duvar. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A section of an ancient plain wall of rough, dark grey stone blocks laid in rows, filling the right half of the image from top to bottom edge.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: The wall section touches the top, right and bottom edges of the image; the left half is flat chroma green (#00B140). Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: cloth covering, door, inscriptions, gold, people.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b10-zeyd-yasli

**Bu mesaja ekle:** `karakter-zeyd_amr_yasli.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 144 'şeyh kebîr' (yaşlı); Buhârî 3828 sırtını Kâbe'ye dayamış. Başka görünüş ayrıntısı yok.*

```text
Scene b10-zeyd-yasli. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Old Zayd stands with his back leaning against a wall (the wall itself not drawn), one hand raised as he speaks earnestly.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr in old age: an old man of about 70 with a full white beard; the same undyed off-white head cloth without a cord, plain undyed wool tunic and simple brown cloak as in his younger days. Pose and place: standing in the centre, back slightly leaning, facing the viewer.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: wall, ground, other people.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b10-zeyd-sofra

**Bu mesaja ekle:** `karakter-zeyd_amr.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Onun gözünden. Zeyd yalnız konuşur; sofrayı kimin kime sunduğu ve kimin yemediği rivayetlerde farklı olduğu için jest yok.*

```text
Scene b10-zeyd-sofra. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: Seen by someone sitting on the ground: Zayd sits cross-legged on the far side of a round leather eating mat, facing the viewer and speaking calmly; hands resting on his knees.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Zayd ibn Amr, a man of about 50 with a full, medium-length dark beard with grey at the chin; an undyed off-white head cloth without a cord; a plain undyed wool tunic and a simple brown cloak. Pose and place: sitting cross-legged in the centre, facing the viewer.

LAYOUT: He sits on the same level as the viewer's eyes; the image is cut at his waist at the bottom edge; flat green space above his head and on both sides. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the eating mat (separate layer), pushing-away or refusing gesture, the viewer's hands, arms, feet or body.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b10-sofra

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Ön plan; içi gösterilmez (et ayrıntısı yalnız bir rivayette). ayar.gorsel ile yerleştirilecek.*

```text
Scene b10-sofra. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: A round leather eating mat spread flat, seen from a sitting person's eye level, with a simple covered wooden bowl on it; contents not visible.

PEOPLE: none. No people, animals, hands or figures of any kind.

LAYOUT: The object is shown complete with clear flat green space on all four sides (at least one tenth of the image). Draw only the object: no ground, cast shadow, people, hands or background; perfectly flat, uniform chroma green (#00B140) everywhere else, no green tint on the object.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: hands, people, ground around the mat.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b10-vadi-tas

*Kontrol: tam dolu görsel, perde yok; Müslim 2277: Mekke'de bir taş. Vadi/patika yok (o ayrıntı İbn Hişâm rivayetinde, dipnotta). Parıltı kesinlikle yok.*

```text
Scene b10-vadi-tas. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.

SUBJECT: Dawn, a quiet corner in Mecca: a single plain, medium-sized stone standing by itself next to a mudbrick wall.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: soft early dawn, cool blue-grey shadows and a faint apricot sky; no glow, no light rays.

DO NOT DRAW: people, face or features on the stone, glow, light rays, the viewer's hands, arms, feet or body.

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
