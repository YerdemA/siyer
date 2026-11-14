# b10-hira: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\siyer` klasörüne, mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.

**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.

**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. Ordinary people may show their faces, drawn simply in the same flat paper cut-out style, dignified, not photorealistic. The Prophet Muhammad appears only when the prompt asks for him, and then only as a tall, dignified figure entirely covered in soft warm golden-white light, wearing a green turban; no face, skin, hands or body detail visible inside the light. His wives, children, parents and wet nurse never show a face: only from behind, as distant silhouettes, or as hands and fabric details. No other prophet in any form: no figure, silhouette, shadow, hand or foot, only a soft warm light. No angels. No blood.

Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom and 8% on each side. Keep every important element (people, faces, hands, key objects) well inside that central area; a single isolated object must sit fully inside the frame with empty margin around it. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: b10-put-bayrami

*Kontrol: yeşil perde, zemin düz yeşil olmalı; İbn Hişâm s. 143: Kureyş'in yılda bir bayram yaptığı, etrafında döndüğü taş put; adı verilmiyor. Put kaba yontulmuş taş (GORSEL_USLUP). Kan ve kesim yok.*

```text
Scene b10-put-bayrami. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Mid shot of a pagan festival in an open dusty place in a bare rocky valley: in the center a crudely carved stone idol, roughly hewn, weathered grey-brown stone, with only a vague hint of a head and shoulders, no inscriptions, not oversized. A crowd of men and women in simple 6th-century Arabian clothes walks in a circle around it; simple dignified faces in the same paper cut-out style. No blood, no animal being slaughtered, no fire. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 2: b10-dort-kisi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Varaka, Ubeydullah b. Cahş, Osman b. Hüveyris, Zeyd b. Amr (İbn Hişâm s. 143). Kaynakta görünüş yok; belirgin özellik uydurulmaz.*

```text
Scene b10-dort-kisi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Four Arab men of Mecca in simple 6th-century clothes and head cloths, of different ages, walking quietly away together, seen from the side, glancing back over their shoulders; serious, thoughtful faces drawn simply. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 3: b10-dort-kisi-yakin

*Kontrol: yeşil perde, zemin düz yeşil olmalı; s03'teki dört kişiyle aynı kıyafet ve yaşlar korunmalı (aynı sohbette üret).*

```text
Scene b10-dort-kisi-yakin. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close shot of four Arab men in simple 6th-century clothes and head cloths, standing close together between mudbrick house walls at dusk, heads leaned toward each other, talking in low voices; serious, thoughtful faces drawn simply, no exaggerated expressions. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 4: b10-sam-arazi

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Şam yolu; arazi ayrıntısı kaynakta yok, belirgin bitki ve yapı çizilmez. Ufkun üstü yeşil perde.*

```text
Scene b10-sam-arazi. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Wide landscape layer: an open plain with low rolling hills and a dirt road crossing it, a few scattered low shrubs; flatter and less rocky than the steep bare mountains of Mecca. No buildings, no people. Fills the lower two thirds of the frame; everything above the horizon is flat chroma green (#00B140), so the separate sky layer shows through. No green tint on the landscape.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 5: b10-zeyd-dua

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Buhârî 3827: Zeyd ellerini kaldırıp dua eder. Yaş ve görünüş kaynakta yok.*

```text
Scene b10-zeyd-dua. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. An Arab man of Mecca in simple travel clothes with a small shoulder bag, standing outdoors in open country and raising both open hands toward the sky in prayer; calm, resolute face drawn simply, no distinctive features. Full figure, slightly from the side. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 6: b10-kabe-duvar

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Kâbe duvarının bir parçası; malzeme, yükseklik ve örtü belirtilmez (anın tarihi kaynakta yok).*

```text
Scene b10-kabe-duvar. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close view of a section of an ancient plain stone wall filling the right half of the frame from top to bottom; no cloth covering, no door, no inscriptions, no gold. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 7: b10-zeyd-yasli

*Kontrol: yeşil perde; nesne kenarlara değmemeli; İbn Hişâm s. 144 'şeyh kebîr' (yaşlı); Buhârî 3828 sırtını Kâbe'ye dayamış. Başka görünüş ayrıntısı yok.*

```text
Scene b10-zeyd-yasli. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. An old Arab man in simple clothes, standing with his back leaning against a stone wall (the wall itself not drawn), one hand raised as he speaks earnestly to people in front of him; dignified, serious face drawn simply, no other distinctive features. Full figure. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 8: b10-zeyd-sofra

*Kontrol: yeşil perde; nesne kenarlara değmemeli; Onun gözünden. Zeyd yalnız konuşur; sofrayı kimin kime sunduğu ve kimin yemediği rivayetlerde farklı olduğu için jest yok.*

```text
Scene b10-zeyd-sofra. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Seen from the viewpoint of someone sitting on the ground: an Arab man in simple clothes sits cross-legged on the far side of a leather eating mat, facing the viewer and speaking calmly; hands resting, no pushing-away or refusing gesture; face drawn simply, no distinctive features. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 9: b10-sofra

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Ön plan; içi gösterilmez (et ayrıntısı yalnız bir rivayette). ayar.gorsel ile yerleştirilecek.*

```text
Scene b10-sofra. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A round leather eating mat spread on the ground, seen from slightly above, with a simple covered wooden bowl on it; contents not visible. No hands. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```

## Mesaj 10: b10-vadi-tas

*Kontrol: yeşil perde, zemin düz yeşil olmalı; Müslim 2277: Mekke'de bir taş. Vadi/patika yok (o ayrıntı İbn Hişâm rivayetinde, dipnotta). Parıltı kesinlikle yok.*

```text
Scene b10-vadi-tas. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Eye-level view at dawn of a quiet corner in Mecca near mudbrick houses: a single plain, medium-sized stone standing by itself next to a wall. No people, no face or features on the stone, no glow, no light rays. No hands, arms, feet or body of the viewer anywhere in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; the Prophet never appears unless this prompt explicitly asks for him; no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks. No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral.
```
