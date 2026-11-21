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
• İsteğe bağlı altyazı, yazı boyutu ayarı
• İzleme ilerlemesi cihazınızda saklanır

REKLAMSIZ, HESAPSIZ, ÇEVRİMDIŞI
Uygulama ücretsizdir. Reklam, hesap ya da veri toplama yoktur; internet bağlantısı gerektirmez.
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

**Uygulama içeriği → Gizlilik politikası:** `magaza/gizlilik.html` yayımlandıktan sonraki adres. İçindeki `ILETISIM_EPOSTASI` yerine geliştirici e-postası yazılmalı.

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
