"""Üretilen görseli oynatıcı katmanına çevirir.

Kullanım (depo kökünden, projenin sanal ortamıyla):
  .venv\\Scripts\\python.exe -I tools/gorsel_katman.py <girdi> <cikti.webp> [--opak | --mavi] [--sigdir]

- Varsayılan: yeşil perde (#00B140) zemini silinir, kenarlar yumuşatılır ve
  konunun üzerine yansıyan yeşil temizlenir; şeffaf WebP yazılır.
- --mavi: mavi perde (#0047BB); konu yeşil içeriyorsa kullanılır.
- --opak: zemin silinmez (gök gibi tam dolu katmanlar).
- --sigdir: kırpmadan sığdırır, kalan yer şeffaf kalır. Kâbe gibi tek nesne
  katmanları için; oynatıcıda `ayar.gorsel` ile konumlanırlar.

Çıktı 1536×864 olur: 16:9 kadraj + her yönde %10 taşma (docs/GORSEL_USLUP.md).
Bu, üretilen 1536×1024 görselin kendi çözünürlüğüdür; eskiden 2304×1296'ya
büyütülüyordu, ayrıntı katmadan dosyayı büyüttüğü için bırakıldı (2026-11-25).
Görsel bu orana ortadan kırpılarak (cover) ölçeklenir. Çıktı yolu verilmezse
`content/gorseller/` altına yazılır.
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image

HEDEF = (1536, 864)

# Yeşillik = G − max(R, B). Bu eşiğin altı tamamen opak, üstü tamamen şeffaf;
# aradaki geçiş kenarları yumuşatır.
OPAK_ESIK = 40
SEFFAF_ESIK = 95  # ChatGPT perdesi bazen #00AF46 gibi koyu geliyor (fark ~105)


def kirp_olcekle(img: Image.Image) -> Image.Image:
    hg, hy = HEDEF
    oran = max(hg / img.width, hy / img.height)
    yeni = img.resize((round(img.width * oran), round(img.height * oran)), Image.LANCZOS)
    sol = (yeni.width - hg) // 2
    ust = (yeni.height - hy) // 2
    return yeni.crop((sol, ust, sol + hg, ust + hy))


def sigdir(img: Image.Image) -> Image.Image:
    """Perde silindikten sonra (RGBA) kırpmadan ortalar; taşan yer şeffaf."""
    hg, hy = HEDEF
    oran = min(hg / img.width, hy / img.height)
    yeni = img.resize((round(img.width * oran), round(img.height * oran)), Image.LANCZOS)
    tuval = Image.new("RGBA", HEDEF, (0, 0, 0, 0))
    tuval.paste(yeni, ((hg - yeni.width) // 2, (hy - yeni.height) // 2))
    return tuval


def perde_sil(img: Image.Image, perde: str = "yesil") -> Image.Image:
    """Yeşil perde varsayılandır. Konunun kendisi yeşil içeriyorsa (ör. s06'daki
    yeşil temel taşları) görsel mavi perdeyle (#0047BB) üretilir: --mavi."""
    a = np.asarray(img.convert("RGB")).astype(np.int16)
    r, g, b = a[..., 0], a[..., 1], a[..., 2]
    perde_kanal, diger1, diger2 = (b, r, g) if perde == "mavi" else (g, r, b)
    baskinlik = perde_kanal - np.maximum(diger1, diger2)
    alfa = 1 - np.clip((baskinlik - OPAK_ESIK) / (SEFFAF_ESIK - OPAK_ESIK), 0, 1)
    # Perde rengi yansımasını temizle (ortalama yöntemi): perde kanalı, diğer
    # ikisinin ortalamasını aşmasın. Kumla perdenin karıştığı kenar tonları
    # (ör. 152,154,72) baskınlık eşiğinin altında kalıp opak olduğundan, yalnız
    # büyüğüyle sınırlamak zeytin yeşili bir şerit bırakıyordu.
    # Sarılar (G yüksek ama R'nin altında) etkilenmesin diye yalnız perde kanalı
    # diğerlerine yetişen ya da onları geçen piksellerde uygulanır.
    temiz = np.where(baskinlik > -20, np.minimum(perde_kanal, (diger1 + diger2) // 2), perde_kanal)
    kanallar = [r, g, temiz] if perde == "mavi" else [r, temiz, b]
    rgba = np.dstack([*kanallar, (alfa * 255).round()]).clip(0, 255).astype(np.uint8)
    return Image.fromarray(rgba, "RGBA")


def main(argv: list[str]) -> int:
    opak = "--opak" in argv
    perde = "mavi" if "--mavi" in argv else "yesil"
    yollar = [a for a in argv if not a.startswith("--")]
    if not yollar:
        print(__doc__)
        return 2
    girdi = Path(yollar[0])
    cikti = Path(yollar[1]) if len(yollar) > 1 else Path("content/gorseller") / (girdi.stem + ".webp")
    if cikti.suffix.lower() != ".webp":
        print("Çıktı .webp olmalı.")
        return 2

    sigdirilsin = "--sigdir" in argv
    img = Image.open(girdi)
    if not sigdirilsin:
        img = kirp_olcekle(img)
    if opak:
        img = img.convert("RGB")
    else:
        img = perde_sil(img, perde)
        if sigdirilsin:
            img = sigdir(img)
        seffaf = (np.asarray(img)[..., 3] < 8).mean()
        if seffaf < 0.05:
            print(f"UYARI: görselin yalnız %{seffaf * 100:.0f}'i silindi; {perde} perde zemin yok gibi.")
    cikti.parent.mkdir(parents=True, exist_ok=True)
    img.save(cikti, "WEBP", quality=80, method=6)  # 1536×864 + kalite 80: 2304×1296 + 72'den ~%30 küçük, fark görünmüyor (2026-11-25)
    print(f"{cikti} ({img.width}×{img.height}, {'opak' if opak else 'şeffaf'}, {cikti.stat().st_size // 1024} KB)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
