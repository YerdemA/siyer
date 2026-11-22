# Play Store metinleri ve Play Console formları

Kapalı test (MVP, 1.0.0+1) için. Metinler Play Console'a elle girilir.

## Mağaza girişi (Türkçe, varsayılan dil)

**Uygulama adı** (en çok 30 karakter)

```
Resulü Ekrem'in Hayatı
```

**Kısa açıklama** (en çok 80 karakter)

```
Peygamberimizin hayatı; hareketli resimler, anlatıcı sesi ve kaynaklarıyla.
```

**Tam açıklama** (en çok 4000 karakter)

```
Resulü Ekrem'in Hayatı, Hz. Muhammed'in (s.a.v.) hayatını bölüm bölüm, hareketli illüstrasyonlar ve anlatıcı sesiyle anlatır.

İlk sürüm peygamberlik öncesi dönemi on bölümde ele alır: Mekke ve Kâbe'den, Fil Vakası ve Efendimiz'in doğumundan, süt annesi Halîme'nin yanındaki yıllara, yetimliğe, gençliğe, "el-Emîn" lakabına, Hz. Hatice ile evliliğe ve Hira'daki inzivaya kadar.

KAYNAĞA DAYALI
Anlatılan her bilgi bir kaynağa bağlıdır: Kur'ân-ı Kerîm, hadis kitapları, İbn Hişâm'ın Sîre'si ve TDV İslâm Ansiklopedisi gibi eserler. Her bölümün sonunda o bölümün kaynakları listelenir, tam kaynakça Ayarlar'dadır. Rivayetler arasında fark olduğunda ana metne en güçlü rivayet girer, diğerleri dipnotta belirtilir.

HER YAŞA UYGUN
Sade ve saygılı bir dil. Efendimiz, yüz ve beden ayrıntısı olmadan, nur olarak gösterilir.

ÖZELLİKLER
• Anlatıcı sesli, hareketli sahnelerden oluşan 10 bölüm
• Mekke ve çevresini gösteren illüstre harita
• Olayları sıralayan zaman çizelgesi
• Bölümlerde adı geçen kişileri tanıtan şahıslar sözlüğü
• İsteğe bağlı altyazı, yazı boyutu ayarı, 1,5× ve 2× hız
• Ekran kapalıyken de anlatımı dinleyebilme
• İzleme ilerlemesi cihazınızda saklanır

REKLAMSIZ, HESAPSIZ, ÇEVRİMDIŞI
Uygulama ücretsizdir. Reklam, hesap ya da veri toplama yoktur. İlk bölüm uygulamayla gelir; diğerleri ilk açılışta Google Play'den bir kez iner (2–8 MB), sonra internetsiz izlenir.
```

## Kapalı test notu (test edenlere)

```
Bu bir kapalı test sürümüdür. Kaynak atıflarının bir kısmı henüz asıl eserlerden tek tek kontrol edilme aşamasındadır; uygulamada "doğrulama bekliyor" diye işaretlidir. Gördüğünüz hata, ses sorunu ya da içerikle ilgili notları geri bildirim olarak iletebilirsiniz.
```

## Görseller

| Öğe | Ölçü | Durum |
|---|---|---|
| Uygulama simgesi | 512×512 PNG | `magaza/simge-512.png` |
| Öne çıkan grafik | 1024×500 PNG/JPG | `magaza/one-cikan-grafik.png` (taslak: Mekke katmanları + Kâbe; Erdem onayı) |
| Telefon ekran görüntüleri | en az 2, 9:16, 320–3840 px | telefondan alınacak: ana ekran, bir sahne, bölüm sonu kaynak listesi, harita, zaman çizelgesi |

## Play Console formları

**Uygulama içeriği → Gizlilik politikası:** https://yerdema.github.io/siyer-gizlilik/ (GitHub Pages, herkese açık `YerdemA/siyer-gizlilik` deposu, 2026-11-22). `magaza/gizlilik.html` değişirse o depodaki `index.html` da güncellenmeli.

**Veri güvenliği**
- Uygulama kullanıcı verisi topluyor ya da paylaşıyor mu? → **Hayır**
- (Form "Hayır" ile biter; şifreleme ve silme soruları sorulmaz.)

**Reklamlar:** Reklam içermiyor.

**Uygulama erişimi:** Tüm işlevler kısıtlama olmadan kullanılabilir (giriş yok).

**İçerik derecelendirmesi (IARC anketi)**
- Kategori: Eğitim / referans
- Şiddet, cinsellik, küfür, uyuşturucu, kumar: yok
- Kullanıcı etkileşimi, konum paylaşımı, dijital satın alma: yok
- Not: Fil Vakası anlatılır ama kan ya da yaralanma gösterilmez.

**Hedef kitle ve içerik:** Karar bekliyor (bkz. DURUM.md). 13 yaş altı seçilirse uygulama Aileler politikasına tabi olur; reklam ve veri toplama olmadığından uyumlu, ama inceleme daha uzun sürebilir.

**Haber uygulaması:** Hayır. **Devlet uygulaması:** Hayır. **Finans/sağlık:** Hayır.

**Kategori:** Eğitim (alternatif: Kitaplar ve Referans). **Etiketler:** din, tarih.

## Play Console adımları (kapalı test, sıfırdan)

1. **Uygulama oluştur:** ad "Resulü Ekrem'in Hayatı", varsayılan dil Türkçe, Uygulama, Ücretsiz; beyanları onayla.
2. **Play Uygulama İmzalama:** ilk AAB yüklenince Google'ın uygulama imzalama anahtarı kabul edilir; bizim `siyer-yukleme.jks` yalnız yükleme anahtarıdır (yedeklenmeli).
3. **Test → Kapalı test → Yeni kanal** (ör. "kapali-test"): **Test edenler** sekmesinde e-posta listesi oluştur (en az 12 kişi; kişisel hesaplarda üretime çıkmak için 14 gün kapalı test şartı). Geri bildirim adresi ve katılım bağlantısı burada.
4. **Yeni sürüm oluştur:** `İndirilenler\siyer\siyer-kapali-test-1.0.0+1-v3.aab` yükle. Sürüm adı `1.0.0 (1)`, sürüm notu: yukarıdaki "Kapalı test notu". Yükledikten sonra **Uygulama paketi gezgini**'nde b02–b10 isteğe bağlı paketler görünmeli. Gizleme eşleme dosyası istenirse `app/build/semboller` (Dart) — zorunlu değil.
5. **Uygulama içeriği** (sol menü, alt kısım): gizlilik politikası adresi, uygulama erişimi, reklamlar, içerik derecelendirmesi, hedef kitle, veri güvenliği, haber uygulaması, devlet uygulaması — cevaplar yukarıda. Hedef kitle kararı Erdem'in.
6. **Ana mağaza girişi:** kısa/tam açıklama, simge, öne çıkan grafik, en az 2 telefon ekran görüntüsü (`magaza/ekran-goruntuleri/`).
7. **Ülkeler:** kapalı kanalda Türkiye (+ istenen ülkeler).
8. **İncelemeye gönder** (Yayın özeti). İlk inceleme birkaç gün sürebilir. Onaydan sonra test edenler katılım bağlantısından katılıp Play'den kurar; bölüm indirmesi gerçek ağda ilk kez orada denenir.
