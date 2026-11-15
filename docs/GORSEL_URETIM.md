# Görsel Üretim Yöntemi

Görsel kotası ve zaman kıymetli: hatayı üretimden önce istemle önlemek, üretimden hemen sonra da yakalamak. Temsil ve üslup kuralları `GORSEL_USLUP.md`'de; bu belge yalnız **nasıl üretildiğini** anlatır.

## Kesinlikle kabul edilmeyenler (Erdem, 2026-11-15)

1. **Kaynakla çelişki:** Kaynakta yazan bir özellik (yaş, sakal, beden, sayı) görselde farklı olamaz.
2. **Görseller arası çelişki:** Aynı kişi, hayvan ya da yer her görselde aynı görünür: sakal biçimi, rengi ve uzunluğu, kıyafet renkleri, yaş.
3. **Gerçek dışı hata:** Üç el, eksik ya da kaynaşmış uzuv, havada duran figür, sahneye uymayan ölçek.

## Katman tipleri

İstem kaydındaki (`content/gorseller/istemler/bXX.json`) `tip` alanı:

| tip | Ne üretilir | İşleme | Sahneye konuş |
|---|---|---|---|
| `figur` | Yalnız kişiler/hayvanlar, yeşil perdede, baştan ayağa, kenarlarda boşluk; zemin, gölge, bina YOK | `--sigdir` | `ayar.gorsel {x, y, olcek}`: ayaklar sahnenin zemin çizgisine, boy Kâbe/ev ölçeğine göre |
| `nesne` | Tek nesne (çadır, sofra, duvar parçası) | `--sigdir` | aynı |
| `zemin` | Alt kısmı dolu arazi, ufuk yatay ve verilen yükseklikte, üstü yeşil | perde (kırpılır) | tam kadraj |
| `mekan` | Tam dolu iç ya da dış mekân, kendi ışığıyla | `--opak` | tam kadraj; gerekirse `ayar.ton: false` |

Ortak katmanlar (gök, Mekke dağları, zemin, evler, Kâbe) bir kez üretilir ve her sahnede aynı kalır. Figür görseline bunların hiçbiri çizdirilmez; çizdirilirse ölçek ve görünüş tutmaz.

## Yapılı istem alanları

`tools/istem_devir.py`, kayıtta `konu` varsa istemi bu alanlardan kurar:

- `tip`, `cekim` (`uzak` / `orta` / `yakin` / `bakis`): kamera uzaklığı ve göz hizası. Kuşbakışı yok.
- `konu`: sahnede ne olduğu, tek cümle.
- `kisiler[]`: `{karakter | tarif, sayi, poz, hayvan}`. `karakter` verilirse `karakterler.json`'daki kartın İngilizce metni harfiyen girer. İstem toplam insan sayısını açıkça yazar.
- `yerlesim` (isteğe bağlı): sürü, kalabalık gibi özel düzen. Varsayılan: herkes tek yatay ayak çizgisinde, yan yana; çapraz ya da derine kaçan sıra yok.
- `izin`: perde kuralına tek istisna (ör. oturulan halı).
- `ufuk`: zemin katmanında ufkun yüksekliği (0–1).
- `isik`: yalnız `mekan` için. Figürler nötr gün ışığında üretilir; saat tonunu oynatıcı verir.
- `yasak`: bu görsele özel yasaklar.
- `yeniden_neden`: yeniden üretiliyorsa nedeni.

Her istemin sonunda ChatGPT'ye **çıktıdan önce denetle** listesi gider: kişi sayısı, uzuvlar, yüz kuralı, renkler, perde.

## Karakter kartları ve referans sayfaları

`content/gorseller/istemler/karakterler.json`: tekrar eden her kişi, hayvan ve nesnenin sabit görünüşü. `kaynak` dayanağı, `secim` ise kaynakta olmayıp tutarlılık için sabitlenenleri gösterir.

Bölüm istemlerinden önce her karakter için bir **referans sayfası** üretilir (aynı kişi üç açıdan, yeşil perdede): `istem_devir.py --karakterler` → `karakterler-chatgpt.md`. Claude Code sayfayı kartla karşılaştırır; onaylanan sayfa o karakterin geçtiği her mesaja iliştirilir. Görseller arası tutarlılığın asıl güvencesi budur; yalnız metinle ChatGPT aynı kişiyi her seferinde biraz farklı çizer.

## Akış

1. Claude Code istemleri yazar, `istem_devir.py ... --chatgpt` ile mesaj dosyasını üretir.
2. Erdem ChatGPT'de (tercihen bir **Proje** içinde) Mesaj 0'ı üslup görseliyle gönderir, sonra mesajları sırayla gönderir ve her görseli **sırayla** `İndirilenler\siyer` klasörüne indirir. Ad vermek gerekmez.
3. Birkaç görselde bir (ör. 4 görselde bir) Claude Code'a "indirdim" der. Claude Code:
   - `tools/gorsel_al.py <mesaj dosyası> --uygula`: dosyaları sıraya göre adlandırır, otomatik denetim yapar (perde düzlüğü, kenara değme, ufuk), `_kontrol.jpg` paftası çıkarır;
   - her görsele kartla ve üç kuralla bakar: kişi sayısı, eller, sakal, renk, ölçek;
   - kusurlu olanı tek cümlelik bir düzeltme mesajıyla Erdem'e verir (`Regenerate this one: ...`).
   Böylece bir hata, aynı hatayı taşıyan sonraki görseller üretilmeden yakalanır.
4. Onaylanan görseller `gorsel_katman.py` ile işlenir, sahneye yerleştirilir, sahne önizlemesi (kamera ve saat tonu dahil) Erdem'e gösterilir, sonra commit'lenir.

## Süreci kolaylaştıran yöntemler

- **ChatGPT Projesi:** Proje talimatlarına Mesaj 0'ın metnini, proje dosyalarına üslup görselini ve onaylanmış karakter sayfalarını koy. Her bölüm o projede yeni bir sohbet olur; Mesaj 0'ı her seferinde yapıştırmak ve üslubun kayması azalır.
- **Karakter sayfası iliştirme:** Proje dosyası olması yetmez; görsel üretimi en çok mesaja iliştirilen görsele uyar. Mesaj dosyasında "Bu mesaja ekle" satırı hangi sayfaların ekleneceğini yazar.
- **Sırayla indirme, otomatik ad:** Dosya adlarını `gorsel_al.py` verir; indirme sırası bozulursa `--bas N` ile N. mesajdan başlatılır.
- **Erken denetim:** Her 3–4 görselde bir denetletmek, toplu üretip sonra bakmaktan çok daha az kota harcar.
- **Düzeltmeyi aynı sohbette iste:** Yeni sohbet açmak yerine "Regenerate this one: <tek kusur>. Keep everything else." En az değişiklikle en hızlı sonuç.
- **Uzun sohbet üslubu kaydırır:** 15–20 görselden sonra yeni sohbet aç (proje içinde talimatlar zaten hazır).
- **API ile doğrudan üretim (isteğe bağlı):** Claude Code'un bağlı olduğu Higgsfield ya da ElevenLabs görsel üretimi kredi harcar ama dosyayı doğrudan doğru adla alır, denetimi de anında yapar. Hız sınırı sorunu çözülürse elle indirme tamamen kalkar.
