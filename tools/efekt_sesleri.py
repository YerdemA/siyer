"""Arayüz efekt seslerini gürültüden sentezler (telifsiz, tekrar üretilebilir).

Kullanım (depo kökünden, projenin sanal ortamıyla):
  .venv\\Scripts\\python.exe -I tools/efekt_sesleri.py

Çıktı: app/assets/sesler/kalem.wav, app/assets/sesler/parsomen.wav
(22 050 Hz, 16 bit, tek kanal).

- kalem: bölüm kartına çizilen çarpının iki fırça darbesi. Zamanlama
  bolum_yolu.dart'taki animasyonla aynıdır (1,3 sn'lik animasyonun
  0,38–0,58 ve 0,58–0,78 aralıkları; kaydırma payıyla birlikte).
- parsomen: harita açılırken kâğıt hışırtısı.
"""
import wave
from pathlib import Path

import numpy as np

HIZ = 22050
KOK = Path(__file__).resolve().parent.parent
CIKTI = KOK / "app/assets/sesler"


def yumusat(x: np.ndarray, n: int) -> np.ndarray:
    """Kayan ortalama: basit alçak geçiren süzgeç."""
    return np.convolve(x, np.ones(n) / n, mode="same")


def bant(x: np.ndarray, alt: int, ust: int) -> np.ndarray:
    """Kaba bant geçiren: iki kayan ortalamanın farkı."""
    return yumusat(x, max(1, HIZ // ust)) - yumusat(x, max(1, HIZ // alt))


def zarf(n: int, bas: float, son: float) -> np.ndarray:
    t = np.linspace(0, 1, n)
    return np.minimum(np.clip(t / bas, 0, 1), np.clip((1 - t) / son, 0, 1))


def kalem(rng: np.random.Generator) -> np.ndarray:
    toplam = np.zeros(int(HIZ * 1.15))
    # Darbeler: (başlangıç sn, süre sn). Kaydırma ~0,38 sn + animasyon payı.
    for bas, sure in [(0.43, 0.24), (0.69, 0.24)]:
        n = int(HIZ * sure)
        g = bant(rng.standard_normal(n), 1800, 7000)
        # Kâğıt dokusunda takılan uç: düzensiz genlik.
        doku = yumusat(np.abs(rng.standard_normal(n)), HIZ // 300) * 1.6
        g *= doku * zarf(n, 0.08, 0.3)
        i = int(HIZ * bas)
        toplam[i : i + n] += g
    return toplam


def parsomen(rng: np.random.Generator) -> np.ndarray:
    n = int(HIZ * 0.9)
    g = bant(rng.standard_normal(n), 400, 5000)
    # Hışırtı: seyrek, kısa çıtırtılar ve yavaş kabaran genlik.
    citir = (rng.random(n) < 0.004).astype(float)
    citir = yumusat(citir, HIZ // 400) * 6
    kabarma = yumusat(np.abs(rng.standard_normal(n)), HIZ // 20) * 1.4
    return g * (kabarma + citir) * zarf(n, 0.25, 0.45)


def yaz(ad: str, x: np.ndarray, tepe: float) -> None:
    x = x / (np.abs(x).max() or 1) * tepe
    CIKTI.mkdir(parents=True, exist_ok=True)
    yol = CIKTI / f"{ad}.wav"
    with wave.open(str(yol), "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(HIZ)
        w.writeframes((x * 32767).astype("<i2").tobytes())
    print(f"{yol.relative_to(KOK)} ({yol.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    rng = np.random.default_rng(605)
    yaz("kalem", kalem(rng), 0.45)
    yaz("parsomen", parsomen(rng), 0.35)
