---
description: Bir bölümün kaynaklı taslağını yazar (ör. /bolum-yaz 9)
argument-hint: <bölüm no>
---

Bölüm $ARGUMENTS için taslak hazırla. Sırayı bozma; her adımın sonunda kısa bir özet ver.

1. **Hazırlık.** `docs/BOLUM_HARITASI.md`, `docs/KAYNAK_POLITIKASI.md`, `docs/ICERIK_SEMASI.md`, `docs/GORSEL_USLUP.md` dosyalarını oku. `content/tr/bolumler/_ornek.json` biçimini esas al.

2. **Kaynak taraması.** `notebook` MCP sunucusuyla not defterine bölümün konusunu sor. Soruları toplu sor (kota sınırlı): olayın akışı, tarihler ve yaşlar, kişiler, yerler, kaynaklar arasındaki farklar, zayıf bulunan rivayetler. Her bilgi için eser ve konum iste. MCP erişilemiyorsa dur ve bildir.

3. **İddia listesi.** Anlatım yazmadan önce bölümün `iddialar` listesini çıkar: ifade, güç, gerekçe, kaynaklar, alternatif rivayetler. Atıfı not defterinin gösterdiği haliyle yaz; göstermediyse `konum` boş kalsın. Tüm kaynaklar `dogrulama: "bekliyor"` olur. Listeyi Erdem'e göster ve onay bekle.

4. **Sahneler.** Onaydan sonra 8–15 sahne yaz. Her anlatım parçası iddialarına bağlı olsun. İddia listesinde olmayan tarihî ayrıntı ekleme; gerekiyorsa 3. adıma dön. Görsel tariflerinde temsil kurallarına uy.

5. **Yan veriler.** Bölümde geçen şahıs, yer ve zaman çizelgesi kayıtlarını ilgili dosyalara ekle ya da güncelle.

6. **Denetim.** `kaynak-denetcisi` alt ajanını bölüm dosyası üzerinde çalıştır, bulduğu sorunları düzelt, `dart run tools/icerik_dogrula.dart` çalıştır.

7. **Teslim.** Erdem'e şunları ver: bölüm özeti, elle doğrulaması gereken atıfların listesi (eser + konum), kararsız kaldığın noktalar. Bölümün `durum` alanı `taslak` kalır.
