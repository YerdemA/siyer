"""Ana sayfadaki bölüm kartlarının kapak şeritlerini üretir.

Her bölüm için seçilmiş bir sahnenin katmanları oynatıcıdaki gibi üst üste
konur (kadraj + %10 taşma ya da `ayar.gorsel` yerleşimi, saat tonu), sahnenin
seçilen yüksekliğinden 4:1'lik bir şerit kesilir ve küçük bir WebP yazılır:
`app/assets/kartlar/<bölüm>.webp`. Kapaklar uygulamaya gömülüdür (bölüm
paketi inmeden de görünsün diye); hepsi birlikte ~200 KB.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/kart_kapagi.py [b03 ...] [--onizleme]

--onizleme: ayrıca bütün kapakları alt alta dizen bir JPEG yazar
(`app/build/kart_kapaklari.jpg`).
"""
import json
import sys
from pathlib import Path

import numpy as np
from PIL import Image

KOK = Path(__file__).resolve().parent.parent
GORSEL = KOK / "content" / "gorseller"
BOLUMLER = KOK / "content" / "tr" / "bolumler"
CIKTI = KOK / "app" / "assets" / "kartlar"

KADRAJ = (1536, 864)
TASMA = 0.1
SERIT = (1000, 250)

# Bölüm → (sahne, şeridin dikey ortası 0–1). Sahneler insan yüzü öne
# çıkmayan, bölümü tek bakışta anlatan yerlerden seçildi.
SECIM = {
    "b01": ("b01-s05", 0.55),  # akşam, vadide alçak, üstü açık Kâbe
    "b02": ("b02-s12", 0.6),  # şafakta çökmüş fil
    "b03": ("b03-s10", 0.5),  # doğumun olduğu ev
    "b04": ("b04-s05", 0.6),  # Sa'doğulları yurdunda koyun sürüsü
    "b05": ("b05-s04", 0.6),  # Ebvâ'da ıssız konak
    "b06": ("b06-s08", 0.6),  # Şam yolunda kervan
    "b07": ("b07-s01", 0.55),  # Ukâz panayırı
    "b08": ("b08-s02", 0.55),  # Hz. Hatice'nin ticaret avlusu
    "b09": ("b09-s14", 0.5),  # yeniden yükselen Kâbe
    "b10": ("b10-s09", 0.45),  # Hira dağı
}

# sahne_cizici.dart → saatTonu ile aynı katsayılar (R, G, B satırları).
TONLAR = {
    "safak": [[1.0, 0, 0, 8], [0, 0.88, 0, 2], [0, 0, 0.80, 6]],
    "aksam": [[0.92, 0, 0, 6], [0, 0.78, 0, 2], [0, 0, 0.72, 8]],
}
GECE = [[0.26, 0.117, 0.023, 4], [0.07, 0.373, 0.027, 6], [0.099, 0.194, 0.368, 16]]


def sahne_bul(sahne_id: str) -> dict:
    for f in sorted(BOLUMLER.glob("b*.json")):
        for s in json.loads(f.read_text(encoding="utf-8"))["sahneler"]:
            if s["id"] == sahne_id:
                return s
    raise SystemExit(f"Sahne yok: {sahne_id}")


def tonla(img: Image.Image, saat: str, katman: dict) -> Image.Image:
    ton = katman.get("ayar", {}).get("ton")
    if katman.get("yerTutucu") == "gok" or ton is False:
        return img
    m = GECE if saat == "gece" and ton == "gece" else TONLAR.get(saat)
    if m is None:
        return img
    a = np.asarray(img).astype(np.float32)
    rgb = a[..., :3]
    yeni = np.stack([rgb @ np.array(r[:3], np.float32) + r[3] for r in m], axis=-1)
    a[..., :3] = yeni.clip(0, 255)
    return Image.fromarray(a.astype(np.uint8), "RGBA")


def birlestir(sahne: dict) -> Image.Image:
    g = sahne["gorsel"]
    gw, gh = KADRAJ
    tuval = Image.new("RGBA", KADRAJ, (0, 0, 0, 255))
    for k in g["katmanlar"]:
        if not k.get("dosya"):
            continue
        img = tonla(Image.open(GORSEL / k["dosya"]).convert("RGBA"), g.get("saat", ""), k)
        yer = k.get("ayar", {}).get("gorsel")
        if yer is None:
            sol, ust = -TASMA * gw, -TASMA * gh
            gen, yuk = (1 + 2 * TASMA) * gw, (1 + 2 * TASMA) * gh
        else:
            gen = yer["olcek"] * gw
            yuk = gen * img.height / img.width
            sol, ust = yer["x"] * gw - gen / 2, yer["y"] * gh - yuk / 2
        img = img.resize((max(1, round(gen)), max(1, round(yuk))), Image.LANCZOS)
        katman = Image.new("RGBA", KADRAJ, (0, 0, 0, 0))
        katman.paste(img, (round(sol), round(ust)))
        tuval = Image.alpha_composite(tuval, katman)
    return tuval.convert("RGB")


def kapak(bolum: str) -> Image.Image:
    sahne_id, orta = SECIM[bolum]
    tam = birlestir(sahne_bul(sahne_id))
    gw, gh = KADRAJ
    yuk = gw * SERIT[1] / SERIT[0]
    ust = min(max(orta * gh - yuk / 2, 0), gh - yuk)
    return tam.crop((0, round(ust), gw, round(ust + yuk))).resize(SERIT, Image.LANCZOS)


def main(argv: list[str]) -> int:
    secilen = [a for a in argv if not a.startswith("--")] or list(SECIM)
    CIKTI.mkdir(parents=True, exist_ok=True)
    kapaklar = []
    for b in secilen:
        img = kapak(b)
        yol = CIKTI / f"{b}.webp"
        img.save(yol, "WEBP", quality=80, method=6)
        kapaklar.append(img)
        print(f"{yol.relative_to(KOK)}: {yol.stat().st_size // 1024} KB")
    if "--onizleme" in argv:
        sayfa = Image.new("RGB", (SERIT[0], SERIT[1] * len(kapaklar) + 10 * len(kapaklar)), "white")
        for i, img in enumerate(kapaklar):
            sayfa.paste(img, (0, i * (SERIT[1] + 10)))
        yol = KOK / "app" / "build" / "kart_kapaklari.jpg"
        yol.parent.mkdir(exist_ok=True)
        sayfa.save(yol, quality=85)
        print(yol)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
