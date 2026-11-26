"""App Store ekran görüntülerini üretir (6,3 inç iPhone).

Play görüntüleriyle aynı ham ekranlar ve başlıklar (`magaza_gorselleri.py`),
iPhone ölçüsünde:
  magaza/ekran-goruntuleri/app-store/tr|en/NN-ad.jpg
  1206×2622 (dikey) ya da 2622×1206 (yatay; App Store Connect'in istediği
  6,1"/6,3" ölçüsü, büyük ekranlara kendisi ölçekler); JPEG (alfa kanalı yok: App Store
  Connect alfa kanallı PNG'yi reddeder), 72 DPI, PNG'nin dörtte biri boyutunda.

Ham ekranlar Android emülatöründen: üstteki Android durum çubuğu (saat,
Wi-Fi, pil simgeleri) silinir; App Store başka platformun arayüzünü
gösteren görüntüleri reddedebilir.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/app_store_gorselleri.py
"""
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter

sys.path.insert(0, str(Path(__file__).resolve().parent))
from magaza_gorselleri import (  # noqa: E402
    ALTIN, CIKTI, HAM, KAGIT_ACIK, KINA, MUREKKEP, MUREKKEP_SOLUK, SIRALAR,
    ortala, parsomen, yazi, yuvarlat,
)

HEDEF = CIKTI / "app-store"
DIKEY, YATAY = (1206, 2622), (2622, 1206)  # çizim 1320×2868 tuvalde, sonra küçültülür
DURUM_CUBUGU = 120  # ham dikey ekranda Android durum çubuğunun yüksekliği (px)


def durum_cubugunu_sil(ham: Image.Image) -> Image.Image:
    """Durum çubuğunu, hemen altındaki satırın sütun sütun uzatılmasıyla örter
    (zemin parşömen ya da düz renk olduğundan iz kalmaz)."""
    satir = ham.crop((0, DURUM_CUBUGU, ham.width, DURUM_CUBUGU + 1))
    ham = ham.copy()
    ham.paste(satir.resize((ham.width, DURUM_CUBUGU)), (0, 0))
    return ham


def dikey(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    G, Y = 1320, 2868
    tuval = parsomen((G, Y))
    d = ImageDraw.Draw(tuval)
    y = ortala(d, baslik, 190, yazi(86), MUREKKEP, G, G - 170)
    d.line((G / 2 - 75, y + 18, G / 2 + 75, y + 18), fill=KINA, width=5)
    metin_alti = ortala(d, alt, y + 56, yazi(48, "egik"), MUREKKEP_SOLUK, G, G - 190)
    # Ekran: iPhone oranına (19,5:9) üstten kırpılır; kırpılan kısım silinmiş
    # durum çubuğunun boş payıdır.
    ham = durum_cubugunu_sil(ham)
    oran_y = round(ham.width * 2868 / 1320)
    ham = ham.crop((0, ham.height - oran_y, ham.width, ham.height))
    # Telefon metnin altından başlar; iki satırlık başlıkta biraz küçülür.
    ekran_y = min(2160, Y - 110 - 2 * 24 - (metin_alti + 90))
    ekran = ham.resize((round(ham.width * ekran_y / ham.height), ekran_y), Image.LANCZOS)
    cerceve = 24
    gw, gy = ekran.width + 2 * cerceve, ekran.height + 2 * cerceve
    x0, y0 = (G - gw) // 2, Y - gy - 110
    golge = Image.new("RGBA", (G, Y), (0, 0, 0, 0))
    ImageDraw.Draw(golge).rounded_rectangle((x0 + 12, y0 + 30, x0 + gw + 12, y0 + gy + 30), 120, fill=(40, 25, 10, 120))
    tuval = Image.alpha_composite(tuval.convert("RGBA"), golge.filter(ImageFilter.GaussianBlur(34)))
    ImageDraw.Draw(tuval).rounded_rectangle((x0, y0, x0 + gw, y0 + gy), 120, fill=(28, 24, 22, 255))
    tuval.alpha_composite(yuvarlat(ekran, 98), (x0 + cerceve, y0 + cerceve))
    return tuval.convert("RGB")


def yatay(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    # Oynatıcının 16:9 sahnesi (20:9 ham ekranın ortası), üst çubuk (geri,
    # başlık, bayrak) olmadan; alt denetimler ve altyazı kalır. Genişliğe
    # oturtulur, fazlası üstten (gökyüzü) kırpılır; başlık oraya gelir.
    G, Y = 2868, 1320
    ust = 130
    gen = round(ham.height * 16 / 9)
    sol = (ham.width - gen) // 2
    sahne = ham.crop((sol, ust, sol + gen, ham.height))
    sahne = sahne.resize((G, round(sahne.height * G / sahne.width)), Image.LANCZOS)
    sahne = sahne.crop((0, sahne.height - Y, G, sahne.height)).convert("RGBA")
    ort = Image.new("RGBA", sahne.size, (0, 0, 0, 0))
    od = ImageDraw.Draw(ort)
    for i in range(420):
        od.line((0, i, G, i), fill=(20, 14, 10, int(215 * (1 - i / 420) ** 1.6)))
    sahne = Image.alpha_composite(sahne, ort)
    d = ImageDraw.Draw(sahne)
    f, fa = yazi(92), yazi(48, "egik")
    w = d.textlength(baslik, font=f)
    d.text(((G - w) / 2, 80), baslik, font=f, fill=KAGIT_ACIK)
    d.line((G / 2 - 70, 218, G / 2 + 70, 218), fill=ALTIN, width=4)
    w = d.textlength(alt, font=fa)
    d.text(((G - w) / 2, 242), alt, font=fa, fill=(225, 205, 160))
    return sahne.convert("RGB")


def cerceveli_yatay(ham: Image.Image, baslik: str, alt: str) -> Image.Image:
    """Sahne olmayan yatay ekran (bölüm sonu): parşömen zemin, üstte başlık,
    altta bütün ekran çerçeve içinde."""
    G, Y = 2868, 1320
    tuval = parsomen((G, Y))
    d = ImageDraw.Draw(tuval)
    y = ortala(d, baslik, 60, yazi(80), MUREKKEP, G, G - 300)
    d.line((G / 2 - 70, y + 10, G / 2 + 70, y + 10), fill=KINA, width=5)
    ortala(d, alt, y + 32, yazi(42, "egik"), MUREKKEP_SOLUK, G, G - 300)
    ekran_y = 860
    ekran = ham.resize((round(ham.width * ekran_y / ham.height), ekran_y), Image.LANCZOS)
    cerceve = 20
    gw, gy = ekran.width + 2 * cerceve, ekran.height + 2 * cerceve
    x0, y0 = (G - gw) // 2, Y - gy - 60
    golge = Image.new("RGBA", (G, Y), (0, 0, 0, 0))
    ImageDraw.Draw(golge).rounded_rectangle((x0 + 10, y0 + 22, x0 + gw + 10, y0 + gy + 22), 90, fill=(40, 25, 10, 120))
    tuval = Image.alpha_composite(tuval.convert("RGBA"), golge.filter(ImageFilter.GaussianBlur(28)))
    ImageDraw.Draw(tuval).rounded_rectangle((x0, y0, x0 + gw, y0 + gy), 90, fill=(28, 24, 22, 255))
    tuval.alpha_composite(yuvarlat(ekran, 72), (x0 + cerceve, y0 + cerceve))
    return tuval.convert("RGB")


def main() -> int:
    for dil, liste in SIRALAR.items():
        klasor = HEDEF / dil
        klasor.mkdir(parents=True, exist_ok=True)
        for eski in [*klasor.glob("*.png"), *klasor.glob("*.jpg")]:
            eski.unlink()
        for ad, kaynak, baslik, alt in liste:
            ham = Image.open(HAM / f"{kaynak}.png").convert("RGB")
            if ham.height > ham.width:
                img = dikey(ham, baslik, alt)
            elif "bolum-sonu" in kaynak:
                img = cerceveli_yatay(ham, baslik, alt)
            else:
                img = yatay(ham, baslik, alt)
            img = img.resize(DIKEY if img.height > img.width else YATAY, Image.LANCZOS)
            assert img.mode == "RGB" and img.size in (DIKEY, YATAY), img.size
            img.save(klasor / f"{ad}.jpg", quality=93, optimize=True, dpi=(72, 72))
            print(f"app-store/{dil}/{ad}.jpg {img.size}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
