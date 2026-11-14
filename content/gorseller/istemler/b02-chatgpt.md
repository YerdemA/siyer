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

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, faces, hands, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b02-sana-sehir

*Kontrol: yeşil perde, zemin düz yeşil olmalı; San'a; kaynakta şehir tarifi yok, yalnız dönem mimarisi. Ufkun üstü perde.*

```text
Scene b02-sana-sehir. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Wide view of an ancient highland town in Yemen around 570 CE: plain houses of stone and mudbrick set against bare mountains, drawn simply without distinctive architecture. No people in focus, no minarets, no domes. Fills the lower two thirds of the frame; everything above the rooftops and mountains is flat chroma green (#00B140) so the sky layer shows through.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b02-ebrehe-taht

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 28: kısa boylu, etli; s. 29: kaş, göz, burun ve dudağı yarıldığı için el-Eşrem; s. 31: halîm (yumuşak huylu). Taht (sarîr) s. 34. Giysi ve taht malzemesi kaynakta yok.*

```text
Scene b02-ebrehe-taht. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A short, stout, heavy-set Abyssinian ruler with a visible scar across his face (split brow, nose and lip area), seated on a throne; calm, composed face drawn simply in the flat paper cut-out style. Full figure. No cross, no crown jewels. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b02-kilise

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 29: benzeri görülmemiş kilise (el-Kulleys). Mimarî ayrıntı kaynakta yok.*

```text
Scene b02-kilise. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A large stone church building of the 6th century in Yemen, seen from the front at mid distance, drawn plainly as a large simple stone building; no cross, no dome, no minaret, no inscriptions, no decorative details. Tiny people at its base for scale. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b02-kinane-yolcu

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Kinâneli adam; eylemi gösterilmez, yalnız uzaklaşması.*

```text
Scene b02-kinane-yolcu. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A lone Arab traveller in simple clothes and head cloth walking away from the viewer at dusk, seen from behind. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b02-col

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ortak zemin; altı sahnede kullanılır, ışık nötr.*

```text
Scene b02-col. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Wide flat desert ground layer: sand and gravel plain with a few low rocky outcrops, a faint caravan track crossing it. No people, no buildings. Fills the lower half of the frame; everything above is flat chroma green (#00B140).

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b02-ordu-yuruyus

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 31: Habeşliler ve fil. Tek fil (FİL VAK'ASI: kaynakların çoğu tek fil der).*

```text
Scene b02-ordu-yuruyus. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A long marching army column seen from far away and slightly above: many small, simple, undetailed soldier figures on foot and a few on horseback, and at the head of the column a single large elephant. No banners with text, no crosses, no detailed weapons. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b02-esirler

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 31-32: Zû Nefer bağlı tutuldu; Nüfeyl kılavuzluğu kabul edince serbest bırakıldı. Görünüşleri kaynakta yok.*

```text
Scene b02-esirler. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. At the edge of a military camp: one Arab captive with his hands bound in front, standing among a few undetailed Abyssinian soldiers; in the distance, a free Arab man walking ahead of the army, pointing the way. Faces drawn simply, no distinctive features. No violence, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b02-sakif-heyet

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Mes'ûd b. Muattib ve Ebû Rigāl (İbn Hişâm s. 32). Ebrehe b02-ebrehe-taht ile aynı kişi.*

```text
Scene b02-sakif-heyet. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A small group of Arab men of Ta'if in simple clothes standing before a short, stout, heavy-set Abyssinian ruler with a visible scar across his face (split brow, nose and lip area), heads slightly bowed in submission; one man stands a little apart, ready to lead the way. Faces drawn simply. No idols, no temple. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b02-develer-surulen

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 33: Esved b. Maksûd atlılarla hayvanları sürdü; Abdülmuttalib'in 200 devesi.*

```text
Scene b02-develer-surulen. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A herd of many camels being driven across a valley floor by a few horsemen, raising dust, seen from far away; riders small and undetailed. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b02-hunata-abdulmuttalib

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Abdülmuttalib (İbn Hişâm s. 34: yakışıklı, heybetli) ve Hunâta el-Himyerî (s. 33). Yaş ve sakal ayrıntısı kaynakta yok.*

```text
Scene b02-hunata-abdulmuttalib. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Two men facing each other in an open space in Mecca: on the left the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth, standing calm and upright; on the right a Yemeni envoy delivering a message with an open hand. Faces drawn simply, no exaggerated expressions. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 11: b02-ordugah

*Kontrol: tam dolu görsel, perde yok; İbn Hişâm s. 34: taht (sarîr) ve halı (bisât). Çadır ayrıntısı kaynakta yok; yalnız asılı kumaş kenarlar.*

```text
Scene b02-ordugah. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A ruler's camp setting: a large woven carpet on the ground, an empty simple wooden throne behind it, plain cloth hangings framing the left and right edges; no people. Full frame, warm daylight.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 12: b02-gorusme

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 34: Ebrehe tahtından inip halıda Abdülmuttalib'in yanına oturdu; tercüman.*

```text
Scene b02-gorusme. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A short, stout, heavy-set Abyssinian ruler with a visible scar across his face (split brow, nose and lip area), sitting on a carpet beside the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth; the ruler turned respectfully toward the chief; at the side an interpreter and a few undetailed soldiers standing. Faces drawn simply. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 13: b02-abdulmuttalib-yakin

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Abdülmuttalib; 'Ben develerin sahibiyim' anı. Aynı sohbette b02-hunata-abdulmuttalib ile aynı kişi.*

```text
Scene b02-abdulmuttalib-yakin. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close-up, head and shoulders, of the chief of Quraysh, a handsome, imposing Arab man in a simple head cloth, with a calm, steady, resolute expression; drawn simply in the flat paper cut-out style. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 14: b02-kapi-dua

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 34-35: kapı halkası, birkaç Kureyşli, halk dağlara çekiliyor. Kapı biçimi kaynakta yok: sade.*

```text
Scene b02-kapi-dua. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The chief of Quraysh, a handsome, imposing Arab man in a simple head cloth standing at the door of a low, roofless ancient stone sanctuary, holding the door ring with one hand, praying; a few men of Quraysh behind him, faces drawn simply. Far away on the mountainsides, tiny groups of people climbing up. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 15: b02-fil-coken

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 35: Nüfeyl filin kulağını tutar; fil çöker. Dövülme gösterilmez.*

```text
Scene b02-fil-coken. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A large elephant kneeling down on the ground and refusing to rise; puzzled soldiers standing around it, undetailed; beside the elephant's head a man leaning close to its ear. No beating, no raised weapons, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 16: b02-ordu-dagilan

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Kuşlar ayrı katman.*

```text
Scene b02-ordu-dagilan. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from far above: many tiny soldier figures scattering and fleeing in all directions across a plain, small and undetailed. No injuries, no bodies, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 17: b02-kuslar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Fîl 105/3-4; İbn Hişâm s. 35: denizden gelen, kırlangıç (hatâtîf) ve belesân benzeri kuşlar. Renk kaynakta yok; nur tonu yok.*

```text
Scene b02-kuslar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A great many small swallow-like birds in flocks filling the upper part of the frame, flying in waves, drawn as simple dark paper cut-out shapes; some carry tiny pebbles. No fire, no glow, no light rays. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 18: b02-terk-edilmis

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Sakin, boş bir an; Fîl Sûresi okunurken.*

```text
Scene b02-terk-edilmis. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. An empty desert plain after an army has fled: a few abandoned bundles and a collapsed load lying on the sand; no people, no bodies. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 19: b02-donus

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 36: Ebrehe yaralı olarak taşındı. Yara ayrıntısı yok.*

```text
Scene b02-donus. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Far view of small, scattered, exhausted groups of soldiers trudging along a desert road at dusk; in the middle one covered figure being carried by others. No wounds, no blood. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
