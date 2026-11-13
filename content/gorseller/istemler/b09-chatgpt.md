# b09-hakem: ChatGPT ile görsel üretimi

**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.
Referans dosyası: Higgsfield galerisindeki iş `a5e23296-85b4-40f2-9289-f94ea4dd0085` ya da Claude Code'un verdiği `u01d.png`.

**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli indir (`İndirilenler\siyer` klasörüne). Atladığın ya da tekrar ürettirdiğin olursa Claude Code'a söyle; dosyalar indirme sırasına göre eşleştirilir.

**Görsel kötü çıkarsa** (yüz görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil) aynı sohbette şunu yaz ve yenisini indir: `Regenerate this one: <sorun>. Keep everything else.`

**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.

## Mesaj 0: üslup ve kurallar (görseli ekleyerek)

```text
I am making a respectful documentary motion comic about 7th-century Mecca. The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. Use it only for style, not composition.

Style: Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic wide framing.

Strict rules for every image: No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.

Format for every image: landscape 3:2. Keep all important content inside the middle horizontal band; the top and bottom 10% will be cropped. Generate exactly one image per message. Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one.
```

## Mesaj 1: m07-kabe-yuksek

*Kontrol: yeşil perde*

```text
Scene m07-kabe-yuksek. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. The finished cube-shaped stone building, now about twice as tall as before, with a flat roof, courses of dark stone and thin wooden beams, a single-leaf wooden door set high above the ground, no covering cloth, no decoration. Beside it, an open semicircular area left outside the building, its edge only faintly suggested. No stairs or steps of any kind; the door simply sits high in the bare wall. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 2: s07-yokus

*Kontrol: yeşil perde*

```text
Scene s07-yokus. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Eye-level view up a gentle stony path toward a construction site in the distance, loose stones and dust on the ground; no hands, arms, feet or body of the viewer in frame. Only the path, ground and loose stones: no buildings, no walls, no scaffolding. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 3: s11-giris

*Kontrol: yeşil perde; Kapının o dönemki biçimi kaynakta yok; sade aralık.*

```text
Scene s11-giris. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. First-person view from a simple narrow gap between two mudbrick house walls, looking out into a sunlit open courtyard; the walls frame the left and right edges in shadow. No arch, no monumental gate. No hands, arms, feet or body of the viewer. The courtyard is empty in the center: no building, no cube-shaped structure, no people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 4: s11-kalabalik

*Kontrol: yeşil perde*

```text
Scene s11-kalabalik. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. A crowd of men in simple robes and head cloths standing in a courtyard at middle distance, many turning toward the viewer, faces not visible — in shadow, turned away or too far to see any features. Only the people: no building, no cube-shaped structure, no houses behind them. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 5: s12-kumas

*Kontrol: Resûlullah'a ait el ya da kol çizilmez; yalnız nur. Yapay zekâ beşinci bir el eklemeye meyilli; elle kontrol.*

```text
Scene s12-kumas. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Top-down view of a plain undyed cloth spread on a stone floor, a smooth black stone resting at its center; four men's hands and forearms reach in from the four edges of the frame, each gripping one corner of the cloth. A soft warm golden-white glow rests over the stone, as if from an unseen light. Only these four pairs of hands; no other hand, arm or body anywhere.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```

## Mesaj 6: s13-hacer

*Kontrol: Gerçek görsel gelince yer tutucu 'nur' katmanı kaldırılabilir ya da hafif bırakılır.*

```text
Scene s13-hacer. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, muted earth palette. Not photorealistic, not a 3D render. Close-up of a wall of dry-stacked dark stones with thin wooden beams; at the corner a smooth black stone set into a niche at chest height. A soft warm golden-white glow fades around the stone. No hands, no people.

Rules: no visible faces; no extra people, hands or body parts beyond what is described; no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; no text or watermarks.
```
