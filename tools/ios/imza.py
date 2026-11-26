"""iOS imza dosyaları, Windows'ta (Mac anahtarlığı olmadan).

App Store derlemesi GitHub Actions'ta çalışır (.github/workflows/ios-release.yml)
ve depo secret'larında duran bir dağıtım sertifikası ile iki App Store
profiliyle imzalar (uygulama + bölüm paketi indirici eklentisi). Bu betik
onları openssl ile hazırlar (Git for Windows'takiyle yeter):

    python tools/ios/imza.py csr                      # anahtar + Apple'a yüklenecek istek
    python tools/ios/imza.py p12 distribution.cer
    python tools/ios/imza.py profil Siyer_App_Store.mobileprovision
    python tools/ios/imza.py profil-indirici Siyer_Indirici_App_Store.mobileprovision

Kabaca aynı hesapta: onun dağıtım sertifikası varsa yenisini üretme,
`p12` adımındaki dosyaları (IOS_DIST_CERT_P12, parola) aynen kullan; yalnız
profilleri hazırla. Her şey ~/siyer-araclar/ios-imza/ altına yazılır (depo
dışı). Oradaki özel anahtar sertifikanın kendisidir: Android yükleme
anahtarının yanına yedekle.
"""

import base64
import secrets
import shutil
import subprocess
import sys
from pathlib import Path

CIKTI = Path.home() / "siyer-araclar" / "ios-imza"
ANAHTAR = CIKTI / "dist.key"


def openssl(*args: str) -> None:
    # Git'in mingw64 sürümü: usr/bin'deki "/CN=..." değerini yol sanıp bozar.
    exe = shutil.which("openssl") or r"C:\Program Files\Git\mingw64\bin\openssl.exe"
    if not Path(exe).exists() and not shutil.which(exe):
        sys.exit("openssl bulunamadı (Git for Windows ile gelir).")
    subprocess.run([exe, *args], check=True)


def b64_yaz(kaynak: Path, hedef: Path) -> None:
    hedef.write_text(base64.b64encode(kaynak.read_bytes()).decode(), "ascii")
    print(f"  {hedef}  (GitHub secret değeri)")


def csr() -> None:
    CIKTI.mkdir(parents=True, exist_ok=True)
    if ANAHTAR.exists():
        sys.exit(f"{ANAHTAR} zaten var; yenisi eski sertifikayı işe yaramaz kılar.")
    openssl("genrsa", "-out", str(ANAHTAR), "2048")
    openssl(
        "req", "-new", "-key", str(ANAHTAR), "-out", str(CIKTI / "dist.csr"),
        "-subj", "/CN=Siyer Distribution/C=TR",
    )
    print(f"  {CIKTI / 'dist.csr'}  → Certificates → + → Apple Distribution")


def p12(cer: str) -> None:
    if not ANAHTAR.exists():
        sys.exit("Önce: python tools/ios/imza.py csr")
    pem = CIKTI / "dist.pem"
    openssl("x509", "-inform", "DER", "-in", cer, "-out", str(pem))
    parola = secrets.token_urlsafe(18)
    hedef = CIKTI / "dist.p12"
    # SHA1-3DES: macOS'un `security import`u OpenSSL 3'ün varsayılanını reddeder.
    openssl(
        "pkcs12", "-export", "-inkey", str(ANAHTAR), "-in", str(pem),
        "-out", str(hedef), "-passout", f"pass:{parola}",
        "-keypbe", "PBE-SHA1-3DES", "-certpbe", "PBE-SHA1-3DES",
        "-macalg", "sha1", "-name", "Siyer Distribution",
    )
    (CIKTI / "dist.p12.password").write_text(parola, "ascii")
    print(f"  {CIKTI / 'dist.p12.password'}  → IOS_DIST_CERT_PASSWORD")
    b64_yaz(hedef, CIKTI / "IOS_DIST_CERT_P12.txt")


def profil(yol: str, secret: str) -> None:
    CIKTI.mkdir(parents=True, exist_ok=True)
    b64_yaz(Path(yol), CIKTI / f"{secret}.txt")


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8")  # Windows konsolu: oklar, Türkçe
    match sys.argv[1:]:
        case ["csr"]:
            csr()
        case ["p12", cer]:
            p12(cer)
        case ["profil", yol]:
            profil(yol, "IOS_PROFILE")
        case ["profil-indirici", yol]:
            profil(yol, "IOS_PROFILE_INDIRICI")
        case _:
            sys.exit(__doc__)


if __name__ == "__main__":
    main()
