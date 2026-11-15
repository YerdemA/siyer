"""ChatGPT'den indirilen görselleri istem kimlikleriyle adlandırır ve ön denetimden geçirir.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/gorsel_al.py content/gorseller/istemler/b04-chatgpt.md [--bas 3] [--uygula] [--klasor <yol>]

- Mesaj dosyasındaki sırayı (## Mesaj N: <kimlik> / ## Sayfa N: <kimlik>) okur.
- Klasördeki (varsayılan: İndirilenler\\siyer) henüz bir kimlikle adlandırılmamış
  görselleri değişiklik zamanına göre sıralar ve dosyası olmayan ilk kimlikten
  (ya da --bas N. mesajdan) başlayarak sırayla eşler. Böylece ChatGPT'den
  indirirken ad yazmak gerekmez; yalnız mesaj sırasıyla indirmek yeter.
- --uygula verilmezse yalnız eşlemeyi gösterir; verilirse yeniden adlandırır.
- Her eşlenen görsel için otomatik denetim: yeşil perdeli görselde zeminin
  düzlüğü, konunun kenara değip değmediği (kırpılma), zemin katmanında ufkun
  üstünün yeşil olup olmadığı. Bu denetim gözle denetimin yerini tutmaz.
- Klasöre `_kontrol.jpg` adında etiketli bir pafta yazar.
"""
import json
import re
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw

VARSAYILAN_KLASOR = Path.home() / "Downloads" / "siyer"
ADLI = re.compile(r"^(b\d\d-|karakter-|m\d|s\d|u\d)", re.I)


def sira(md: Path) -> list[str]:
    return re.findall(r"^## (?:Mesaj|Sayfa) [1-9]\d*: ((?:b\d\d|karakter)-\S+)", md.read_text(encoding="utf-8"), re.M)


def kayitlar(md: Path) -> dict:
    if md.stem.startswith("karakterler"):
        return {}
    j = md.with_name(md.stem.replace("-chatgpt", "") + ".json")
    return {k["id"]: k for k in json.loads(j.read_text(encoding="utf-8"))["istemler"]} if j.exists() else {}


def yesil_maske(a: np.ndarray) -> np.ndarray:
    r, g, b = a[..., 0].astype(int), a[..., 1].astype(int), a[..., 2].astype(int)
    return (g - np.maximum(r, b)) > 60


def denetle(yol: Path, kayit: dict | None) -> list[str]:
    a = np.asarray(Image.open(yol).convert("RGB"))
    isleme = (kayit or {}).get("isleme", "sigdir")
    tip = (kayit or {}).get("tip")
    uyari = []
    if isleme == "opak":
        if yesil_maske(a).mean() > 0.05:
            uyari.append("tam dolu olmalıydı ama yeşil perde var")
        return uyari
    y = yesil_maske(a)
    oran = y.mean()
    if oran < 0.15:
        uyari.append(f"yeşil perde yok gibi (%{oran * 100:.0f})")
        return uyari
    if tip == "zemin":
        ufuk = kayit.get("ufuk", 0.45)
        ust = y[: int(a.shape[0] * ufuk * 0.8)]
        if ust.mean() < 0.9:
            uyari.append("ufkun üstünde yeşil olmayan alan var (gök ya da dağ çizilmiş olabilir)")
        return uyari
    konu = ~y
    kenar = 4
    degen = [ad for ad, dilim in (("üst", konu[:kenar]), ("sol", konu[:, :kenar]), ("sağ", konu[:, -kenar:]))
             if dilim.mean() > 0.02]
    if (kayit or {}).get("cekim") != "yakin" and konu[-kenar:].mean() > 0.02 and tip != "nesne":
        degen.append("alt")
    if degen and not (kayit or {}).get("yerlesim", "").startswith("The wall"):
        uyari.append("konu kenara değiyor: " + ", ".join(degen))
    # Perde düzlüğü: yeşil piksellerin renk sapması.
    yp = a[y]
    if len(yp) and yp.std(axis=0).max() > 18:
        uyari.append("yeşil zemin düz değil (gölge ya da doku var)")
    return uyari


def pafta(eslesen: list[tuple[str, Path, list[str]]], cikti: Path) -> None:
    tw, th = 420, 300
    sutun = 4
    satir = (len(eslesen) + sutun - 1) // sutun
    sh = Image.new("RGB", (sutun * tw, satir * (th + 40)), "white")
    d = ImageDraw.Draw(sh)
    for i, (kimlik, yol, uyari) in enumerate(eslesen):
        im = Image.open(yol).convert("RGB")
        im.thumbnail((tw, th))
        x, y = (i % sutun) * tw, (i // sutun) * (th + 40)
        sh.paste(im, (x, y + 20))
        d.text((x + 3, y + 3), kimlik, fill="black")
        if uyari:
            d.text((x + 3, y + th + 22), "; ".join(uyari)[:70], fill="red")
    sh.save(cikti, quality=85)


def main(argv: list[str]) -> int:
    sys.stdout.reconfigure(encoding="utf-8")
    yollar = [a for a in argv if not a.startswith("--")]
    if not yollar:
        print(__doc__)
        return 2
    md = Path(yollar[0])
    klasor = VARSAYILAN_KLASOR
    bas = None
    for i, a in enumerate(argv):
        if a == "--klasor":
            klasor = Path(argv[i + 1])
        if a == "--bas":
            bas = int(argv[i + 1])
    kimlikler = sira(md)
    kayit = kayitlar(md)
    var = {p.stem for p in klasor.glob("*.png")}
    if bas is not None:
        kalan = kimlikler[bas - 1:]
    else:
        kalan = [k for k in kimlikler if k not in var]
    adsiz = sorted((p for p in klasor.iterdir()
                    if p.suffix.lower() in (".png", ".webp", ".jpg") and not ADLI.match(p.name) and not p.name.startswith("_")),
                   key=lambda p: p.stat().st_mtime)
    if not adsiz:
        print("Adlandırılmamış görsel yok.")
    if len(adsiz) > len(kalan):
        print(f"UYARI: {len(adsiz)} adsız görsel var ama {len(kalan)} kimlik kaldı; fazlası eşlenmedi.")
    eslesen = []
    for kimlik, p in zip(kalan, adsiz):
        hedef = klasor / f"{kimlik}.png"
        if "--uygula" in argv:
            if hedef.exists():
                print(f"ATLANDI {p.name}: {hedef.name} zaten var")
                continue
            if p.suffix.lower() != ".png":
                Image.open(p).save(hedef)
                p.unlink()
            else:
                p.rename(hedef)
            yol = hedef
        else:
            yol = p
        uyari = denetle(yol, kayit.get(kimlik))
        eslesen.append((kimlik, yol, uyari))
        print(f"{p.name}  ->  {kimlik}.png" + (f"   UYARI: {'; '.join(uyari)}" if uyari else ""))
    if eslesen:
        pafta(eslesen, klasor / "_kontrol.jpg")
        print(f"Pafta: {klasor / '_kontrol.jpg'}")
    if "--uygula" not in argv and eslesen:
        print("Yalnız önizleme. Uygulamak için --uygula ekle.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
