# Görsel ve İşitsel Üslup Rehberi

## Tür

Hareketli illüstrasyon (motion comic): resim gibi sabit kareler, katmanlar arası derinlik (parallax), yavaş kamera hareketi, ışık, toz, duman, kum gibi basit efektler. Karakter animasyonu yok.

## Temsil kuralları (değişmez)

Bu kurallar 2026-11-14'te Erdem'in kararıyla değişti. Eskiden yüz gösterilmemesi herkes için geçerliydi; izleyici açısından iç karartıcı bulundu.

1. **Hz. Muhammed (s.a.v.):** İki yöntem:
   - *Nurlu figür:* Asaleti belli eden bir boyda, baştan ayağa yumuşak, sıcak altın-beyaz nurla kaplı bir figür. Kenarları yumuşak, ortası parlak, ayakları ışığa karışır ve zemine ışık düşürür; sahneye yapıştırılmış gibi durmaz, ama biçimi seçilir (saydam değil). Yüz, ten, el ve beden ayrıntısı görünmez; nurun içinde yalnız boy seçilir. Peygamberlik öncesi bölümlerde sarık yoktur; yeşil sarıklı görünüme peygamberlikten sonraki bölümlerde geçilir (Erdem, 2026-11-18). Nuru oynatıcı çizer, görsele çizilmez.
   - *Onun gözünden:* Sahne onun bakış açısından görülür.
2. **Diğer peygamberler** (Hz. İbrâhim, Hz. İsmâil vb.): Figür, siluet, gölge, el, ayak dahil hiçbir beden tasviri yok. Bulundukları yerde beden boyunda, hatları olmayan bir nur durur: ayakta bir insan boyunda, yumuşak kenarlı bir ışık. Kaba bir insan biçimi sezilir (yuvarlak baş, omuzlar, aşağı doğru hafifçe açılan giysi; Erdem, 2026-11-14), ama kenarlar bulanıktır: yüz, kol, el, ayak ya da keskin siluet yoktur. Alt ucu zemine basar, boyu sahnedeki insan ölçeğine uyar (çocukken çocuk boyunda). Nuru oynatıcı çizer, görsele çizilmez (Erdem, 2026-11-14).
3. **Efendimiz'in eşleri, çocukları, anne-babası (Hz. Âmine, Abdullah) ve süt annesi Halîme:** Yüz gösterilmez. Arkadan, siluet, uzak plan, kumaş ve el ayrıntısı kullanılabilir.
4. **Diğer herkes** (sahabe, Abdülmuttalib, Ebû Tâlib, Kureyş ileri gelenleri, halk, kalabalıklar): Yüzleriyle çizilebilir. Yaş, giyim, görünüş gibi ayrıntılar rivayet ve kaynaklardaki betimlemeye uygun olur; kaynakta betimleme yoksa sade, dönemine uygun, belirgin özellik uydurulmadan. Yüzler kâğıt kesik üslupta, sade ve saygılı; fotoğraf gerçekliğinde değil.
5. **Melekler:** Tasvir edilmez; ışık ve ses ile sezdirilir.
6. Üretilen her görsel bu kurallara göre elle denetlenir; yapay zekâ araçları istenmeyen figür eklemeye ve nurlu figürde yüz ya da el çizmeye meyillidir.

## Tarihî doğruluk

- Dönem: 6.–7. yüzyıl Hicaz'ı. Minare, kubbe, hilal, çinili cami, Osmanlı mimarisi, modern Mescid-i Harâm görünümü YOK.
- Kâbe: Dönemine uygun, sade, bugünkünden alçak; çevresi açık avlu ve evler. Peygamberlik öncesinde çevresinde putlar bulunur (ayrıntı için kaynak aranır).
- Putlar (Erdem, 2026-11-15): Gölge olarak değil, kaynaklardaki tasvire benzer figürler olarak çizilebilir. Kaynakta adı ve görünüşü verilmeyen put için kaba yontulmuş taş figür ya da dikili taş (İbn Hişâm s. 143: etrafında dönülen taş; ARAP maddesi: putlar, heykeller, dikili taşlar). Adı bilinen putun (ör. Hübel) belirgin özellikleri ancak kaynakta okunduktan sonra çizilir. Kan ve kurban kesimi gösterilmez.
- Mekke: Çıplak, kayalık dağlar arasında dar bir vadi; yeşillik yok denecek kadar az.
- Kıyafet, çadır, kervan, silah ayrıntıları için kaynaklara ve müze/arkeoloji referanslarına bakılır. Emin olunmayan ayrıntı çizilmez, kadraj dışında bırakılır.

## Kadraj

- Oran 16:9, yatay.
- Alt %25 altyazıya ayrılır: sahnenin anlatılan öğesi (kişi, nesne, Kâbe'nin ilgili köşesi) bu alana düşmez.
- Kamera yaklaşınca kenarlar boş görünmesin diye her katman kadrajdan ~%20 taşacak genişlikte üretilir.
- Her sahne ayrı katmanlar halinde üretilir (gök, uzak dağlar, zemin, yapılar, kişiler, ön plan), şeffaf arka planlı WebP. Derinlik ve kamera hareketi bu katmanlardan doğar.

## Harita

Gerçek harita değil: ahşap/parşömen dokusu üzerinde elle çizilmiş görünümlü bir illüstrasyon. Yerler yaklaşık konumlarıyla işaretlenir (`yerler.json` → `harita.x/y`).

Harita kodla çizilir (`app/lib/ekranlar/harita.dart`, `harita_cografya.dart`): parşömen zemin, Kızıldeniz ve kıyısı (bugünkü coğrafyadan, kaba; Erdem 2026-11-19), kıyıya koşut dağ süsleri, kervan yolları (kesik çizgi), pusula. Kıyı ve noktalar aynı doğrusal izdüşümü kullanır: `x = 0,46 + 0,0955 × (boylam − 39,83)`, `y = 0,654 − 0,05 × (enlem − 21,42)`. Mekke çevresindeki yakın yerler ayrı, büyütülmüş "Mekke çevresi" haritasında gösterilir.

## Renk ve ışık

- Ana palet: kum, toprak, koyu lacivert gece, şafak turuncusu. Doygunluk düşük.
- Uygulama arayüzü (ana sayfa, sözlük, harita): parşömen ve mürekkep; vurgu kına kırmızısı, seçim şafak altını, tamamlanan bölüm zeytin. Renkler `app/lib/tema.dart` → `Palet`.
- Nur: sıcak beyaz-altın; başka hiçbir ışık kaynağı bu tonu kullanmaz.
- Dönemlere göre ton: Câhiliye sahneleri daha soğuk ve sert; şefkat ve umut sahneleri daha sıcak.

## Tutarlılık

- Üretim yöntemi, katman tipleri, karakter kartları ve denetim akışı: `GORSEL_URETIM.md`.

- Tek bir üslup istemi (style prompt) ve 5–10 referans görsel belirlenir; tüm üretimler bunlarla yapılır.
- Tekrarlayan mekânlar (Mekke vadisi, Kâbe avlusu, Benî Sa'd yurdu, Hira) için sabit "mekân kartları" hazırlanır.
- Kullanılan araç, model sürümü ve istem her görselle birlikte `assets/` yanında kayda geçirilir.

## Ses

- **Anlatıcı:** Tek ses, sakin, saygılı, masalcı değil belgesel sıcaklığında. Hz. Peygamber'in sözleri de anlatıcı tarafından aktarılır; karakter seslendirmesi yok.
- **Müzik:** Sahnenin duygusuna göre değişir; söz içermez, anlatımı bastırmaz. Kullanım hakkı açık (özgün üretim ya da uygun lisans) olmalı.
- **Ortam sesleri:** Rüzgâr, kervan, çarşı, gece sessizliği.
- Yapay zekâ ile üretilen ses ve müzikte aracın ticari/ücretsiz kullanım şartları kayda geçirilir.

## Bölüm ölçüleri (pilotta netleşecek)

- Süre: 3–6 dakika
- Sahne: 8–15
- Sahne başına anlatım: 15–30 saniye
