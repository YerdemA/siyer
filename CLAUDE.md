# Resulü Ekrem'in Hayatı

Hz. Muhammed'in (s.a.v.) hayatını bölümler halinde, hareketli illüstrasyon ve anlatıcı sesiyle anlatan ücretsiz mobil uygulama. Tek geliştirici: Erdem (GitHub: YerdemA). Ayrıntılar `docs/` altında; bu dosya her oturumda geçerli kuralları içerir.

## Değişmez kurallar (içerik)

Bu kurallar teknik tercihlerden önce gelir. Emin olmadığında dur ve Erdem'e sor.

1. **Kaynaksız cümle yok.** Uygulamaya giren her tarihî bilgi `iddialar` kaydına bağlıdır ve her iddianın en az bir kaynağı vardır (eser + cilt/sayfa ya da hadis numarası). Ayrıntı: `docs/KAYNAK_POLITIKASI.md`.
2. **Atıf uydurma.** Kendi bilginden cilt, sayfa, hadis numarası ya da alıntı YAZMA. Atıfı yalnızca `notebook` MCP sunucusundan (Gemini Notebook / NotebookLM not defteri) ya da `kaynaklar/` klasöründeki dosyadan okuyarak al. Bulamadıysan `"dogrulama": "bekliyor"` yaz ve konumu boş bırak.
3. **Doğrulamayı sen işaretleme.** `"dogrulama": "dogrulandi"` değerini yalnızca Erdem, kaynağı kendi gözüyle gördükten sonra yazar.
4. **Rivayet farkları.** En güçlü rivayet ana metne girer; diğerleri `alternatifRivayetler` içinde dipnot olur. Hangisinin güçlü olduğuna kaynakların kendi değerlendirmesine göre karar ver, gerekçeyi kayda yaz.
5. **Temsil.** Hz. Muhammed (s.a.v.) iki biçimde gösterilir: sahne onun gözünden görülür ya da asaleti belli eden bir boyda, baştan ayağa nurla kaplı, başında yeşil sarıkla (sarık peygamberlikten sonraki bölümlerde; öncesinde sarıksız nur, Erdem 2026-11-18); yüz ve beden ayrıntısı yok. Diğer peygamberler hiç figür olarak çizilmez, yalnız nur. Eşleri, öz çocukları, anne-babası ve süt annesi Halîme yüz gösterilmeden (siluet, arkadan, uzak plan) anlatılır. Evlatlığı Zeyd b. Hârise yüzüyle çizilebilir (Erdem 2026-11-20). Hz. Hâcer ve süt annesi Süveybe de yüzsüz (siluet) gösterilir (Erdem 2026-11-20). Diğer herkes (sahabe, Abdülmuttalib, Ebû Tâlib, halk) rivayet ve kaynaklardaki betimlemeye uygun, yüzüyle çizilebilir. Ayrıntı: `docs/GORSEL_USLUP.md`.
6. **Ses.** Hz. Peygamber'in sözleri için karakter sesi yok; yalnızca anlatıcı aktarır. Uydurma diyalog yazma; söz aktarılacaksa rivayetteki haliyle ve kaynağıyla.
7. **Üslup.** Saygılı, sade, her yaşa uygun; çocuksu ya da vaaz tonunda değil. İlk anışta "Hz. Muhammed (s.a.v.)", sonrasında "Efendimiz" ya da "Resûlullah". Yorum ve hüküm katma; kaynak ne diyorsa o.
8. **Telif.** Kaynak metinlerini kopyalama; kendi cümlelerinle anlat, atıf ver. `kaynaklar/` klasörü git'e girmez.

## Ürün kararları

- Hedef kitle: her yaş. Dil: önce Türkçe, sonra İngilizce; tüm metinler baştan dil dosyalarında.
- MVP: peygamberlik öncesi dönem, 10 bölüm (`docs/BOLUM_HARITASI.md`).
- Özellikler: bölüm oynatıcı, bölüm sonu kaynak listesi, Ayarlar'da tam kaynakça, harita, zaman çizelgesi, şahıslar sözlüğü, ilerleme takibi.
- Hesap yok, sunucu yok, reklam yok, analitik yok. İlerleme cihazda saklanır.
- Bölümler tek tek indirilir ve çevrimdışı çalışır.
- Ücretsiz; yalnızca isteğe bağlı bağış bağlantısı (MVP'de yok, sonraki sürümlerde).

## Teknik yön

- **Flutter** (stable), önce Android; iOS'u bozacak platforma özel kod yazma.
- İçerik koddan ayrıdır: `content/<dil>/...` altında JSON. Şema: `docs/ICERIK_SEMASI.md`.
- Bölümler video dosyası değil, uygulama içinde oynatılan sahnelerdir: katmanlı görseller (WebP) + JSON zaman çizelgesi + dil başına anlatım sesi. Böylece yeni dil yalnızca ses ve metin ekler. (Pilot bölümde doğrulanacak; sorun çıkarsa videoya dönülür.)
- Paketler (Erdem onayladı): `flutter_riverpod`, `go_router`, `just_audio`, `shared_preferences`, `flutter_localizations` + `intl`. Harita gerçek harita değil, parşömen illüstrasyonu üzerinde yaklaşık konumlar; harita paketi kullanılmaz.
- Kararsız kalınan mimari tercihlerde en basit çözümü seç; tek kişilik proje.

## Klasör yapısı

```
app/                 Flutter projesi
content/tr/          bolumler/, sahislar.json, yerler.json, zaman-cizelgesi.json, kaynakca.json
docs/                politika, şema, üslup, kaynak listesi
tools/               içerik doğrulama betikleri
kaynaklar/           indirilen PDF'ler (git'e girmez)
```

## Komutlar

```
cd app && flutter pub get
cd app && flutter analyze
cd app && flutter test
dart run tools/icerik_dogrula.dart      # şema + kaynak kontrolü (yazılacak)
python tools/bolum_metni.py             # docs/BOLUM_METINLERI.md kontrol nüshası (içerik değişince)
python tools/gorsel_yardimci.py         # elle ChatGPT üretimi: istem/ek kopyalama, indirileni yeni\<kimlik>.png yapar
```

İçerik değiştiren her işten sonra doğrulama betiğini çalıştır. Yayın derlemesi, `dogrulama` değeri `dogrulandi` olmayan iddia varsa başarısız olmalı.

## Çalışma düzeni

- Oturuma başlarken önce `DURUM.md`'yi oku (son yapılanlar, sıradaki adımlar), genel plan için `YOL_HARITASI.md`'ye bak; oturum sonunda ikisini de güncelle.

- Bölüm yazarken `/bolum-yaz <bölüm no>` komutunu, atıf kontrolü için `kaynak-denetcisi` alt ajanını kullan.
- Not defterine soru sorarken eser adını ve konumu açıkça iste; cevaptaki atıfı kayda aynen geçir. Kota sınırlı olduğu için soruları tek tek değil toplu sor.
- Açık erişimli kaynakları indirmek için `scrapling` MCP sunucusunu ya da `.venv\Scripts\scrapling.exe` komutunu kullan (`docs/SCRAPLING_KURULUM.md`). Yalnızca `docs/KAYNAKLAR.md` A listesi; indirilen `kaynaklar/` altına kaydedilir. Web'den çekilen sayfa tek başına atıf kaynağı değildir, kural 2 aynen geçerli.
- Not defteri erişilemezse içerik yazmayı bırak, durumu bildir; kod işlerine devam edebilirsin.
- Commit mesajları Türkçe, kısa, emir kipinde. İçerik ve kod değişikliklerini ayrı commit'le.
- Erdem'le Türkçe konuş.
