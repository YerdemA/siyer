# b08-el-emin: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 595-605 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone and the low, roofless Ka'ba) and, once, the edge of a town in southern Syria (Busra) with a stone monastery. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep important elements inside that central area. Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b08-rahip

**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): `karakter-meysere.png`

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm (s. 120), BUSRÂ (s. 470): rahip Meysere'ye ağacın altındakini sordu. Görünüşler kaynakta yok. 2. tur (2026-11-19): rahip Bahîrâ'ya benzediği için kart değişti (kukuletasız, açık gri cüppe).*

```text
Scene b08-rahip. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered textured paper shapes, muted earth palette; not photorealistic, not a 3D render. The images attached to this message are references: character sheets show exactly how each named character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. Match them exactly, but do not copy their composition or background.

CAMERA: Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.

SUBJECT: The old monk stands in his doorway and speaks to Maysara, pointing towards the left with one hand, as if asking who is resting under the tree there; Maysara turns his head to look where he points.

PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly 2 people in total). Keep every listed colour and feature exactly as written:
1. an old Christian monk of Syria with a long white beard and short white hair; NO hood: bare head with a small round black cap; a long, plain robe of undyed light-grey wool with a thin black sash; a plain wooden walking staff; no cross, no jewellery. He must look clearly different from Bahira (who wears a dark-brown hood and dark-brown robe). Pose and place: standing at the right, facing left, one arm stretched out, pointing left, an earnest look.
2. Maysara, a young servant man of about 25 with a short, sparse black beard; a plain undyed off-white head cloth tied simply; a knee-length undyed wool tunic and a short sand-brown cloak; a plain rope belt; simple sandals. Pose and place: standing at the left, body facing the monk, head turned back over his shoulder to the left.

LAYOUT: Both stand side by side on one horizontal foot line in the lower part of the image. Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), with no green tint on them.

LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint).

DO NOT DRAW: the Prophet, any glowing figure, halo, crosses, any other person, tree, building, ground.

BEFORE YOU OUTPUT, CHECK AND FIX: exactly 2 people; every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs; every held object is held by a hand that belongs to a body; faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek; every clothing colour, beard colour and feature matches the description; no text, letters, crosses, minarets, domes, crescents or glow; the background is one flat, uniform green with no ground, horizon or shadow.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
