# b04-sut-anne: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 571-576 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone) and the dry steppe lands of the Bedouin tribe of Banu Sa'd. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, faces, hands, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b04-bedevi-kafile

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 103-104: Sa'doğulları kadınları süt çocuğu aramaya gelir.*

```text
Scene b04-bedevi-kafile. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A small caravan of Bedouin women on donkeys arriving from far away, seen at a great distance; figures tiny and undetailed. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b04-sad-yurdu

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 105: Sa'doğulları'nın yurdu en kurak topraklardandı. Ortak zemin.*

```text
Scene b04-sad-yurdu. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Wide dry steppe ground layer: barren, stony, sparse yellowed grass and a few low thorn bushes, gentle low hills. No people, no buildings. Fills the lower half of the frame; everything above is flat chroma green (#00B140).

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b04-halime-yolda

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 104: boz merkep, yaşlı dişi deve. Halîme yüzsüz.*

```text
Scene b04-halime-yolda. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from behind at a distance: a woman fully wrapped in a cloak and head covering, seen from behind or in shadow so that no face is visible, riding a thin grey she-donkey; beside her an Arab man in simple clothes; next to them a thin, old she-camel; further ahead, a small group of other women on donkeys. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b04-halime-mekke

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 104. Diğer kadınların taşıdığı bebekler sıradan bebeklerdir; Efendimiz çizilmez.*

```text
Scene b04-halime-mekke. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Between mudbrick houses: several Bedouin women walking away, seen from behind, each carrying a swaddled baby; in the middle, left behind, a woman fully wrapped in a cloak and head covering, seen from behind or in shadow so that no face is visible, standing and talking with an Arab man (her husband), whose face is drawn simply. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b04-deve-sagma

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 104: deve Mekke'de, konakladıkları yerde sağıldı. Çadır ve duygu ayrıntısı yok; Halîme yüzsüz; çocuk görünmez.*

```text
Scene b04-deve-sagma. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At night, at a resting place near Mecca: an old she-camel kneeling, an Arab man kneeling beside it, milking it; his face drawn simply; behind them in the shadow, a woman fully wrapped in a cloak and head covering, seen from behind or in shadow so that no face is visible. No tent, no baby visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b04-sad-cadirlar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Çadır biçimi kaynakta yok; sade.*

```text
Scene b04-sad-cadirlar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A few low, simple Bedouin tents of dark woven cloth on a dry plain, seen from a distance; no people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b04-koyunlar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 105: Halîme'nin koyunları tok döner.*

```text
Scene b04-koyunlar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A flock of sheep and goats coming down a gentle slope at dusk, seen from far away, with one small, undetailed shepherd figure behind them. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b04-iki-anne-kapi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 105: Halîme Âmine'den izin ister. İki kadın da yüzsüz.*

```text
Scene b04-iki-anne-kapi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At the doorway of a modest mudbrick house in Mecca: two women talking, both fully veiled in cloaks and head coverings, one seen from behind and the other in the shadow of the doorway, no faces visible. No child visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b04-kuzular-yamac

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Şakk-ı sadr sahnesi: olay gösterilmez; çocuk çizilmez (çocuk Efendimiz sanılmasın).*

```text
Scene b04-kuzular-yamac. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A wide, quiet hillside of dry steppe with a few lambs grazing. No people, no children, no figures at all. Calm, empty. No light rays, no glow, no angels. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b04-kosan-cocuklar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Müslim 162c: çocuklar süt annesine koşar. Efendimiz çizilmez.*

```text
Scene b04-kosan-cocuklar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Several small Bedouin boys running toward tents, seen from behind; in front of a tent stands a woman fully wrapped in a cloak and head covering, seen from behind or in shadow so that no face is visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b04-ev-ici-aksam

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 105-106: Halîme Âmine'ye olanı anlatır. İki kadın yüzsüz.*

```text
Scene b04-ev-ici-aksam. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Interior of a simple mudbrick room: two women sitting facing each other on the floor, both fully veiled, in deep shadow, no faces visible. No child. Full frame.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b04-abdulmuttalib-dua

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 106-107: Abdülmuttalib Kâbe'nin yanında dua eder. Arkadan.*

```text
Scene b04-abdulmuttalib-dua. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A handsome, imposing Arab man of Quraysh in a simple head cloth, standing with his back to the viewer, hands raised in prayer. Full figure. No child, no light, no glow. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
