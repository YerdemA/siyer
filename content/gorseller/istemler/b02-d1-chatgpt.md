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

## Mesaj 1: b02-d-ebrehe-yakin

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-ebrehe.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s01'in ikinci çekimi 13 sn uzak taht görseli; Ebrehe'nin yüzü (yarık) anlatılıyor. s10'da da kullanılır. Dayanak: b02-s01 parça 1, 2; i-b02-001, i-b02-002.*

```text
Scene b02-d-ebrehe-yakin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Close shot of Abraha: head and shoulders, three-quarter view, a stern look; the scar across his face as on his character sheet. Behind him only a blurred stone wall of his court.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: head and shoulders, three-quarter view facing right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, crown, cross, jewels, blood

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b02-d-mektup

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s02 tek görsel (10 sn); Necâşî'ye mektup cümlesi görüntüsüz. Dayanak: b02-s02 parça 1; i-b02-003.*

```text
Scene b02-d-mektup. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, in a stone courtyard in San'a: a scribe seated on a mat writes on a leather scroll (the marks are tiny and unreadable, no letters visible); behind him a messenger in travelling clothes waits beside a saddled camel.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. a scribe in a plain white robe and small white head wrap. Pose and place: seated at the left, writing.
2. an Abyssinian messenger: a dark-skinned man in plain off-white wrapped garments with a dark sash. Pose and place: standing at the right beside the camel.
3. saddled camel. Pose and place: at the right.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, readable writing, letters, crosses

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b02-d-ebrehe-ofke

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-taht.png`, `karakter-ebrehe.png`, `karakter-habes_askeri.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s03 tek görsel (13 sn); Ebrehe'nin öfkesi ve yemini görüntüsüz. Dayanak: b02-s03 parça 1; i-b02-004.*

```text
Scene b02-d-ebrehe-ofke. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the stone court of Abraha in San'a: Abraha rises angrily from his throne (exactly like the attached throne reference) and points forward with one arm; Abyssinian officers bow their heads before him.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: in the centre, half-risen from the throne, one arm pointing forward.
2. 3 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: at both sides, heads bowed.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, crosses, crown

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b02-d-arap-kabileler

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s04 tek uzak plan (12 sn); Arapların endişesi görüntüsüz. Dayanak: b02-s04 parça 1; i-b02-005.*

```text
Scene b02-d-arap-kabileler. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Late afternoon, a Bedouin camp on a rise: a group of Arab tribesmen stand among their tents looking towards a distant line of dust on the horizon where an army moves; worried, serious faces.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 7 × Bedouin men in plain undyed wool tunics and loosely wrapped dark head cloths. Pose and place: standing in a line, looking towards the right horizon.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, the army in detail, the elephant, blood

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b02-d-nufeyl-yol

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-nufeyl.png`, `karakter-habes_askeri.png`, `karakter-fil.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s05 tek görsel 20 sn; Nüfeyl'in yol göstermesi ayrı çekim olmalı. Dayanak: b02-s05 parça 1; i-b02-006.*

```text
Scene b02-d-nufeyl-yol. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, a desert track between low hills: Nufayl walks at the head of a long army column, pointing the way ahead with one arm; Abyssinian soldiers follow him; far behind, the elephant.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (2 individually listed people). Keep every listed colour and feature exactly as written:
1. Nufayl ibn Habib of Khath'am, the army's guide: an Arab man of about 45 with a short dark beard; an off-white head cloth wrapped loosely without a cord; a cream tunic and a red cloak with a narrow white edge. Pose and place: in front at the left, walking, pointing forward.
2. about 12 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: a column following him into the distance.
3. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: small, far back in the column.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, chains on Nufayl

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b02-d-ebu-rigal-kabir

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s06'nın ikinci çekimi aynı heyet görseli (18 sn); Ebû Rigāl'in kabri anlatılıyor. Dayanak: b02-s06 parça 2; i-b02-007.*

```text
Scene b02-d-ebu-rigal-kabir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, a stony valley near Mecca (al-Mughammas): a low heap of stones marks a grave; a few passing Arab travellers throw pebbles at it from a little distance; pebbles lie scattered around the heap.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. 4 × Bedouin men in plain undyed wool tunics and loosely wrapped dark head cloths. Pose and place: at the right, two of them throwing a small pebble.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, bodies, bones, blood, writing on stones

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b02-d-esved-atlilar

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s07 tek görsel 22 sn. Dayanak: b02-s07 parça 0; i-b02-008.*

```text
Scene b02-d-esved-atlilar. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, dusty plain: a band of Abyssinian horsemen rides out from a camp of tents at a fast pace, led by a commander (al-Aswad) in a dark red sash; dust rises behind them.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (1 individually listed people). Keep every listed colour and feature exactly as written:
1. al-Aswad ibn Maqsud, an Abyssinian commander of about 40 with a short black beard, white wrapped garments and a dark red sash, on a horse. Pose and place: in front, riding to the right.
2. about 8 × Abyssinian soldiers: dark-skinned men in plain off-white wrapped garments with a dark sash, short spears held upright, no armour detail, on horses. Pose and place: riding behind him.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, weapons in use

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b02-d-kureys-istisare

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahnenin son parçası: Kureyş, Kinâne ve Hüzeyl savaşmaktan vazgeçiyor. Dayanak: b02-s07 parça 2; i-b02-008.*

```text
Scene b02-d-kureys-istisare. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, outside Mecca: men of Quraysh, Kinana and Hudhayl stand in a tense circle with spears; one elder speaks; several men slowly lower their spears to the ground, faces heavy.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (1 individually listed people). Keep every listed colour and feature exactly as written:
1. about 10 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool, holding plain spears. Pose and place: in a loose circle; some lowering their spears.
2. an elderly man with a grey beard and a grey-blue cloak. Pose and place: in the centre, speaking with an open hand.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, fighting, blood

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b02-d-hunata-gelis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s08'in iki çekimi aynı görsel (27 sn). Dayanak: b02-s08 parça 0; i-b02-009.*

```text
Scene b02-d-hunata-gelis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, the mouth of the Mecca valley: Hunata of Himyar rides in on a camel with two attendants on foot; a few men of Quraysh stand by the first houses watching him arrive.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. Hunata, a Himyarite envoy from Yemen: a man of about 45 with a short black beard; a dark-red head wrap tied as a turban; a cream tunic and a long dark-red cloak. Pose and place: on a camel, riding in from the right.
2. 2 × Yemeni attendants in plain white wrapped garments. Pose and place: walking beside the camel.
3. 4 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: at the left by the houses, watching.
4. camel. Pose and place: carrying Hunata.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, weapons drawn, blood

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b02-d-ordugaha-varis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-abdulmuttalib.png`, `karakter-habes_askeri.png`, `karakter-fil.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s09 tek görsel 27 sn. Dayanak: b02-s09 parça 0; i-b02-010.*

```text
Scene b02-d-ordugaha-varis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, the edge of the Abyssinian camp at al-Mughammas: Abdul-Muttalib arrives on foot with some of his sons; Abyssinian guards with spears stand by the tents; in the background the large elephant stands beside its keeper.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 9 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: at the left, walking in front.
2. 3 × the sons of Abdul-Muttalib: grown men aged roughly 20 to 50, all clearly younger than their father; mixed beard lengths, all beards black or dark brown except the eldest with a little grey; off-white or sand head cloths and plain cloaks in muted brown, grey-blue and ochre. Pose and place: behind him.
3. 3 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: at the right by the tents.
4. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: far in the background.
5. an Abyssinian elephant keeper (Unays) in white wrapped garments. Pose and place: beside the elephant, small.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, weapons in use

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 9 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b02-d-uneys

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı parça: Zû Nefer'in fil bakıcısından aracılık istemesi. Dayanak: b02-s09 parça 0; i-b02-010.*

```text
Scene b02-d-uneys. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, beside the elephant in the camp: Dhu Nafar, his hands bound in front, speaks quietly to the elephant keeper Unays, who listens attentively; the elephant stands behind them.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 3 people in total). Keep every listed colour and feature exactly as written:
1. Dhu Nafar, a Yemeni nobleman held captive: a man of about 50 with a short greying beard; a white head cloth with a dark cord; a beige tunic and a brown cloak; hands bound in front of him with a simple rope. Pose and place: at the left, hands bound in front, speaking.
2. Unays, an Abyssinian elephant keeper of about 35 with a short black beard, white wrapped garments and a brown sash, holding a short goad. Pose and place: at the right, listening.
3. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: standing behind them.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, chains on the elephant

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 3 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b02-d-ebrehe-saygi

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-taht.png`, `karakter-ebrehe.png`, `karakter-abdulmuttalib.png`, `karakter-habes_askeri.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahne: Ebrehe'nin Abdülmuttalib'i görüp saygı göstermesi. Dayanak: b02-s09 parça 1; i-b02-010.*

```text
Scene b02-d-ebrehe-saygi. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, inside the camp: Abraha on his throne (exactly like the attached throne reference) looks up with respect as Abdul-Muttalib is brought before him; Abraha begins to rise, one hand slightly raised in greeting.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 4 people in total). Keep every listed colour and feature exactly as written:
1. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: at the right, rising from the throne.
2. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: at the left, standing tall and calm.
3. 2 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: behind the throne.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, crosses, crown

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 4 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 13: b02-d-develer-donus

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-habes_askeri.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s10 tek yakın görsel 27 sn; develerin geri verilmesi görüntüsüz. Dayanak: b02-s10 parça 3; i-b02-011.*

```text
Scene b02-d-develer-donus. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, outside the camp: Abyssinian handlers drive a large herd of camels back towards the hills of Mecca; men of Quraysh receive them at the right; dust in the air.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. about 40 × camels. Pose and place: a herd moving from left to right.
2. 3 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: at the left, driving the herd.
3. 4 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: at the right, receiving the herd.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, weapons in use

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 14: b02-d-daglara-cekilis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`, `nesne-mekke-evler.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s11'in ilk çekimi yalnız ortak Kâbe (10 sn). Dayanak: b02-s11 parça 0; i-b02-012.*

```text
Scene b02-d-daglara-cekilis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Late afternoon, the rocky slopes above Mecca: families of Quraysh climb steep mountain paths with bundles, goats and a few camels, leaving the city; some look back down at the empty houses and the low Ka'ba far below. The low, roofless Ka'ba looks exactly like the attached reference: rough, unmortared grey-brown stone walls a little taller than a man, no roof, no cloth covering, no door decoration.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count. Keep every listed colour and feature exactly as written:
1. about 14 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool; women wrapped in dark cloaks seen only from behind; children seen from behind. Pose and place: climbing in a long line up the slope.
2. about 6 × goats and camels. Pose and place: among the people.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, women's faces, weapons

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 15: b02-d-tepede-bekleyis

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `nesne-kabe-alcak.png`, `nesne-mekke-evler.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). Aynı sahne: dağlarda bekleyiş. Dayanak: b02-s11 parça 2; i-b02-012.*

```text
Scene b02-d-tepede-bekleyis. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dusk, on a rocky ridge above Mecca: men of Quraysh sit and stand among the rocks, looking down into the empty valley where the low Ka'ba stands alone; silence. The low, roofless Ka'ba looks exactly like the attached reference: rough, unmortared grey-brown stone walls a little taller than a man, no roof, no cloth covering, no door decoration.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: standing at the left on a rock, looking down.
2. 6 × men of Quraysh in simple 6th-century clothes: off-white or sand head cloths, plain tunics and long cloaks in muted brown, grey-blue, ochre and undyed wool. Pose and place: sitting and standing behind him.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, weapons, fire

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 16: b02-d-ordu-hazir

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`, `karakter-habes_askeri.png`, `karakter-ebrehe.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s12 tek görsel 27 sn. Dayanak: b02-s12 parça 0; i-b02-013.*

```text
Scene b02-d-ordu-hazir. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Dawn, the Abyssinian army is drawn up in lines facing towards the hills of Mecca; the large elephant stands at the head of the army; officers give orders.

PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count (2 individually listed people). Keep every listed colour and feature exactly as written:
1. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: at the head of the army, centre-right.
2. about 20 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: in lines behind the elephant.
3. Abraha, the Abyssinian ruler of Yemen: a short, stout, heavy-set man of about 60 with dark brown skin; a long diagonal scar running from his brow down across the eye toward the nose; short, tightly curled black hair and a short, curly black beard; a cream-white ankle-length tunic with a wide dark-brown sash; over it a large deep-red cloak with a broad golden-yellow border, draped over both shoulders; brown leather sandals; no crown, no jewels, no cross, no animal skin. Pose and place: small, at the left among the officers.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, blood, armour detail, crosses

BEFORE YOU OUTPUT, CHECK AND FIX: the individually listed people are all there, nobody extra; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 17: b02-d-fil-yuruyor

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-fil.png`, `karakter-habes_askeri.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahnenin son parçası: fil başka yöne çevrilince yürüyor. Dayanak: b02-s12 parça 3; i-b02-013.*

```text
Scene b02-d-fil-yuruyor. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dawn, the same army: the elephant, turned away to the left (away from Mecca), walks easily; soldiers around it gesture in astonishment; at the right edge, the hills of Mecca.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 6 people in total). Keep every listed colour and feature exactly as written:
1. Mahmud, the single war elephant: one large grey African elephant with long ivory tusks; a red saddle cloth with a broad golden-yellow border and a row of yellow tassels on its back; no tower, no rider seat, no armour, no second elephant. Pose and place: walking to the left.
2. 5 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: around the elephant, astonished.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: dawn: soft apricot light low on the horizon, the rest of the scene in cool, muted blue-grey; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, beating the elephant, blood

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 6 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 18: b02-d-denizden-kuslar

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s13 tek görsel 22 sn. Dayanak: b02-s13 parça 0; i-b02-014.*

```text
Scene b02-d-denizden-kuslar. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.

SUBJECT: Daytime, a wide view towards the sea: from over the distant coastline, dark flocks of small birds come in waves over the land towards the viewer.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. flocks of small swallow-like birds with forked tails: dark brown backs and wings, pale cream bellies, simple paper shapes; each carries a tiny reddish pebble in its beak or claws; no fire, no glow. Pose and place: flocks in the sky, coming from the sea on the left.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, fire, glow

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 19: b02-d-kus-yakin

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). Aynı sahne: kuşların üç taşı (kaynakta ayrıntılı). Dayanak: b02-s13 parça 1; i-b02-020.*

```text
Scene b02-d-kus-yakin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Close shot in the sky: five swallow-like birds in flight; each carries one tiny reddish pebble in its beak and one in each of its two claws.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. flocks of small swallow-like birds with forked tails: dark brown backs and wings, pale cream bellies, simple paper shapes; each carries a tiny reddish pebble in its beak or claws; no fire, no glow. Pose and place: five birds close to the viewer, wings spread.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, fire, glow, large stones

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 20: b02-d-yenik-ekin

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s14 tek görsel 22 sn; ayetin son benzetmesi ('yenilip çiğnenmiş ekin'). Dayanak: b02-s14 parça 1; i-b02-015.*

```text
Scene b02-d-yenik-ekin. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Close view of the ground: dry, trampled and eaten straw and broken crop stalks scattered over the sand; nothing standing.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, people, bodies, blood, animals

BEFORE YOU OUTPUT, CHECK AND FIX: no people at all; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 21: b02-d-sana-donus

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-habes_askeri.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (B). s15 tek görsel 13 sn; Ebrehe'nin San'a'ya taşınması. Dayanak: b02-s15 parça 1; i-b02-016.*

```text
Scene b02-d-sana-donus. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Dusk, the gate of San'a, plain stone and mudbrick: a covered litter is carried in by four weary soldiers; a few people watch from the gate.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 7 people in total). Keep every listed colour and feature exactly as written:
1. 4 × Abyssinian soldiers: dark-brown-skinned men, short black hair under a plain white cloth cap, short black beards; cream knee-length tunics, a simple brown leather vest, a red shoulder cloak; each holds at most one plain wooden spear; no helmets, no shields, no banners, no crosses. Pose and place: carrying a fully covered litter on their shoulders.
2. 3 × townspeople in plain white garments. Pose and place: by the gate.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: late afternoon going to dusk: warm, low light from the left, long shadows, sky turning soft apricot; no glow, no sun rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, wounds, blood, any face or body on the litter, crosses

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 7 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 22: b02-d-kasva

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s16 tek ortak Kâbe görseli 39 sn; Hudeybiye'deki Kasvâ olayı görüntüsüz. Efendimiz bu görselde yok (peygamberlik sonrası nur kararı verilmedi). Dayanak: b02-s16 parça 2; i-b02-019.*

```text
Scene b02-d-kasva. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime, a desert track near al-Hudaybiya: a she-camel (al-Qaswa) has knelt down on the path and will not rise; travellers around her stop and look at each other, one points at her.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 6 people in total). Keep every listed colour and feature exactly as written:
1. al-Qaswa, a light tawny she-camel with a simple saddle. Pose and place: kneeling in the centre.
2. 6 × Arab travellers in plain white and undyed garments. Pose and place: around the camel, at the left and behind.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: clear, neutral daylight from the front-left; soft paper shadows under people, animals and objects so they sit on the ground; no glow, no dramatic light.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, weapons, writing

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 6 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
