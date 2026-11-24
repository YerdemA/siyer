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

## Mesaj 1: b03-d-kura-oklari

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s03'ün iki çekimi aynı görsel (24 sn). Kura s05'te de kullanılır. 2026-11-24 yeniden: ilk üretimde alttaki el bedene bağlı değildi. Dayanak: b03-s03 parça 0; i-b03-004. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b03-d-kura-oklari. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.

SUBJECT: Close shot inside the roofless Ka'ba (as in the attached interior reference): the hands of an elderly custodian draw plain, featherless divining arrows from a leather quiver; behind, out of focus, the large crude idol (Hubal) against the shadowed stone wall. HANDS: exactly two hands, both belonging to the same man whose two forearms in dark sleeves enter the image from the bottom-left corner: his left hand holds the quiver from below, his right hand pulls one arrow up out of it. Each hand is joined to its own sleeve; the wrists and sleeves are clearly visible; no hand comes from the right or from below without an arm.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. the custodian of the idol, an older man; only his two forearms in dark-brown sleeves and his two weathered hands are visible. Pose and place: arms entering from the bottom-left, hands in the centre holding the quiver and one arrow.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: daylight falling in from the open sky above; the hands in light, the wall behind in soft shadow; no glow.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, human faces, blood, knives, writing on arrows, a third hand, a hand without an arm, hands from the right edge

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b03-d-kabe-ic-dua

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `kabe-ic-alcak.png`, `karakter-abdulmuttalib.png`

*Kontrol: tam dolu görsel, perde yok; Dinamizm turu d1 (A). s12'nin ilk çekimi yalnız ortak Kâbe; 'onu alıp Kâbe'ye girdi, Allah'a dua edip şükretti'. Mevcut b03-abdulmuttalib-kabe (kapıdan girerken) kısa açılış, sonra bu. 2026-11-24 yeniden: ilk üretimde Abdülmuttalib doğrudan Hübel'e dönük duruyordu; puta dua ediyor gibi okunuyordu. Dayanak: b03-s12 parça 0; i-b03-015. Önce b01-d-kabe-ic üretilip onaylanmalı; onaylanan görsel referans/kabe-ic-alcak.png olarak konur.*

```text
Scene b03-d-kabe-ic-dua. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: Daytime. Inside the old, roofless Ka'ba (match the attached interior reference if one is attached): a small, nearly rectangular enclosure a few paces across, walled by the same rough, unmortared grey-brown stones as the outside; no roof, the sky open above, daylight falling in from above onto the upper walls while the lower walls stay in soft shadow; packed earth floor; a plain wooden door at ground level in one wall. CAMERA POSITION: the camera stands in front of the far wall where the idols are, so the idols are behind the camera and NOT in the picture; we look across the enclosure towards the opposite wall with the plain wooden door. Abdul-Muttalib stands in the middle of the enclosure with his back to the camera and to the idols, facing away from them; seen strictly from behind; his head is clearly tilted back, looking up at the open sky above the walls, as if praying to God and giving thanks; his arms are in front of him and not visible. Only bare stone walls, the wooden door and the open sky are seen; the stone-lined pit may show at the edge of the floor.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 1 person in total). Keep every listed colour and feature exactly as written:
1. Abdul-Muttalib, chief of Quraysh: an elderly man of about 75, tall, upright and imposing, with a handsome, dignified face and a few deep lines; a full, neatly kept, fist-length beard and moustache, grey-white (light grey with white streaks), no black hairs; an off-white head cloth falling to his shoulders, held by a dark brown cord band; a cream-white ankle-length tunic; over it a long open rust-brown cloak with a broad saffron-yellow border; brown leather sandals. Pose and place: in the centre, strictly from behind, back turned to the idols, head tilted up to the sky.

LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: the top 15%, the bottom 15% and 8% on each side will be cropped.

LIGHT: soft daylight falling straight down from the open sky onto Abdul-Muttalib's head and shoulders; the lower walls in soft shadow; no glow, no rays.

DO NOT DRAW: the Prophet, any glowing figure, halo, light rays from a person, any idol or statue, any baby, bundle or child, any glow, any other person, roof, lamps, gold

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 1 person; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
