# b02-fil-vakasi: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 570 CE — Yemen (San'a) and the Hijaz desert road to Mecca; Mecca is a narrow valley among bare, rocky, almost treeless mountains with small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b02-ebrehe-taht

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-taht.png`, `karakter-ebrehe.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 28: kısa boylu, etli; s. 29: yarık izi (el-Eşrem); taht (sarîr) s. 34. Avlu ve şehir biçimi kaynakta yok: sade taş avlu ve evler. Taht s09'daki (b02-ordugah) tahtla aynı (Erdem, 2026-11-17).*

```text
Scene b02-ebrehe-taht. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: In San'a, Abraha sits calmly on his throne in a plain open stone courtyard; the same throne as in the attached throne reference: a sturdy wooden throne with a tall arched back upholstered in deep red cloth, thick square wooden armrests, a red seat cloth with a broad golden-yellow border hanging over the front. The throne stands on the paved ground of the courtyard, its legs and Abraha's feet clearly resting on the paving; behind him a plain stone wall, and beyond it simple flat-roofed stone and mudbrick houses and bare mountains under a clear day sky.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: seated on the throne slightly right of centre, facing the viewer, hands on the armrests; full figure, feet on the ground.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: even daylight from the upper left, soft shadows under the throne and Abraha's feet so they sit on the paving; no glow.

DO NOT DRAW: animal skins, leopard pattern, crown, jewels, cross, guards, other people, church, domes, columns with carvings, inscriptions.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b02-sakif-heyet

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-taht.png`, `karakter-ebrehe.png`, `karakter-habes_askeri.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Mes'ûd b. Muattib ve Ebû Rigāl (İbn Hişâm s. 32). Ebrehe b02-ebrehe-taht ile aynı kişi.*

```text
Scene b02-sakif-heyet. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: A small delegation of Arab men of Ta'if stands before Abraha with heads slightly bowed in submission; one of them stands a little apart, ready to lead the way.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 6 people in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: seated at the left on the same throne as in the attached throne reference: a sturdy wooden throne with a tall arched back upholstered in deep red cloth, thick square wooden armrests, a red seat cloth with a broad golden-yellow border hanging over the front, turned to the right towards the men; full figure, feet on the ground.
2. Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: standing behind the throne at Abraha's left shoulder.
3. 3 × men of Ta'if: Arab men aged 30 to 60 in off-white head cloths with dark cords, plain tunics and cloaks in muted brown, grey-blue and ochre. Pose and place: standing side by side in the middle, heads bowed.
4. Abu Righal, a lean Arab man of about 40 with a short dark beard, sand-coloured head cloth, brown cloak. Pose and place: standing at the right, a little apart, one arm pointing the way.

LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, with clear flat green space on all four sides (at least one tenth of the image width and height). Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, and never place anyone higher in the image than the others. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them. The only exception: the throne under Abraha, which is drawn.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: idols, temples, buildings, ground, stone seat, stool.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 6 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b02-kapi-dua

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 34-35: kapı halkası, birkaç Kureyşli, halk dağlara çekiliyor. Kâbe görünüşü kabe-alcak katmanıyla aynı (İbn Hişâm s. 122: çatısız, alçak). Kapı kanadı biçimi kaynakta yok: sade.*

```text
Scene b02-kapi-dua. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Evening at the Ka'ba: close view of the doorway corner of the low, roofless ancient stone sanctuary from the attached reference: dry-laid, roughly cut grey-brown stone blocks in uneven rows, earthy brown at the base, walls only a little taller than a standing man, no roof, no covering cloth; its doorway is at ground level. A plain wooden door leaf in the doorway carries a plain iron ring. Abdul-Muttalib stands at the door holding the iron ring with one hand and raising the other hand in prayer; a few men of Quraysh stand quietly behind him. Behind the sanctuary, the bare mountains of Mecca, where tiny distant groups of people are climbing the slopes.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (4 individually listed people). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing at the door on the right, seen from the side, one hand on the iron ring, the other raised in prayer; full figure.
2. 3 × men of Quraysh: Arab men of mixed ages in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; no bright colours, no jewellery. Pose and place: standing behind him at the left, hands folded, faces calm.
3. about 15 × tiny distant people on the far mountainsides, simple undetailed shapes. Pose and place: climbing in small groups far away.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: warm low evening light from the left, long soft shadows; no glow.

DO NOT DRAW: roof, black cloth covering, gold, inscriptions, idols, tall walls, steps up to the door, arches.

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
