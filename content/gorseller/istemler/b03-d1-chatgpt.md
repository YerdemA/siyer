# b03-dogum: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da `content/gorseller/istemler/referans/uslup-u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `b02-d-kasva.png`). Atladığın olursa Claude Code'a söyle.

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

## Mesaj 1: b03-d-kabileler

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s01 tek ortak Kâbe görseli 26 sn; hadis kabilelerden söz ediyor. Dayanak: b03-s01 parça 1; i-b03-002.*

```text
Scene b03-d-kabileler. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Dawn, a vast Arabian landscape seen from far: several tribal encampments of goat-hair tents with herds spread across valleys and plains, smoke rising; far away, the narrow valley of Mecca between bare mountains.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 20 × tiny figures and herds. Pose and place: scattered among the camps, very small.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, writing, banners, maps

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b03-d-kura-oklari

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s03'ün iki çekimi aynı görsel (24 sn). Kura s05'te de kullanılır. Dayanak: b03-s03 parça 0; i-b03-004. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b03-d-kura-oklari. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Close shot inside the roofless Ka'ba (as in the attached interior reference): the hands of an elderly custodian draw plain, featherless divining arrows from a leather quiver; behind, out of focus, the large crude idol (Hubal) against the shadowed stone wall.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. the custodian of the idol, only his hands and forearms in a dark cloak are visible. Pose and place: hands in the centre holding the quiver.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: daylight falling in from the open sky above; the hands in light, the wall behind in soft shadow; no glow.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, human faces, blood, knives, writing on arrows

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b03-d-kabe-ic-kura

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`, `sahne-b03-on-ogul.png`, `karakter-abdulmuttalib.png`, `karakter-abdullah.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Kura 'Kâbe'nin içindeki Hübel putunun yanında' çekiliyor; bugün dışarıdan gösteriliyor. Dayanak: b03-s03 parça 0; i-b03-004. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b03-d-kabe-ic-kura. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime. Inside the old, roofless Ka'ba (match the attached interior reference if one is attached): a small, nearly rectangular enclosure a few paces across, walled by the same rough, unmortared grey-brown stones as the outside; no roof, the sky open above, daylight falling in from above onto the upper walls while the lower walls stay in soft shadow; packed earth floor; a plain wooden door at ground level in one wall. Before the large crude idol (Hubal) at the far wall, the custodian holds up a bundle of divining arrows; Abdul-Muttalib stands facing him, and his sons stand in a row along the side wall, Abdullah among them seen strictly from behind. Other idols stand along the walls in shadow.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. the custodian of the idol, an Arab man of about 50 with a black-and-grey beard, a dark head cloth and a dark brown cloak. Pose and place: at the right, before the idol, holding up the arrows.
2. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: at the left of centre, facing the custodian.
3. 4 × the sons of Abdul-Muttalib: grown men aged roughly 20 to 50, all clearly younger than their father; mixed beard lengths, all beards black or dark brown except the eldest with a little grey; off-white or sand head cloths and plain cloaks in muted brown, grey-blue and ochre. Pose and place: in a row along the left wall.
4. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: among the sons, strictly from behind.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: daylight falling in from the open sky above onto the upper walls and the people's heads; the floor in soft shadow; no glow.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, knives, sacrifice, roof, lamps, gold, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b03-d-on-deve

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`, `karakter-abdullah.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s04 tek uzak görsel 26 sn; kura usulü (on deve) anlatılıyor. Dayanak: b03-s04 parça 1; i-b03-005.*

```text
Scene b03-d-on-deve. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, in an open space near the Ka'ba: ten camels stand in a line; a little apart stands Abdullah, seen strictly from behind; Abdul-Muttalib stands beside him. The low, roofless Ka'ba looks exactly like the attached reference: rough, unmortared grey-brown stone walls a little taller than a man, no roof, no cloth covering, no door decoration.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: at the left, strictly from behind.
2. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: beside him, three-quarter view.
3. 10 × camels. Pose and place: in one line at the right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, knives, sacrifice

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b03-d-yesrib-hasta

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdullah.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s08 tek kervan görseli 18 sn; Yesrib'deki hastalık ve vefat görüntüsüz. Dayanak: b03-s08 parça 0; i-b03-010.*

```text
Scene b03-d-yesrib-hasta. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Night, a simple room in a house in Yathrib, lit by a small oil lamp: a young man lies covered on a bed, seen only from behind (back of the head and the blanket); two older men of the Banu Najjar sit beside him with bowed heads.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Abdullah, a slim young Arab man of about 18, ALWAYS seen strictly from behind (back of the head and back only, no face, no profile, no cheek); a plain off-white head cloth held by a dark brown cord band; a plain light sand-grey knee-length tunic with a brown belt; brown sandals. Pose and place: lying on the bed, strictly from behind, mostly covered.
2. 2 × older men of Yathrib with grey beards, plain cloaks. Pose and place: sitting beside the bed, heads bowed.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: night: deep indigo blues; the only warm light is the small orange-red flame described in the scene; no moon glow, no halo.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, Abdullah's face or profile, blood, death detail

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b03-d-amine-bekleyis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-amine.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı sahne: Âmine hamileyken Abdullah'ın ölümü. Dayanak: b03-s08 parça 1; i-b03-010.*

```text
Scene b03-d-amine-bekleyis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dusk, the doorway of a house in Mecca: Amina stands in the doorway seen strictly from behind, looking out along a lane towards the northern road.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Amina, a woman ALWAYS seen from behind or completely in shadow, face never visible; wrapped in a long deep indigo-blue cloak with a sand-coloured head covering that hides her hair and the sides of her face. Pose and place: in the doorway, strictly from behind.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, Amina's face or profile, any other person

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b03-d-kabe-ic-dua

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s12'nin ilk çekimi yalnız ortak Kâbe; 'onu alıp Kâbe'ye girdi, dua edip şükretti'. Mevcut b03-abdulmuttalib-kabe (kapıdan girerken) kısa açılış, sonra bu. Dayanak: b03-s12 parça 0; i-b03-015. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b03-d-kabe-ic-dua. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime. Inside the old, roofless Ka'ba (match the attached interior reference if one is attached): a small, nearly rectangular enclosure a few paces across, walled by the same rough, unmortared grey-brown stones as the outside; no roof, the sky open above, daylight falling in from above onto the upper walls while the lower walls stay in soft shadow; packed earth floor; a plain wooden door at ground level in one wall. Abdul-Muttalib stands alone in the middle of the enclosure, seen strictly from behind, head raised towards the open sky, as if praying and giving thanks; his arms are in front of him and not visible. The idols stand along the walls in deep shadow, ignored.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: in the centre, strictly from behind, head raised.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: soft daylight falling straight down from the open sky onto Abdul-Muttalib; the walls and idols in shadow; no glow, no rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any baby, bundle or child, any glow, any other person, roof, lamps, gold

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b03-d-sut-anne-arayis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s12'nin ilk çekimi yalnız ortak Kâbe; sıra değişir: önce mevcut Kâbe kapısı görseli, sonra bu. Dayanak: b03-s12 parça 1; i-b03-015.*

```text
Scene b03-d-sut-anne-arayis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, at the edge of Mecca: Abdul-Muttalib stands at the mouth of the valley looking out towards the desert road where a few small travellers come and go.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: at the left, looking to the right.
2. 3 × small distant travellers on donkeys. Pose and place: far away on the road.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any baby, glow

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
