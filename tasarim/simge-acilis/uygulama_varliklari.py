"""Seçilen simge (simge-1-muhur) ve açılışı (acilis-1-parsomen) uygulamaya
girecek PNG'lere çevirir (Erdem, 2026-11-21).

Kullanım (depo kökünden):
  python tasarim/simge-acilis/uygulama_varliklari.py
  cd app && dart run flutter_launcher_icons && dart run flutter_native_splash:create

SVG'ler `uret.py`'deki parçalarla kurulur, Chrome (headless) ile saydam PNG'ye
çevrilir ve `app/assets/simge/` altına yazılır.
"""
import os
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from uret import MUREKKEP, MUREKKEP_SOLUK, baslik, kum_tepeleri, muhur, parsomen_zemin, svg  # noqa: E402

KOK = Path(__file__).resolve().parents[2]
HEDEF = KOK / "app" / "assets" / "simge"

CHROME_ADAYLARI = [
    os.environ.get("CHROME", ""),
    r"C:\Program Files\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
]

# ad: (genişlik, yükseklik, gövde)
VARLIKLAR = {
    # Eski Android ve iOS simgesi: parşömen zemin + mühür (simge-1-muhur'un aynısı).
    "simge": (1024, 1024, parsomen_zemin(1024, 1024, "s") + muhur(512, 512, 300)),
    # Uyarlanabilir simge ön planı: saydam. Görünen alan tuvalin ortadaki 2/3'ü;
    # mühür bunun ~%65'ini kaplar, taslaktaki oran (flutter_launcher_icons.yaml'da
    # adaptive_icon_foreground_inset: 0).
    "simge-on": (1024, 1024, muhur(512, 512, 220)),
    # Uyarlanabilir simge arka planı: yalnız parşömen.
    "simge-zemin": (1024, 1024, parsomen_zemin(1024, 1024, "z")),
    # Android 12+ açılış simgesi: 1152 tuvalde görünen daire çapı 768.
    "acilis-simge": (1152, 1152, muhur(576, 576, 300)),
    # Eski Android / iOS açılışı: ortadaki görsel (mühür + başlık), saydam.
    "acilis": (1080, 880, muhur(540, 290, 230) + baslik(MUREKKEP, MUREKKEP_SOLUK, 690)),
    # Eski Android / iOS açılışı: tam ekran zemin (parşömen + kum tepeleri).
    "acilis-zemin": (
        1080,
        1920,
        parsomen_zemin(1080, 1920, "a")
        + kum_tepeleri([(200, 360), (860, 300), (180, 1560), (900, 1640), (760, 520)], 60, opaklik=0.25),
    ),
}


def chrome() -> str:
    for yol in CHROME_ADAYLARI:
        if yol and Path(yol).exists():
            return yol
    sys.exit("Chrome ya da Edge bulunamadı; CHROME ortam değişkeniyle yolu verin.")


def png_yap(tarayici: str, svg_metni: str, w: int, h: int, cikti: Path, gecici: Path) -> None:
    html = gecici / f"{cikti.stem}.html"
    html.write_text(
        "<!doctype html><meta charset='utf-8'>"
        "<style>html,body{margin:0;background:transparent;overflow:hidden}svg{display:block}</style>"
        + svg_metni,
        encoding="utf-8",
    )
    subprocess.run(
        [
            tarayici,
            "--headless=new",
            "--disable-gpu",
            "--hide-scrollbars",
            "--force-device-scale-factor=1",
            "--default-background-color=00000000",
            f"--window-size={w},{h}",
            f"--screenshot={cikti}",
            html.as_uri(),
        ],
        check=True,
        capture_output=True,
    )


def main() -> None:
    tarayici = chrome()
    HEDEF.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory() as d:
        gecici = Path(d)
        for ad, (w, h, govde) in VARLIKLAR.items():
            cikti = HEDEF / f"{ad}.png"
            png_yap(tarayici, svg(w, h, govde), w, h, cikti, gecici)
            print(f"{cikti.relative_to(KOK)}  {w}×{h}")


if __name__ == "__main__":
    main()
