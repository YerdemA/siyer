"""Şahıslar sözlüğü için portreleri karakter referans sayfalarından kırpar.

Kullanım (depo kökünden, projenin sanal ortamıyla):
  .venv\\Scripts\\python.exe -I tools/portre_kirp.py [sahis-id ...]

- Eşleme aşağıdaki PORTRELER sözlüğündedir (şahıs kimliği → karakter kartı).
  Verilmezse hepsi işlenir.
- Referans sayfası üç açılıdır (önden, yarım yan, yan); en soldaki figür
  (önden görünüş) bulunur, baş ve omuzları kare olarak kırpılır.
- Yeşil perde silinir; çıktı 320×320 şeffaf WebP:
  content/gorseller/sahislar/<sahis-id>.webp
- Kural 5 (CLAUDE.md): Efendimiz, diğer peygamberler, anne-babası, eşleri,
  çocukları ve süt annesi için portre YAPILMAZ; uygulama onları nur ya da
  yüzsüz siluetle gösterir (sahislar.json → temsil). Bu yüzden onların kartları
  burada yoktur.
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gorsel_katman import perde_sil  # noqa: E402

KOK = Path(__file__).resolve().parent.parent
REFERANS = KOK / "content/gorseller/istemler/referans"
CIKTI = KOK / "content/gorseller/sahislar"
BOYUT = 320

PORTRELER = {
    "abdulmuttalib": "abdulmuttalib",
    "ebu-talib": "ebu_talib",
    "bahira": "bahira",
    "ebrehe": "ebrehe",
    "nufeyl-b-habib": "nufeyl",
    "abdullah-b-cudan": "abdullah_b_cudan",
    "fatima-bint-esed": "fatima_bint_esed",
    "haris-b-abduluzza": "haris",
    "meysere": "meysere",
    "osman-b-huveyris": "osman_huveyris",
    "ubeydullah-b-cahs": "ubeydullah",
    "ummu-eymen": "ummu_eymen",
    "varaka-b-nevfel": "varaka",
    "vehb-b-abdumenaf": "vehb",
    "zeyd-b-amr": "zeyd_amr",
    "zeyd-b-harise": "zeyd_harise",
    "zubeyr-b-abdulmuttalib": "zubeyr",
}


def ilk_figur(alfa: np.ndarray) -> tuple[int, int, int, int]:
    """En soldaki figürün sınırları (sol, üst, sağ, alt)."""
    sutun = (alfa > 128).sum(axis=0) > alfa.shape[0] * 0.02
    sol = int(np.argmax(sutun))
    sag = sol
    bosluk = 0
    # Figürler arasında en az %2 genişlikte boş şerit vardır.
    for x in range(sol, alfa.shape[1]):
        if sutun[x]:
            sag, bosluk = x, 0
        else:
            bosluk += 1
            if bosluk > alfa.shape[1] * 0.02:
                break
    # Figürler birbirine değiyorsa (boşluk yoksa) sayfanın ilk üçte biri alınır.
    if sag - sol > alfa.shape[1] * 0.45:
        sag = sol + alfa.shape[1] // 3
    satir = (alfa[:, sol : sag + 1] > 128).any(axis=1)
    ust = int(np.argmax(satir))
    alt = len(satir) - int(np.argmax(satir[::-1]))
    return sol, ust, sag + 1, alt


def portre(sahis: str, kart: str) -> Path:
    img = perde_sil(Image.open(REFERANS / f"karakter-{kart}.png"))
    alfa = np.asarray(img)[..., 3]
    sol, ust, sag, alt = ilk_figur(alfa)
    boy = alt - ust
    # Baş ve omuzlar: figür boyunun üst ~%30'u; başın ortası, üst %12'deki
    # opak piksellerin ortalaması.
    kenar = int(boy * 0.30)
    bas = alfa[ust : ust + int(boy * 0.12), sol:sag] > 128
    orta = sol + int(np.nonzero(bas)[1].mean()) if bas.any() else (sol + sag) // 2
    ust_kenar = max(0, ust - int(kenar * 0.08))
    kutu = (orta - kenar // 2, ust_kenar, orta + kenar // 2, ust_kenar + kenar)
    kare = img.crop(kutu).resize((BOYUT, BOYUT), Image.LANCZOS)
    CIKTI.mkdir(parents=True, exist_ok=True)
    yol = CIKTI / f"{sahis}.webp"
    kare.save(yol, "WEBP", quality=88, method=6)
    return yol


def main(argv: list[str]) -> int:
    secilen = argv or list(PORTRELER)
    for s in secilen:
        if s not in PORTRELER:
            print(f"{s}: eşlemede yok")
            continue
        print(portre(s, PORTRELER[s]).relative_to(KOK))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
