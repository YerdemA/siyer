# b04-sut-anne: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da `content/gorseller/istemler/referans/uslup-u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `b02-d-kasva.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 571-576 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone) and the dry steppe lands of the Bedouin tribe of Banu Sa'd. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b04-d-cocuk-yuzler

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Yamaçtan göz yakın planlarına köprü: çocuklar bir şey görüp dönüyor. 2026-11-24 yeniden: ilk üretimde üç çocuk birbirinin aynısıydı ve yamaçtaki çocuklara benzemiyordu. Dayanak: b04-s07 parça 0; i-b04-011.*

```text
Scene b04-d-cocuk-yuzler. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Daytime, on the same hillside as the attached hillside image: close shot of the three boys who were playing there, side by side, their heads turned towards the left edge of the image, eyes wide, mouths slightly open in wonder; what they see is outside the frame. The three boys must look clearly different from each other (age, skin tone, hair, head cloth, tunic colour) and match the three children in the hillside image.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. boy A, about 7, light-brown skin, thick black brows, short curly black hair, no head cloth, a sand-coloured tunic. Pose and place: at the left, head turned to the left.
2. boy B, about 6, medium-brown skin, round face, an off-white head cloth wrapped round his head with a dark band, a brown tunic. Pose and place: in the centre, head turned to the left.
3. boy C, about 5, darker brown skin, fine brows, curly black hair, no head cloth, a grey-blue tunic. Pose and place: at the right, smallest, head turned to the left.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, anything they are looking at, light beams, angels, three identical faces, matching head cloths

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b04-d-goz-1

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Göz yansıması dizisi 1/5: Cebrâil'in gelişi. 2026-11-24 yeniden: ilk üretimde yansıma küçük ve okunaksızdı, gök akşamdı, iki ışık her karede başka biçimdeydi, kalp anı seçilmiyordu. Dayanak: b04-s07 parça 0; i-b04-011.*

```text
Scene b04-d-goz-1. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.

SUBJECT: Extreme close-up of one eye of boy A, about 7, light-brown skin, thick black brows, short curly black hair, no head cloth, a sand-coloured tunic (the same boy A as in the attached hillside image and earlier in this chat). The eye fills the image, a little right of centre (the camera will drift from right to left); lashes, part of the eyebrow and the cheek are simple layered paper shapes. The iris is very large: it fills about two thirds of the image height, and the reflection inside it is large, sharp and easy to read, like a small round painting set in the dark, glossy iris, with one small white highlight at its upper left. The reflection shows the same sunlit hillside as the attached hillside image, seen from where the children stand: clear blue daytime sky, the far mountains, the tree at the left, brown grass and a few grazing lambs; NOT dusk, NOT night. Only two lights are in it, drawn the same way in every image: THE CHILD is a small, soft, warm golden-white light about the size of a lamb; THE VISITOR is one tall, upright column of soft pure-white light with blurred edges, about three times taller than the small light, standing on the grass; it is never a beam or ray from the sky, never an arc, never a comet. There is no human, child or angel shape anywhere in the reflection. In the reflection: the tall white light has just come down from the sky and now stands on the slope a little apart from the small golden light, which is among the lambs; a faint, short trail of white above the tall light shows it came down; the lambs lift their heads.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: bright, neutral daylight on the skin and in the reflection; the only glowing points are the lights inside the reflection.

DO NOT DRAW: any human, child or angel shape in the reflection, wings, silhouettes, faces in the reflection, hands, body, chest, anatomical heart, heart symbol, blood, red colour in the reflection, knife, tears, light beam or ray from the sky, comet, shooting star, dusk or night sky

BEFORE YOU OUTPUT, CHECK AND FIX: exactly one eye, with a natural eyelid, lashes and brow, no second eye, no extra eyelids; the reflection sits inside the iris and shows only the hillside and what the prompt lists; no human, child or angel shape, wings or silhouette anywhere in the reflection: only the small warm golden-white light, the tall pure white light and the objects the prompt lists (bright spark, dark speck, golden basin); the two lights look the same as described in every image: the visitor is an upright column of white light standing on the grass, never a beam, ray, arc or comet; the reflection shows bright daytime with a blue sky, the same hillside as the attached image; no blood, anatomical heart, chest, knife or body parts; no text, letters, crosses, minarets, domes or crescents.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 3: b04-d-goz-2

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Göz yansıması dizisi 2/5: yere yatırılması. 2026-11-24 yeniden: ilk üretimde yansıma küçük ve okunaksızdı, gök akşamdı, iki ışık her karede başka biçimdeydi, kalp anı seçilmiyordu. Dayanak: b04-s07 parça 1; i-b04-011.*

```text
Scene b04-d-goz-2. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.

SUBJECT: Extreme close-up of one eye of boy B, about 6, medium-brown skin, round face, an off-white head cloth wrapped round his head with a dark band, a brown tunic (the same boy B as in the attached hillside image and earlier in this chat). The eye fills the image, a little right of centre (the camera will drift from right to left); lashes, part of the eyebrow and the cheek are simple layered paper shapes. The iris is very large: it fills about two thirds of the image height, and the reflection inside it is large, sharp and easy to read, like a small round painting set in the dark, glossy iris, with one small white highlight at its upper left. The reflection shows the same sunlit hillside as the attached hillside image, seen from where the children stand: clear blue daytime sky, the far mountains, the tree at the left, brown grass and a few grazing lambs; NOT dusk, NOT night. Only two lights are in it, drawn the same way in every image: THE CHILD is a small, soft, warm golden-white light about the size of a lamb; THE VISITOR is one tall, upright column of soft pure-white light with blurred edges, about three times taller than the small light, standing on the grass; it is never a beam or ray from the sky, never an arc, never a comet. There is no human, child or angel shape anywhere in the reflection. In the reflection: the small golden light now lies low and flat on the grass; the tall white light bends over it, its top curving down above it; the lambs have stepped back.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: bright, neutral daylight on the skin and in the reflection; the only glowing points are the lights inside the reflection.

DO NOT DRAW: any human, child or angel shape in the reflection, wings, silhouettes, faces in the reflection, hands, body, chest, anatomical heart, heart symbol, blood, red colour in the reflection, knife, tears, light beam or ray from the sky, comet, shooting star, dusk or night sky

BEFORE YOU OUTPUT, CHECK AND FIX: exactly one eye, with a natural eyelid, lashes and brow, no second eye, no extra eyelids; the reflection sits inside the iris and shows only the hillside and what the prompt lists; no human, child or angel shape, wings or silhouette anywhere in the reflection: only the small warm golden-white light, the tall pure white light and the objects the prompt lists (bright spark, dark speck, golden basin); the two lights look the same as described in every image: the visitor is an upright column of white light standing on the grass, never a beam, ray, arc or comet; the reflection shows bright daytime with a blue sky, the same hillside as the attached image; no blood, anatomical heart, chest, knife or body parts; no text, letters, crosses, minarets, domes or crescents.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 4: b04-d-goz-3

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Göz yansıması dizisi 3/5: göğsünün yarılıp kalbinin çıkarılması ve pıhtının alınması (Erdem: dizinin en önemli karesi). Yalnız ışık: kalp, ışığın içinden kaldırılan küçük parlak kıvılcım; pıhtı ondan ayrılan küçük koyu nokta. 2026-11-24 yeniden: ilk üretimde yansıma küçük ve okunaksızdı, gök akşamdı, iki ışık her karede başka biçimdeydi, kalp anı seçilmiyordu. Dayanak: b04-s07 parça 1; i-b04-011.*

```text
Scene b04-d-goz-3. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.

SUBJECT: Extreme close-up of one eye of boy C, about 5, darker brown skin, fine brows, curly black hair, no head cloth, a grey-blue tunic (the same boy C as in the attached hillside image and earlier in this chat). The eye fills the image, a little right of centre (the camera will drift from right to left); lashes, part of the eyebrow and the cheek are simple layered paper shapes. The iris is very large: it fills about two thirds of the image height, and the reflection inside it is large, sharp and easy to read, like a small round painting set in the dark, glossy iris, with one small white highlight at its upper left. The reflection shows the same sunlit hillside as the attached hillside image, seen from where the children stand: clear blue daytime sky, the far mountains, the tree at the left, brown grass and a few grazing lambs; NOT dusk, NOT night. Only two lights are in it, drawn the same way in every image: THE CHILD is a small, soft, warm golden-white light about the size of a lamb; THE VISITOR is one tall, upright column of soft pure-white light with blurred edges, about three times taller than the small light, standing on the grass; it is never a beam or ray from the sky, never an arc, never a comet. There is no human, child or angel shape anywhere in the reflection. This is the key moment of the sequence and must be the clearest. In the reflection: the small golden light lies flat on the grass; the tall white light bends low over it. Out of the middle of the small golden light, the tall white light lifts a second, much smaller, very bright golden spark and holds it up just above, inside its own whiteness. From that bright spark one tiny dark grey speck is being drawn out; it drifts away to the side and thins into the air like a wisp of smoke. The bright spark itself stays clean and shining. The three elements (small golden light below, bright spark lifted above it, tiny dark speck drifting away) must be clearly readable at a glance.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: bright, neutral daylight on the skin and in the reflection; the only glowing points are the lights inside the reflection.

DO NOT DRAW: any human, child or angel shape in the reflection, wings, silhouettes, faces in the reflection, hands, body, chest, anatomical heart, heart symbol, blood, red colour in the reflection, knife, tears, light beam or ray from the sky, comet, shooting star, dusk or night sky

BEFORE YOU OUTPUT, CHECK AND FIX: exactly one eye, with a natural eyelid, lashes and brow, no second eye, no extra eyelids; the reflection sits inside the iris and shows only the hillside and what the prompt lists; no human, child or angel shape, wings or silhouette anywhere in the reflection: only the small warm golden-white light, the tall pure white light and the objects the prompt lists (bright spark, dark speck, golden basin); the two lights look the same as described in every image: the visitor is an upright column of white light standing on the grass, never a beam, ray, arc or comet; the reflection shows bright daytime with a blue sky, the same hillside as the attached image; no blood, anatomical heart, chest, knife or body parts; no text, letters, crosses, minarets, domes or crescents.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 5: b04-d-goz-4

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Göz yansıması dizisi 4/5: kalbin altın leğende Zemzem suyuyla yıkanması. 2026-11-24 yeniden: ilk üretimde yansıma küçük ve okunaksızdı, gök akşamdı, iki ışık her karede başka biçimdeydi, kalp anı seçilmiyordu. Dayanak: b04-s07 parça 2; i-b04-011.*

```text
Scene b04-d-goz-4. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.

SUBJECT: Extreme close-up of one eye of boy B, about 6, medium-brown skin, round face, an off-white head cloth wrapped round his head with a dark band, a brown tunic (the same boy B as in the attached hillside image and earlier in this chat). The eye fills the image, a little right of centre (the camera will drift from right to left); lashes, part of the eyebrow and the cheek are simple layered paper shapes. The iris is very large: it fills about two thirds of the image height, and the reflection inside it is large, sharp and easy to read, like a small round painting set in the dark, glossy iris, with one small white highlight at its upper left. The reflection shows the same sunlit hillside as the attached hillside image, seen from where the children stand: clear blue daytime sky, the far mountains, the tree at the left, brown grass and a few grazing lambs; NOT dusk, NOT night. Only two lights are in it, drawn the same way in every image: THE CHILD is a small, soft, warm golden-white light about the size of a lamb; THE VISITOR is one tall, upright column of soft pure-white light with blurred edges, about three times taller than the small light, standing on the grass; it is never a beam or ray from the sky, never an arc, never a comet. There is no human, child or angel shape anywhere in the reflection. In the reflection: a simple, plain golden basin filled with clear water stands on the grass beside the small golden light, which still lies flat; the tall white light bends over the basin and holds the bright golden spark just above the water; the water sparkles and a few clear drops fall from the spark back into the basin.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: bright, neutral daylight on the skin and in the reflection; the only glowing points are the lights inside the reflection.

DO NOT DRAW: any human, child or angel shape in the reflection, wings, silhouettes, faces in the reflection, hands, body, chest, anatomical heart, heart symbol, blood, red colour in the reflection, knife, tears, light beam or ray from the sky, comet, shooting star, dusk or night sky

BEFORE YOU OUTPUT, CHECK AND FIX: exactly one eye, with a natural eyelid, lashes and brow, no second eye, no extra eyelids; the reflection sits inside the iris and shows only the hillside and what the prompt lists; no human, child or angel shape, wings or silhouette anywhere in the reflection: only the small warm golden-white light, the tall pure white light and the objects the prompt lists (bright spark, dark speck, golden basin); the two lights look the same as described in every image: the visitor is an upright column of white light standing on the grass, never a beam, ray, arc or comet; the reflection shows bright daytime with a blue sky, the same hillside as the attached image; no blood, anatomical heart, chest, knife or body parts; no text, letters, crosses, minarets, domes or crescents.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 6: b04-d-goz-5

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `sahne-b04-oyun.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Göz yansıması dizisi 5/5: kalbin yerine konup göğsün kapatılması; ışığın çekilişi. 2026-11-24 yeniden: ilk üretimde yansıma küçük ve okunaksızdı, gök akşamdı, iki ışık her karede başka biçimdeydi, kalp anı seçilmiyordu. Dayanak: b04-s07 parça 2; i-b04-011.*

```text
Scene b04-d-goz-5. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.

SUBJECT: Extreme close-up of one eye of boy A, about 7, light-brown skin, thick black brows, short curly black hair, no head cloth, a sand-coloured tunic (the same boy A as in the attached hillside image and earlier in this chat). The eye fills the image, a little right of centre (the camera will drift from right to left); lashes, part of the eyebrow and the cheek are simple layered paper shapes. The iris is very large: it fills about two thirds of the image height, and the reflection inside it is large, sharp and easy to read, like a small round painting set in the dark, glossy iris, with one small white highlight at its upper left. The reflection shows the same sunlit hillside as the attached hillside image, seen from where the children stand: clear blue daytime sky, the far mountains, the tree at the left, brown grass and a few grazing lambs; NOT dusk, NOT night. Only two lights are in it, drawn the same way in every image: THE CHILD is a small, soft, warm golden-white light about the size of a lamb; THE VISITOR is one tall, upright column of soft pure-white light with blurred edges, about three times taller than the small light, standing on the grass; it is never a beam or ray from the sky, never an arc, never a comet. There is no human, child or angel shape anywhere in the reflection. In the reflection: the bright spark has gone back into the small golden light, which is whole again and now stands upright on the slope; the golden basin is gone; the tall white light rises away into the blue sky and fades; the lambs graze again.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: bright, neutral daylight on the skin and in the reflection; the only glowing points are the lights inside the reflection.

DO NOT DRAW: any human, child or angel shape in the reflection, wings, silhouettes, faces in the reflection, hands, body, chest, anatomical heart, heart symbol, blood, red colour in the reflection, knife, tears, light beam or ray from the sky, comet, shooting star, dusk or night sky

BEFORE YOU OUTPUT, CHECK AND FIX: exactly one eye, with a natural eyelid, lashes and brow, no second eye, no extra eyelids; the reflection sits inside the iris and shows only the hillside and what the prompt lists; no human, child or angel shape, wings or silhouette anywhere in the reflection: only the small warm golden-white light, the tall pure white light and the objects the prompt lists (bright spark, dark speck, golden basin); the two lights look the same as described in every image: the visitor is an upright column of white light standing on the grass, never a beam, ray, arc or comet; the reflection shows bright daytime with a blue sky, the same hillside as the attached image; no blood, anatomical heart, chest, knife or body parts; no text, letters, crosses, minarets, domes or crescents.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```
