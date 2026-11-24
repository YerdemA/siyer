"""b04-s07 göz dizisi: üç çocuğun yüz yakın planını (yeşil perde) tek geniş görselde birleştirir.

Erdem'in fikri (2026-11-25): yüzler çayırda yan yana; kamera gözden göze, yüzden yüze
hiçbir efekt olmadan sağa kayar.

- Yeşil perde yalnız görselin kenarına bağlı yeşil bölgede silinir (yansımalardaki çimen
  ve gök korunur); kenar 1,5 px yumuşatılır, yeşil yansıması temizlenir.
- Her yüz 16:9 banda kırpılır (üstten 80 px), göz aralığı A'nınkine (631 px) eşitlenir,
  göz hizası aynı yüksekliğe getirilir.
- Yüz merkezleri ARALIK px arayla dizilir; arkada yamaç görselinin bulanık, aynalı kopyası.

Çıktılar (content/gorseller/):
- b04-d-yuzler.webp: birleşik görsel (yükseklik 864 = kadraj yüksekliği).
- b04-d-yuz-a-gecis.webp: birleşik görselin ilk 1536 px'i, kenarları %4 yumuşak saydam;
  önden görselden A'nın gözlerine yaklaşırken yama olarak kullanılır.
Ölçüler ve yerleşim sabitleri tools/goz_dizisi.py tarafından buradan okunur.

Kullanım: .venv\\Scripts\\python.exe -I tools/yuz_birlestir.py
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter

KOK = Path(__file__).resolve().parent.parent
YENI = Path.home() / "Downloads/siyer/arsiv/b04"
GORSEL = KOK / "content/gorseller"

# Yansıma dairelerinin merkezleri (özgün 1536×1024 piksel; görselle ölçüldü).
GOZLER = {
    "a": ((451, 603), (1082, 603)),
    "b": ((451, 600), (1057, 600)),
    "c": ((450, 600), (1057, 600)),
}
ARALIK = 1640          # yüz merkezleri arası (px); başlar üst üste binmesin, arada çayır görünsün
YUK = 864              # 16:9 bant yüksekliği
GEN = 1536
GOZ_Y = 523            # birleşik görselde göz hizası


def perdeyi_sil(img: Image.Image) -> Image.Image:
    a = np.asarray(img.convert("RGB")).astype(np.int16)
    yesil = (a[..., 1] - np.maximum(a[..., 0], a[..., 2])) > 60
    # copy(): fromarray numpy belleğini paylaşır, floodfill ona yazamaz.
    m = Image.fromarray((yesil * 255).astype(np.uint8)).copy()
    # Kenara bağlı yeşil bölgeyi 128 ile doldur.
    w, h = m.size
    for x, y in [(0, 0), (w - 1, 0), (0, h - 1), (w - 1, h - 1)] + [(x, 0) for x in range(0, w, 64)] + \
            [(x, h - 1) for x in range(0, w, 64)] + [(0, y) for y in range(0, h, 64)] + [(w - 1, y) for y in range(0, h, 64)]:
        if m.getpixel((x, y)) == 255:
            ImageDraw.floodfill(m, (x, y), 128)
    arka = np.asarray(m) == 128
    alfa = Image.fromarray(np.where(arka, 0, 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(1.5))
    rgb = a.copy()
    # Kenardaki yeşil yansımayı temizle: G, max(R, B)'yi geçmesin.
    kenar = (np.asarray(alfa) < 250) & (np.asarray(alfa) > 0)
    rgb[..., 1] = np.where(kenar, np.minimum(rgb[..., 1], np.maximum(rgb[..., 0], rgb[..., 2])), rgb[..., 1])
    out = Image.fromarray(rgb.clip(0, 255).astype(np.uint8)).convert("RGBA")
    out.putalpha(alfa)
    return out


def main() -> int:
    hedef_aralik = GOZLER["a"][1][0] - GOZLER["a"][0][0]
    W = GEN + 2 * ARALIK
    # Arka plan: yamaç görselinin aynalı üç kopyası, bulanık.
    oyun = Image.open(GORSEL / "b04-d-oyun.webp").convert("RGB")
    oyun = oyun.resize((round(oyun.width * YUK / oyun.height), YUK), Image.LANCZOS)
    arka = Image.new("RGB", (W, YUK))
    x = 0
    ters = False
    while x < W:
        arka.paste(oyun.transpose(Image.FLIP_LEFT_RIGHT) if ters else oyun, (x, 0))
        x += oyun.width
        ters = not ters
    arka = arka.filter(ImageFilter.GaussianBlur(18)).convert("RGBA")

    for i, c in enumerate("abc"):
        img = perdeyi_sil(Image.open(YENI / f"b04-d-yuz-{c}.png"))
        (lx, ly), (rx, ry) = GOZLER[c]
        o = hedef_aralik / (rx - lx)
        img = img.resize((round(img.width * o), round(img.height * o)), Image.LANCZOS)
        ox, oy = (lx + rx) / 2 * o, (ly + ry) / 2 * o            # göz ortası, ölçeklenmiş görselde
        merkez = GEN / 2 + i * ARALIK                               # birleşik görselde yüz merkezi
        sol, ust = round(merkez - ox), round(GOZ_Y - oy)
        arka.alpha_composite(img, (max(sol, 0), max(ust, 0)), (max(-sol, 0), max(-ust, 0)))
        print(f"{c}: ölçek {o:.3f}, yüz merkezi {merkez:.0f}")
    birlesik = arka.convert("RGB")
    birlesik.save(GORSEL / "b04-d-yuzler.webp", "WEBP", quality=90, method=6)

    # Geçiş yaması: ilk 1536 px, kenarları %4 yumuşak saydam.
    yama = np.asarray(birlesik.crop((0, 0, GEN, YUK)).convert("RGBA")).astype(np.float32)
    b = 0.04
    fx = np.clip(np.minimum(np.linspace(0, 1, GEN), 1 - np.linspace(0, 1, GEN)) / b, 0, 1)
    fy = np.clip(np.minimum(np.linspace(0, 1, YUK), 1 - np.linspace(0, 1, YUK)) / b, 0, 1)
    f = np.outer(fy, fx)
    yama[..., 3] *= f * f * (3 - 2 * f)
    Image.fromarray(yama.astype(np.uint8)).save(GORSEL / "b04-d-yuz-a-gecis.webp", "WEBP", quality=90, method=6)
    print(f"birleşik {W}×{YUK}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
