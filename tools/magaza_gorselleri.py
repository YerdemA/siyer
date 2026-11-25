"""Play Store görsellerini üretir: başlıklı ekran görüntüleri ve öne çıkan grafik.

Girdi: emülatörden alınmış ham ekran görüntüleri
(`magaza/ekran-goruntuleri/ham/`, 1080×2400 dikey ya da 2400×1080 yatay).
Çıktı:
  magaza/ekran-goruntuleri/tr|en/NN-ad.png   1080×1920 (dikey) ya da 1920×1080 (yatay)
  magaza/one-cikan-grafik.png, magaza/one-cikan-grafik-en.png   1024×500

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/magaza_gorselleri.py
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

sys.path.insert(0, str(Path(__file__).resolve().parent))
import kart_kapagi  # noqa: E402

KOK = Path(__file__).resolve().parent.parent
HAM = KOK / "magaza" / "ekran-goruntuleri" / "ham"
CIKTI = KOK / "magaza" / "ekran-goruntuleri"
FONT = Path("C:/Windows/Fonts")

KAGIT = (230, 211, 168)
KAGIT_ACIK = (243, 232, 207)
KAGIT_KOYU = (213, 190, 142)
MUREKKEP = (59, 39, 22)
MUREKKEP_SOLUK = (110, 82, 54)
KINA = (156, 59, 34)
ALTIN = (194, 145, 63)
GECE = (22, 26, 42)


def yazi(boy: int, tur: str = "kalin") -> ImageFont.FreeTypeFont:
    dosya = {"kalin": "georgiab.ttf", "egik": "georgiai.ttf", "duz": "georgia.ttf"}[tur]
    return ImageFont.truetype(str(FONT / dosya), boy)


# (dosya adı, ham görüntü, başlık, alt satır)
SIRALAR = {
    "tr": [
        ("01-bolumler", "tr-ana", "Siyer, bölüm bölüm", "Peygamberlik öncesi dönem: 10 bölüm, 135 sahne"),
        ("02-sahne-fil", "tr-oynatici-fil", "Canlanan sahneler, anlatıcı sesi", "Fil Vakası"),
        ("03-sahne-hira", "tr-oynatici-hira-magara", "Hira'nın eşiğinde", "Yaklaşık 42 dakikalık anlatım, Türkçe ve İngilizce altyazı"),
        ("04-donem", "tr-donem", "Peygamberlik dönemi yolda", "Yeni bölümler hazırlanıyor"),
        ("05-kaynaklar", "tr-bolum-sonu", "Her bilginin kaynağı açık", "Bölüm sonunda eser ve sayfasıyla kaynak listesi"),
        ("06-harita", "tr-harita", "Mekke'den Şam'a harita", "Sahne yer değiştirince harita yolu gösterir"),
        ("07-zaman", "tr-zaman", "Olaylar yıl yıl", "Zaman çizelgesi, her olay kaynağıyla"),
        ("08-sahislar", "tr-sahis-abdulmuttalib", "50 şahıs, kaynaklarıyla", "İzledikçe açılan şahıslar sözlüğü"),
    ],
    "en": [
        ("01-episodes", "en-ana", "The Prophet's life, episode by episode", "Before prophethood: 10 episodes, 135 scenes"),
        ("02-scene-elephant", "en-oynatici-fil", "Animated scenes, narrated", "The Year of the Elephant · English subtitles"),
        ("03-scene-birds", "en-oynatici-kuslar", "Told as the sources tell it", "Every sentence is linked to a source"),
        ("04-scene-market", "en-oynatici-pazar", "Mecca before Islam", "About 42 minutes of narration"),
        ("05-prophethood", "en-donem", "The Prophethood is on its way", "New episodes are being prepared"),
        ("06-map", "en-harita", "A map from Mecca to Damascus", "The map shows the journey when the scene moves"),
        ("07-people", "en-sahis", "50 people, with sources", "A glossary that grows as you watch"),
    ],
}


def parsomen(boyut: tuple[int, int]) -> Image.Image:
    """Uygulamanın zemini gibi: parşömen, hafif lekeler, kenarlarda kararma."""
    import random

    g, y = boyut
    zemin = Image.new("RGB", boyut, KAGIT)
    leke = Image.new("RGBA", boyut, (0, 0, 0, 0))
    d = ImageDraw.Draw(leke)
    r = random.Random(605)
    for _ in range(14):
        cx, cy, rr = r.random() * g, r.random() * y, g * (0.08 + r.random() * 0.2)
        d.ellipse((cx - rr, cy - rr, cx + rr, cy + rr), fill=(120, 80, 40, 10 + r.randint(0, 14)))
    leke = leke.filter(ImageFilter.GaussianBlur(60))
    zemin = Image.alpha_composite(zemin.convert("RGBA"), leke)
    # Kenar kararması
    kenar = Image.new("L", boyut, 0)
    kd = ImageDraw.Draw(kenar)
    for i in range(60):
        a = int(70 * (1 - i / 60) ** 2)
        kd.rectangle((i * 3, i * 3, g - i * 3, y - i * 3), outline=a, width=3)
    kenar = kenar.filter(ImageFilter.GaussianBlur(30))
    koyu = Image.new("RGBA", boyut, MUREKKEP + (255,))
    koyu.putalpha(kenar)
    return Image.alpha_composite(zemin, koyu).convert("RGB")


def ortala(d: ImageDraw.ImageDraw, metin: str, y: int, f, renk, genislik: int, azami: int) -> int:
    """Satırı ortalar; sığmazsa iki satıra böler. Son satırın altını döner."""
    satirlar = [metin]
    if d.textlength(metin, font=f) > azami:
        kelimeler = metin.split()
        en_iyi = None
        for i in range(1, len(kelimeler)):
            a, b = " ".join(kelimeler[:i]), " ".join(kelimeler[i:])
            fark = max(d.textlength(a, font=f), d.textlength(b, font=f))
            if en_iyi is None or fark < en_iyi[0]:
                en_iyi = (fark, [a, b])
        satirlar = en_iyi[1]
    for s in satirlar:
        w = d.textlength(s, font=f)
        d.text(((genislik - w) / 2, y), s, font=f, fill=renk)
        y += int(f.size * 1.25)
    return y


def yuvarlat(img: Image.Image, r: int) -> Image.Image:
    maske = Image.new("L", img.size, 0)
    ImageDraw.Draw(maske).rounded_rectangle((0, 0, *img.size), r, fill=255)
    sonuc = img.convert("RGBA")
    sonuc.putalpha(maske)
    return sonuc


def dikey(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    G, Y = 1080, 1920
    tuval = parsomen((G, Y))
    d = ImageDraw.Draw(tuval)
    y = ortala(d, baslik, 110, yazi(68), MUREKKEP, G, G - 140)
    # Kına çizgi
    d.line(((G / 2 - 60), y + 14, (G / 2 + 60), y + 14), fill=KINA, width=4)
    ortala(d, alt, y + 44, yazi(38, "egik"), MUREKKEP_SOLUK, G, G - 160)
    # Telefon: ekran görüntüsü yuvarlak köşeli, koyu çerçeveli, gölgeli.
    ekran_y = 1360
    ekran = ham.resize((round(ham.width * ekran_y / ham.height), ekran_y), Image.LANCZOS)
    cerceve = 18
    gw, gy = ekran.width + 2 * cerceve, ekran.height + 2 * cerceve
    x0, y0 = (G - gw) // 2, Y - gy - 70
    golge = Image.new("RGBA", (G, Y), (0, 0, 0, 0))
    ImageDraw.Draw(golge).rounded_rectangle((x0 + 10, y0 + 24, x0 + gw + 10, y0 + gy + 24), 70, fill=(40, 25, 10, 120))
    golge = golge.filter(ImageFilter.GaussianBlur(28))
    tuval = Image.alpha_composite(tuval.convert("RGBA"), golge)
    d = ImageDraw.Draw(tuval)
    d.rounded_rectangle((x0, y0, x0 + gw, y0 + gy), 70, fill=(28, 24, 22, 255))
    tuval.alpha_composite(yuvarlat(ekran, 54), (x0 + cerceve, y0 + cerceve))
    return tuval.convert("RGB")


def yatay(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    # Oynatıcı 16:9; 20:9 ekranda iki yanı siyah. Üst çubuk (geri, başlık,
    # bayrak) kesilir, başlık onun yerine gelir; kalan ortadan 16:9 alınır.
    ust = 130
    yuk = ham.height - ust
    gen = round(yuk * 16 / 9)
    sol = (ham.width - gen) // 2
    sahne = ham.crop((sol, ust, sol + gen, ham.height)).resize((1920, 1080), Image.LANCZOS).convert("RGBA")
    # Üstte, başlığın okunacağı koyu bir geçiş.
    ort = Image.new("RGBA", sahne.size, (0, 0, 0, 0))
    od = ImageDraw.Draw(ort)
    for i in range(330):
        od.line((0, i, 1920, i), fill=(20, 14, 10, int(215 * (1 - i / 330) ** 1.6)))
    sahne = Image.alpha_composite(sahne, ort)
    d = ImageDraw.Draw(sahne)
    f, fa = yazi(64), yazi(34, "egik")
    w = d.textlength(baslik, font=f)
    d.text(((1920 - w) / 2, 70), baslik, font=f, fill=KAGIT_ACIK)
    d.line((960 - 50, 168, 960 + 50, 168), fill=ALTIN, width=3)
    w = d.textlength(alt, font=fa)
    d.text(((1920 - w) / 2, 186), alt, font=fa, fill=(225, 205, 160))
    return sahne.convert("RGB")


def cerceveli_yatay(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    """Sahne olmayan yatay ekranlar (bölüm sonu): parşömen zemin, üstte başlık,
    altta bütün ekran çerçeve içinde."""
    G, Y = 1920, 1080
    tuval = parsomen((G, Y))
    d = ImageDraw.Draw(tuval)
    y = ortala(d, baslik, 56, yazi(64), MUREKKEP, G, G - 200)
    d.line((G / 2 - 60, y + 10, G / 2 + 60, y + 10), fill=KINA, width=4)
    ortala(d, alt, y + 30, yazi(34, "egik"), MUREKKEP_SOLUK, G, G - 200)
    # 20:9 ekranın iki yanındaki siyah pay atılır (içerik ortadaki 16:9'da).
    gen = round(ham.height * 16 / 9)
    ham = ham.crop(((ham.width - gen) // 2, 0, (ham.width + gen) // 2, ham.height))
    ekran = ham.resize((1440, round(ham.height * 1440 / ham.width)), Image.LANCZOS)
    cerceve = 14
    gw, gy = ekran.width + 2 * cerceve, ekran.height + 2 * cerceve
    x0, y0 = (G - gw) // 2, Y - gy - 50
    golge = Image.new("RGBA", (G, Y), (0, 0, 0, 0))
    ImageDraw.Draw(golge).rounded_rectangle((x0 + 10, y0 + 20, x0 + gw + 10, y0 + gy + 20), 50, fill=(40, 25, 10, 120))
    tuval = Image.alpha_composite(tuval.convert("RGBA"), golge.filter(ImageFilter.GaussianBlur(24)))
    ImageDraw.Draw(tuval).rounded_rectangle((x0, y0, x0 + gw, y0 + gy), 50, fill=(28, 24, 22, 255))
    tuval.alpha_composite(yuvarlat(ekran, 38), (x0 + cerceve, y0 + cerceve))
    return tuval.convert("RGB")


def one_cikan(dil: str) -> Image.Image:
    """1024×500: akşam ışığında yükselen Kâbe; solda ad ve alt satır."""
    tam = kart_kapagi.birlestir(kart_kapagi.sahne_bul("b10-s01"))  # 1536×864
    olcek = 1024 / 1536 * 1.6
    tam = tam.resize((round(1536 * olcek), round(864 * olcek)), Image.LANCZOS)
    x = round(tam.width * 0.5 - 1024 * 0.76)
    y = round(tam.height * 0.5 - 250 + 10)
    img = tam.crop((x, y, x + 1024, y + 500)).convert("RGBA")
    ort = Image.new("RGBA", img.size, (0, 0, 0, 0))
    od = ImageDraw.Draw(ort)
    for i in range(640):
        od.line((i, 0, i, 500), fill=(24, 16, 12, int(205 * max(0, 1 - i / 640) ** 1.3)))
    img = Image.alpha_composite(img, ort)
    muhur = Image.open(KOK / "magaza" / "simge-512.png").convert("RGBA").resize((80, 80), Image.LANCZOS)
    img.alpha_composite(yuvarlat(muhur, 18), (56, 104))
    d = ImageDraw.Draw(img)
    if dil == "tr":
        satirlar, alt, ek = ["Resulü Ekrem'in", "Hayatı"], "Peygamberlik öncesi · 10 bölüm", "Kaynaklı · Sesli anlatım · Reklamsız"
    else:
        satirlar, alt, ek = ["The Life of", "the Prophet"], "Before prophethood · 10 episodes", "Sourced · Narrated · No ads"
    yy = 206
    for s in satirlar:
        d.text((56, yy), s, font=yazi(52), fill=KAGIT_ACIK)
        yy += 62
    d.line((58, yy + 14, 150, yy + 14), fill=ALTIN, width=3)
    d.text((56, yy + 30), alt, font=yazi(26, "egik"), fill=(232, 210, 165))
    d.text((56, yy + 70), ek, font=yazi(20, "duz"), fill=(210, 190, 150))
    return img.convert("RGB")


def main() -> int:
    for dil, liste in SIRALAR.items():
        klasor = CIKTI / dil
        klasor.mkdir(parents=True, exist_ok=True)
        for eski in klasor.glob("*.png"):
            eski.unlink()
        for ad, kaynak, baslik, alt in liste:
            ham = Image.open(HAM / f"{kaynak}.png").convert("RGB")
            if ham.height > ham.width:
                img = dikey(ham, baslik, alt)
            elif "bolum-sonu" in kaynak:
                img = cerceveli_yatay(ham, baslik, alt)
            else:
                img = yatay(ham, baslik, alt)
            img.save(klasor / f"{ad}.png", optimize=True)
            print(f"{dil}/{ad}.png {img.size}")
    one_cikan("tr").save(KOK / "magaza" / "one-cikan-grafik.png", optimize=True)
    one_cikan("en").save(KOK / "magaza" / "one-cikan-grafik-en.png", optimize=True)
    print("öne çıkan grafikler yazıldı")
    return 0


if __name__ == "__main__":
    sys.exit(main())
