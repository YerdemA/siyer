# b09-hakem: ChatGPT ile görsel üretimi

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

## Mesaj 1: b09-d-duvar-boy

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s01 tek ortak Kâbe görseli 17 sn; duvarların tarifi. Dayanak: b09-s01 parça 0; i-b09-003.*

```text
Scene b09-d-duvar-boy. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dawn, the corner of the low, roofless Ka'ba seen close: rough, unmortared stones stacked in uneven courses, the wall a little taller than a man; one man of Quraysh stands beside it for scale, looking up at it. The low, roofless Ka'ba looks exactly like the attached reference: rough, unmortared grey-brown stone walls a little taller than a man, no roof, no cloth covering, no door decoration.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the left, beside the wall, looking up.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, roof, cloth covering, idols in the foreground

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b09-d-duveyk

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s02 tek görsel 17 sn; hazinenin bulunması. Dayanak: b09-s02 parça 1; i-b09-005.*

```text
Scene b09-d-duveyk. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, a lane in Mecca: men of Quraysh confront a frightened man (Duwayk, a freed slave of the Khuza'a) who holds an open cloth bundle; one of them points at it.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Duwayk, a thin man of about 40 with a short beard, a worn brown tunic and no head cloth. Pose and place: at the right, holding an open bundle.
2. 3 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the left, one pointing.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, gold glowing, writing, blood

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b09-d-kabe-ic-kuyu

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s02 tek görsel 17 sn; hazine 'Kâbe'nin içindeki kuyuda' saklanıyordu. Dayanak: b09-s02 parça 1; i-b09-005. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b09-d-kabe-ic-kuyu. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime. Inside the old, roofless Ka'ba (match the attached interior reference if one is attached): a small, nearly rectangular enclosure a few paces across, walled by the same rough, unmortared grey-brown stones as the outside; no roof, the sky open above, daylight falling in from above onto the upper walls while the lower walls stay in soft shadow; packed earth floor; a plain wooden door at ground level in one wall. The flat stone that covered the stone-lined pit in the floor has been pushed aside; the pit is empty and dark. A man of Quraysh kneels at its edge looking down in dismay; another stands behind him with a raised hand.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. 2 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: one kneeling at the pit's edge, one standing behind.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: daylight falling in from the open sky above; the pit very dark; no glow.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, gold, treasure, coins, roof, lamps, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b09-d-kabe-ic-tavan

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-yuksek.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Kâbe'nin içi, 605 sonrası ANA GÖRSEL: yeni tavan (gemi kerestesi, b09-s03) ve yükselen duvarlar. Onaylanınca referans/kabe-ic-yuksek.png. Dayanak: b09-s14 parça 0, 3; i-b09-022.*

```text
Scene b09-d-kabe-ic-tavan. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Inside the rebuilt Ka'ba, looking up: tall walls built in alternating courses, one course of rough stone, then one wooden beam, then stone again, rising about twice as high as before; a new flat roof of heavy, weathered wooden beams and planks (old ship timber) closes the top; a plain wooden stair rises along one wall to a corner of the roof; a single-leaf wooden door is set high in the opposite wall, and daylight comes in only through that door, leaving the room dim. Packed earth floor. Nobody inside.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dim interior; one soft patch of daylight from the high door falls on the floor and walls; warm brown shadows; no glow, no rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any person, idols in the foreground, lamps, gold, cloth hangings, writing, columns of marble

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b09-d-yuksek-kapi

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-yuksek.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s14 tek ortak Kâbe görseli 21 sn. Dayanak: b09-s14 parça 1; i-b09-023.*

```text
Scene b09-d-yuksek-kapi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, close view of the rebuilt Ka'ba's single-leaf wooden door set high above the ground; a man of Quraysh at the foot of the wall looks up at it. The Ka'ba looks exactly like the attached reference: rebuilt, clearly taller, with a flat roof and a single-leaf door set high above the ground.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: at the bottom left, looking up.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, stairs, ladders, cloth covering, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
