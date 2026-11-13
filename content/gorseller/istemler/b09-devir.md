# b09-hakem görsel üretimi — Higgsfield devri

Bu metni olduğu gibi claude.ai sohbetine yapıştır. Higgsfield bağlayıcısı, Claude Code'daki ile aynı hesapla bağlı olmalı.

---

Higgsfield MCP ile aşağıdaki görselleri üret. Kurallar:

1. **Model ve ayarlar:** `model: nano_banana_pro`, `aspect_ratio: 16:9`, `resolution: 2k`.
2. **Üslup referansı:** her isteğe `medias: [{"value": "a5e23296-85b4-40f2-9289-f94ea4dd0085", "role": "image_references"}]` ekle. Bu, daha önce üretilmiş bir işin kimliği; yükleme gerekmez.
3. **Yalnız sınırsız deneme hakkı:** her istekte `use_unlim: true`. Kredi harcama. Bir istek sınırsız hakla reddedilirse krediyle tekrar deneme. Önce `models_explore` ile sınırsız hakkın kapsadığı ayarlara bak; 2k kapsam dışıysa `1k` ile dene. O da olmazsa dur ve hangi istemde kaldığını yaz.
4. **Varyant:** her istemden 2 ayrı üretim (her biri ayrı istek). Birden çok istek için `generate_image_batch`, bekleme için `jobs_wait` kullan.
5. **İstemleri değiştirme:** aşağıdaki istem metnini harfiyen gönder; kısaltma, ekleme, çeviri yok.
6. **Denetim:** her sonuca bak. Şunlardan biri varsa o varyantı bir kez yeniden üret ve tabloya not düş:
   - görünür bir yüz (göz, burun, ağız seçiliyorsa);
   - istemde istenmeyen bir insan, el, kol ya da beden parçası (özellikle `s12-kumas`: tam dört çift el olmalı, beşinci el ya da kol olmamalı);
   - yazı, harf, logo, filigran; minare, kubbe, hilal, kemer, çini;
   - yeşil perdeli istemlerde zeminin düz yeşil olmaması.
7. **Sonuç:** sonunda şu tabloyu ver (kod bloğu içinde, düz metin): `istem_id | varyant | job_id | durum | not`. Dosyaları indirmen gerekmiyor; Claude Code aynı hesaptan iş kimlikleriyle çeker.

Toplam: 13 istem × 2 varyant = 26 üretim.

## m01-gok-safak

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Sky only, dawn: deep indigo at the top fading to soft apricot near the horizon, a few thin high clouds, no land.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m02-daglar

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Two overlapping ranges of bare, jagged, rocky desert mountains seen from the valley floor, the far range paler with haze, no vegetation, no buildings. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m03-zemin

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Valley floor only: packed sand and gravel ground receding toward the horizon, scattered small stones, a dry stream bed trace. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m04-evler

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

A loose row of small flat-roofed houses of mudbrick and rough stone along the valley, simple wooden doors, a few low walls; an empty open space in the center of the row. No people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m05-kabe-alcak

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

A small, low, plain cube-shaped building of dry-stacked dark grey stones without mortar, walls only slightly taller than a person, no roof, no covering cloth, no decoration, seen from a three-quarter angle. Strictly a cube: straight vertical walls and sharp square corners, not round. Soot stains and flood marks at the base. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m06-kabe-yarim

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

The same cube-shaped stone building under reconstruction: walls rising unevenly, courses of dark stone alternating with thin wooden beams, an empty notch at one corner at chest height, piles of stones and timber at the base. No people. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## m07-kabe-yuksek

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

The finished cube-shaped stone building, now about twice as tall as before, with a flat roof, courses of dark stone and thin wooden beams, a single-leaf wooden door set high above the ground, no covering cloth, no decoration. Beside it, an open semicircular area left outside the building, its edge only faintly suggested. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s07-tasiyan

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Seen from behind at close range: a man in a simple undyed wool robe and head cloth walking up a stony slope, carrying a rough stone on his right shoulder; his face is not visible at all. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s07-yokus

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Eye-level view up a gentle stony path toward a construction site in the distance, loose stones and dust on the ground; no hands, arms, feet or body of the viewer in frame. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s11-giris

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

First-person view from a simple narrow gap between two mudbrick house walls, looking out into a sunlit open courtyard; the walls frame the left and right edges in shadow. No arch, no monumental gate. No hands, arms, feet or body of the viewer. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s11-kalabalik

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

A crowd of men in simple robes and head cloths standing in a courtyard at middle distance, many turning toward the viewer, faces not visible — in shadow, turned away or too far to see any features. Isolated on a perfectly flat, uniform pure chroma-green background (#00B140), no shadows on the background, no green tint on the subject.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s12-kumas

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Top-down view of a plain undyed cloth spread on a stone floor, a smooth black stone resting at its center; four men's hands and forearms reach in from the four edges of the frame, each gripping one corner of the cloth. A soft warm golden-white glow rests over the stone, as if from an unseen light. Only these four pairs of hands; no other hand, arm or body anywhere.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```

## s13-hacer

```text
Flat-shape illustration for a documentary motion comic in a paper cut-out style: layered flat shapes with clear depth planes, each plane like a sheet of textured paper with a soft shadow beneath it. Muted, low-saturation earth palette: sand, ochre, raw umber, warm grey stone; deep indigo for night, soft apricot for dawn and dusk. Gentle atmospheric haze, clean readable silhouettes, calm and respectful mood. Setting: Mecca, Hijaz, around 605 CE — a narrow valley among bare, rocky, almost treeless mountains; small flat-roofed houses of mudbrick and rough stone. Cinematic 16:9 framing.

Close-up of a wall of dry-stacked dark stones with thin wooden beams; at the corner a smooth black stone set into a niche at chest height. A soft warm golden-white glow fades around the stone. No hands, no people.

No minarets, no domes, no crescents, no arches, no tiles, no Ottoman or modern architecture, no modern Masjid al-Haram. No text, letters, logos or watermarks. No visible faces: people appear only as distant silhouettes, from behind, or as hands and fabric details. Never depict the Prophet in any form — no figure, silhouette, shadow, hand or foot; his presence is only a soft warm golden-white light. No angels. No blood.
```
