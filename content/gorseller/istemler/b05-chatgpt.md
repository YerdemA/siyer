# b05-yetimlik: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Arabia around 576-579 CE — Mecca (a narrow valley among bare, rocky mountains with small flat-roofed houses of mudbrick and rough stone) and the desert road north toward Yathrib. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, faces, hands, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b05-yol-zemin

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Mekke-Yesrib yolu; ortak zemin.*

```text
Scene b05-yol-zemin. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Wide desert ground layer: flat sandy and stony plain with a faint caravan track, a few low dry bushes, low bare hills at the edges. No people, no buildings. Fills the lower half of the frame; everything above is flat chroma green (#00B140).

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b05-kervan

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Âmine ve Ümmü Eymen; ikisi de arkadan. Çocuk görünmez.*

```text
Scene b05-kervan. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A small caravan of a few camels seen from a distance and from behind; among the travellers are two figures, each a woman fully wrapped in a cloak and head covering, seen from behind so that no face is visible. No child visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b05-yesrib-uzak

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Yesrib; kaynakta görünüş betimi yok, uzak ve ayrıntısız.*

```text
Scene b05-yesrib-uzak. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A distant settlement of low, flat-roofed mudbrick houses spread across a flat plain, seen from far away, undetailed. No people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b05-ebva-konak

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ebvâ; Âmine'nin vefatı gösterilmez. Kadın Ümmü Eymen. Akşam, çadır, develer sahnelemedir, kaynakta yok.*

```text
Scene b05-ebva-konak. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A desert halt at dusk seen from far away: a few camels kneeling, one small low tent; in front of the tent sits a woman fully wrapped in a cloak and head covering, seen from behind so that no face is visible, alone. No body, no burial, no grave. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b05-ebva-kabir

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Resûlullah'ın gözünden kabir ziyareti (Müslim 976b; EBVÂ). Kabir sade.*

```text
Scene b05-ebva-kabir. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. This scene is set in 628 CE. Seen at eye level from a standing person's point of view: a low, simple mound of earth on the plain. No hands, arms or body in the frame, no light, no glow, no inscription, no building. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b05-kapida-teslim

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ümmü Eymen Efendimiz'i Abdülmuttalib'e teslim eder; çocuk görünmez.*

```text
Scene b05-kapida-teslim. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At the doorway of a modest mudbrick house in Mecca: the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth, standing in the doorway, face drawn simply and calm; walking toward him, a woman fully wrapped in a cloak and head covering, seen from behind so that no face is visible. No child visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b05-kabe-dosek

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 107: Kâbe'nin gölgesinde Abdülmuttalib'in döşeği; oğulları üstüne oturmaz.*

```text
Scene b05-kabe-dosek. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. In the shade of a low stone wall: a plain flat mat spread on the ground; the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth sits on it; around the mat, on the bare ground and not on the mat, sit several Quraysh men (his sons), faces drawn simply. No child. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b05-dosek-yakin

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 107-108: 'Bırakın oğlumu'. Çocuk çizilmez.*

```text
Scene b05-dosek-yakin. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Closer view: the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth, seated on a plain flat mat, raising one hand to stop two men in front of him; the two men pause and look at him. No child, no light, no glow. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b05-son-gece

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 108: Abdülmuttalib kızlarını çağırır. Kadınlar arkadan.*

```text
Scene b05-son-gece. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Interior of a simple mudbrick room at night lit only by a small, dim orange oil lamp: an Arab man lying on a bed, his face in shadow; around him sit six women, fully veiled and seen from behind. Calm, quiet, no wailing. Full frame.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b05-ebu-talib-kapi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ebû Tâlib; kaynakta görünüş betimi yok, sade. Çocuk görünmez.*

```text
Scene b05-ebu-talib-kapi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. In front of a modest mudbrick house in Mecca at dusk: an Arab man of Quraysh in simple clothes standing by the door, face drawn simply and calm. No child visible. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
