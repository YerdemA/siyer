"""Anlatım seslerinin seviyesini eşitler ve ani iniş çıkışları yumuşatır.

ElevenLabs duygu etiketleri ([excited], [whispers] ...) sahneler arasında
~5 dB, sahne içinde de belirgin seviye farkı bırakıyor. Her dosyaya hafif bir
sıkıştırıcı, sonra iki geçişli loudnorm (-16 LUFS) uygulanır. Dosyaların
üzerine yazar; ham hali git geçmişindedir. ffmpeg gerekir.

    python tools/ses_dengele.py                 # content/tr/ses/*.mp3
    python tools/ses_dengele.py b03-s07.mp3 ...  # yalnız verilenler
"""

import json
import pathlib
import subprocess
import sys
import tempfile

KOK = pathlib.Path(__file__).resolve().parent.parent / "content" / "tr" / "ses"
HEDEF = "I=-16:TP=-1.5:LRA=5"
# Eşiği aşan yerleri 1/3 oranında bastırır; konuşmanın doğal vurgusu kalır.
SIKISTIR = "acompressor=threshold=-22dB:ratio=3:attack=15:release=300:knee=4"


def calistir(argumanlar: list[str]) -> str:
    return subprocess.run(argumanlar, capture_output=True, text=True, encoding="utf-8", check=True).stderr


def olc(dosya: pathlib.Path) -> dict:
    cikti = calistir(["ffmpeg", "-hide_banner", "-nostats", "-i", str(dosya),
                      "-af", f"{SIKISTIR},loudnorm={HEDEF}:print_format=json", "-f", "null", "-"])
    return json.loads(cikti[cikti.rindex("{"):cikti.rindex("}") + 1])


def dengele(dosya: pathlib.Path) -> None:
    o = olc(dosya)
    suzgec = (f"{SIKISTIR},loudnorm={HEDEF}:measured_I={o['input_i']}:measured_TP={o['input_tp']}"
              f":measured_LRA={o['input_lra']}:measured_thresh={o['input_thresh']}"
              f":offset={o['target_offset']}:linear=true")
    with tempfile.TemporaryDirectory() as gecici:
        cikis = pathlib.Path(gecici) / dosya.name
        calistir(["ffmpeg", "-hide_banner", "-y", "-i", str(dosya), "-af", suzgec,
                  "-ar", "44100", "-ac", "1", "-c:a", "libmp3lame", "-b:a", "128k", str(cikis)])
        dosya.write_bytes(cikis.read_bytes())
    print(f"{dosya.name}: {o['input_i']} LUFS, LRA {o['input_lra']} -> -16 LUFS")


def main() -> None:
    dosyalar = [KOK / a for a in sys.argv[1:]] or sorted(KOK.glob("*.mp3"))
    for d in dosyalar:
        dengele(d)


if __name__ == "__main__":
    main()
