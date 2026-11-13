# Kaynak Politikası

Uygulamanın iddiası: içindeki her bilgi güvenilir bir kaynağa dayanır ve kullanıcı o kaynağı görebilir.

## 1. Kaynak katmanları

| Katman | Tür | Eserler | Kullanım |
|---|---|---|---|
| A | Kur'an | Kur'ân-ı Kerîm (Diyanet meali) | Doğrudan dayanak (ör. Fîl, Duhâ, İnşirâh sûreleri) |
| B | Sahih hadis | Buhârî, Müslim; ardından diğer Kütüb-i Sitte | Hadis numarasıyla |
| C | Klasik siyer ve tarih | İbn Hişâm, *es-Sîre*; İbn Sa'd, *et-Tabakât*; Taberî, *Târîh* | Olay akışının ana kaynağı |
| D | Çağdaş akademik | TDV İslâm Ansiklopedisi; Diyanet'in siyer yayınları; hakemli dergi makaleleri | Rivayetlerin değerlendirmesi, tarihleme, tartışmalı konular |
| E | Çağdaş siyer kitapları | Köksal, Hamidullah, Mübârekfûrî vb. | Anlatım düzeni ve çapraz kontrol |

Web siteleri, forumlar, sosyal medya, kaynağı belirsiz derlemeler ve yapay zekâ çıktıları kaynak değildir.

## 2. Bir iddianın uygulamaya girme şartı

1. En az bir A, B ya da C katmanı kaynağı; yoksa en az iki D kaynağı.
2. Atıf eksiksiz: eser, cilt/sayfa (ya da kitap/bab/hadis no), kullanılan baskı.
3. Erdem atıfı kaynağın kendisinden görmüş ve `dogrulandi` olarak işaretlemiş.
4. Yayın öncesi uzman okumasından geçmiş (bkz. bölüm 6).

## 3. Rivayet gücü

Her iddia şu etiketlerden birini taşır:

- `kesin` — Kur'an ya da sahih hadisle sabit
- `guclu` — Klasik kaynakların çoğunda ortak, çağdaş araştırmalarca kabul edilmiş
- `ihtilafli` — Kaynaklar arasında fark var (tarih, yaş, yer, kişi)
- `zayif` — Senedi ya da tarihî dayanağı zayıf bulunmuş

Kurallar:

- Ana metne `kesin` ve `guclu` girer.
- `ihtilafli` konularda en güçlü görüş ana metne, diğerleri dipnota yazılır ("Bazı rivayetlerde ... olarak geçer").
- `zayif` rivayet ana metne girmez. Çok yaygın biliniyorsa dipnotta zayıflığı belirtilerek anılabilir.
- Hangi görüşün güçlü olduğuna biz değil kaynaklar karar verir; gerekçe (hangi eser ne diyor) kayda yazılır.

Peygamberlik öncesi dönem için özellikle dikkat: doğum tarihi, Şam yolculuğundaki yaş, Bahîrâ rivayeti, şakk-ı sadr ve doğum gecesi anlatılan olağanüstü hadiseler kaynaklarda farklı değerlendirilir. Bunlar yazılmadan önce D katmanındaki değerlendirme mutlaka okunur.

## 4. Atıf biçimi

- Kitap: `İbn Hişâm, es-Sîre, c. 1, s. 158 (baskı: ...)`
- Hadis: `Buhârî, Bed'ü'l-vahy, 3` ve varsa hadis numarası
- Ansiklopedi: `Müellif, "MADDE", TDV İslâm Ansiklopedisi, c., s.`
- Âyet: `Fîl 105/1-5`

Uygulamada bölüm sonunda kısa biçim, Ayarlar > Kaynakça'da tam künye gösterilir.

## 5. Yapay zekâ kullanımı

- Yapay zekâ taslak yazar, kaynakta arama yapar, tutarsızlık bulur. Kaynak **olamaz**.
- Yapay zekânın verdiği cilt/sayfa/hadis numarası, Erdem asıl metinde görene kadar `bekliyor` durumundadır.
- Not defteri (Gemini Notebook / NotebookLM) cevapları da yalnızca yol göstericidir; gösterdiği pasaj açılıp okunur.
- Görsel üretiminde tarihî ayrıntılar (mimari, kıyafet, coğrafya) için de kaynak aranır; emin olunmayan ayrıntı çizilmez.

## 6. Uzman okuması

Her bölüm yayından önce en az bir siyer/İslâm tarihi ya da hadis alanı uzmanına okutulur. Okuyanın adı (izniyle) ve tarih, bölüm kaydına ve uygulamanın "Hakkında" ekranına yazılır. Uzman bulunana kadar bölüm "taslak" kalır.

## 7. Hata düzeltme

Uygulamada "Hata bildir" bağlantısı bulunur. Doğrulanan hatalar düzeltilir ve sürüm notlarında açıkça belirtilir.
