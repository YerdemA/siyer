# Güncellemesiz yeni bölüm (uzak katalog)

Erdem'in fikri (2026-11-25): yeni bir bölüm hazır olunca kullanıcı uygulamayı güncellemeden onu görüp izleyebilsin. MVP sonrası için; altyapı şimdiden buna göre kurulur.

## Kararlar

- **Barındırma: GitHub Releases** (Erdem, 2026-11-25). Herkese açık, yalnız yayın dosyalarını tutan ayrı bir depo (ör. `YerdemA/siyer-bolumler`); kaynak kod ve `kaynaklar/` oraya girmez. Ücretsiz, dosya başına 2 GB sınır, bölüm ~15–25 MB.
- Sunucu kodu, hesap, analitik yok. Uygulama yalnız statik dosya okur. **Gizlilik metnine eklenecek:** bölüm indirilirken ve katalog okunurken GitHub IP adresini görür.
- Play politikası: indirilen içerik çalıştırılabilir kod değil (JSON, WebP, MP3), izinli. Oynatıcının yeni yeteneği gerekiyorsa bu yine uygulama güncellemesiyle gelir (aşağıda `gerekliSurum`).
- Play Asset Delivery (b02–b10) olduğu gibi kalır; PAD yeni paketi yalnız uygulama güncellemesiyle ekleyebildiği için yeni bölümler uzak katalogdan gelir.

## Akış

1. Uygulama açılışta (en çok günde bir, internet varsa, arka planda) `katalog.json`'u indirir; son okunan kopya cihazda saklanır, internetsiz açılışta o kullanılır.
2. Katalogda olup uygulamada olmayan bölüm ana sayfada kart olarak görünür ("Yeni" işaretiyle); dokununca indirilir (PAD bölümleriyle aynı indirme ekranı).
3. İndirilen bölüm `files/uzak/<bölüm>/` altına açılır; içerik deposu bölümü gömülü/PAD bölümleriyle aynı biçimde okur. Ayarlar → İndirilen bölümler'de silinebilir.
4. Katalogdaki bölümün `surum`u cihazdakinden büyükse (düzeltme yapıldı) kartta "Güncelle" görünür; eski kopya yenisi tamamen inene kadar oynatılabilir.

## `katalog.json` (taslak)

```json
{
  "semaSurumu": 1,
  "bolumler": [
    {
      "id": "b11-ilk-vahiy",
      "sira": 11,
      "surum": 1,
      "gerekliSurum": "1.1.0",
      "diller": ["tr"],
      "baslik": {"tr": "İlk Vahiy", "en": "The First Revelation"},
      "ozet": {"tr": "…", "en": "…"},
      "dosya": "https://github.com/YerdemA/siyer-bolumler/releases/download/b11-v1/b11-ilk-vahiy.zip",
      "boyut": 18234567,
      "sha256": "…"
    }
  ],
  "ortak": [
    {"ad": "sahislar", "surum": 3, "dosya": "…/ortak-v3.zip", "sha256": "…"}
  ]
}
```

- `gerekliSurum`: bölüm, oynatıcının bu sürümden önce bilmediği bir özelliği kullanıyorsa; eski uygulamada kart görünür ama "Bu bölüm için uygulamayı güncelleyin" der.
- `ortak`: yeni bölümle gelen şahıs, yer, zaman çizelgesi ve kaynakça kayıtları; uygulama gömülü kopyanın üstüne birleştirir (yeni kimlikler eklenir, var olan kayıt yalnız daha yüksek sürümle değişir).
- Paket (zip): `bolum.json`, `gorseller/*.webp`, `ses/<dil>/*.mp3`, `muzik/` gerekirse. Yol biçimi PAD paketleriyle aynı.

## Güvenlik ve bütünlük

- Yalnız HTTPS; indirilen dosyanın `boyut` ve `sha256`'sı katalogla eşleşmezse silinir.
- Katalog imzası (ed25519) ikinci aşama: GitHub hesabı ele geçirilirse sahte içerik yayımlanabilir; imza bunu önler. Başlangıçta hesapta iki adımlı doğrulama zorunlu.
- Zip açılırken yol denetimi (`..` ve mutlak yol reddedilir).

## Yayın kapısı

- `tools/bolum_yayinla.dart` (yazılacak): bölümü `icerik_dogrula.dart --yayin` ile denetler (doğrulanmamış atıf varsa durur), paketi ve `sha256`'yı üretir, `katalog.json`'u günceller, `gh release create` ile yükler. Erdem onaylamadan yayımlamaz.
- Yayımlanan bölüm geri çekilebilir: katalogdan çıkarılınca yeni kullanıcı görmez; indirmiş olanlarda kalır (ya da `geriCekildi: true` ile oynatıcı uyarı gösterir).

## Uygulamada gereken işler

1. `KatalogDeposu`: indirme (`dart:io` `HttpClient`, yeni paket gerekmez), önbellek, günde bir yenileme.
2. Zip açma ve sha256: `archive` ve `crypto` paketleri (Dart ekibi / yaygın; **Erdem onayı gerekir**) ya da zip yerine dosya dosya indirme (paketsiz; sha256 yine `crypto` ister).
3. İçerik deposunun bölüm listesini gömülü + PAD + uzak kaynaktan birleştirmesi; bölüm sırası `sira` ile.
4. Ana sayfa kartı durumları: yeni, indiriliyor, güncelleme var, uygulama güncellemesi gerekli.
5. Ayarlar → İndirilen bölümler: uzak bölümler de listelenir ve silinir.
6. Testler: bozuk katalog, yarıda kalan indirme, sha256 uyuşmazlığı, `gerekliSurum` büyük, internetsiz açılış.

## Açık sorular

- Katalog adresi sabit olmalı (uygulamaya gömülür): GitHub Releases'te "latest" bağlantısı ya da depodaki ham dosya (`raw.githubusercontent.com`). İkincisi önbellekli ve basit; öneri bu.
- MVP'deki PAD bölümleri ileride uzak kataloğa taşınabilir (uygulama küçülür); şimdilik gerek yok.
