"""İstem kaydındaki görselleri OpenAI Images API (edit uç noktası) ile üretir.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/gorsel_uret.py b03-on-ogul [b02-ordu-yuruyus ...]
      [--model gpt-image-2.6-sunburst] [--kalite high] [--sonek -a] [--seffaf] [--kuru]

- Kimliğin ilk üç harfi (b03) kayıt dosyasını seçer: content/gorseller/istemler/b03.json.
- `karakter-<kimlik>`: karakterler.json'daki kartın referans sayfası (üç açı, yeşil perde);
  istem istem_devir.karakter_sayfa_metni ile aynıdır. Onaylanan sayfa elle
  referans/ klasörüne konur ve karta `referans_dosya` yazılır.
- İstem metni ChatGPT mesaj dosyasıyla aynıdır (istem_devir.mesaj); başına Mesaj 0'daki
  üslup ve kurallar eklenir. Görsel olarak üslup referansı (referans/uslup-u01d.png),
  geçen karakterlerin referans sayfaları ve varsa kayıttaki "ekle" görseli gönderilir.
  Bulunamayan referans atlanır ve uyarı verilir.
- Çıktı: İndirilenler\\siyer\\<kimlik><sonek>.png. Var olan dosyanın üzerine yazmaz.
- Her üretimden sonra gorsel_al.denetle çalışır; sonda _kontrol.jpg paftası yazılır.
- Kullanım (token) bilgisi İndirilenler\\siyer\\_api_kayit.jsonl'e eklenir.
- --seffaf: background=transparent ister ve istemdeki yeşil perde cümlelerini
  saydam zemine çevirir. (Saydam çıktıyı gorsel_katman.py henüz işlemez.)
- --kuru: API'ye gitmez; istemi ve eklenecek dosyaları yazdırır.

Anahtar OPENAI_API_KEY ortam değişkeninden okunur; hiçbir yere yazılmaz.
"""
import base64
import json
import mimetypes
import os
import sys
import time
import urllib.error
import urllib.request
import uuid
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import istem_devir  # noqa: E402
from gorsel_al import VARSAYILAN_KLASOR, denetle, pafta  # noqa: E402

KOK = Path(__file__).resolve().parent.parent
ISTEMLER = KOK / "content/gorseller/istemler"
REFERANS = ISTEMLER / "referans"
USLUP_GORSELI = REFERANS / "uslup-u01d.png"
UC = "https://api.openai.com/v1/images/edits"


def onsoz(uslup: dict) -> str:
    """ChatGPT'deki Mesaj 0'ın API karşılığı (sohbet olmadığı için her isteğe eklenir)."""
    return (
        "Respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. "
        "The FIRST attached image is the style reference: match its paper cut-out look, palette and texture. "
        "Use it only for style, not composition.\n\n"
        f"Style: {uslup['istem'].replace('Cinematic 16:9 framing.', 'Cinematic wide framing.')}\n\n"
        f"Strict rules: {uslup['yasaklar']}\n\n"
        "Green-screen images are cut-out layers placed later over separate sky, mountain, ground and building layers: "
        "draw only what is listed, complete and with green margin around it, and never draw any background, ground or "
        "shadow on them. Full-frame images will be cropped about 15% at the top and bottom and 8% on each side, so keep "
        "important elements inside that central area. Before outputting, count people, arms, hands and legs and fix any error."
    )


def seffaflastir(metin: str) -> str:
    for eski, yeni in [
        ("perfectly flat, uniform chroma green (#00B140)", "fully transparent background"),
        ("perfectly flat, uniform pure chroma-green background (#00B140)", "fully transparent background"),
        ("chroma green (#00B140)", "transparent background"),
        ("flat green space", "empty transparent space"),
        ("green margin", "transparent margin"),
        (", with no green tint on them", ""),
        (", no green tint on the figure", ""),
        (", no green tint on the object", ""),
        (" No green tint on the ground.", ""),
        ("the background is one flat, uniform green with no ground, horizon or shadow",
         "the background is fully transparent with no ground, horizon or shadow"),
    ]:
        metin = metin.replace(eski, yeni)
    return metin


def referans_bul(ad: str) -> Path | None:
    for klasor in (REFERANS, VARSAYILAN_KLASOR):
        p = klasor / ad
        if p.exists():
            return p
    return None


def cok_parcali(alanlar: list[tuple[str, str]], dosyalar: list[tuple[str, Path]]) -> tuple[bytes, str]:
    sinir = uuid.uuid4().hex
    parca = []
    for ad, deger in alanlar:
        parca.append(f'--{sinir}\r\nContent-Disposition: form-data; name="{ad}"\r\n\r\n{deger}\r\n'.encode())
    for ad, yol in dosyalar:
        tur = mimetypes.guess_type(yol.name)[0] or "application/octet-stream"
        parca.append(
            f'--{sinir}\r\nContent-Disposition: form-data; name="{ad}"; filename="{yol.name}"\r\n'
            f"Content-Type: {tur}\r\n\r\n".encode() + yol.read_bytes() + b"\r\n"
        )
    parca.append(f"--{sinir}--\r\n".encode())
    return b"".join(parca), f"multipart/form-data; boundary={sinir}"


def uret(istem: str, gorseller: list[Path], model: str, kalite: str, seffaf: bool) -> dict:
    anahtar = os.environ.get("OPENAI_API_KEY")
    if not anahtar:
        raise SystemExit("OPENAI_API_KEY ortam değişkeni yok.")
    alanlar = [("model", model), ("prompt", istem), ("size", "1536x1024"), ("quality", kalite), ("n", "1"),
               ("output_format", "png"), ("background", "transparent" if seffaf else "opaque")]
    govde, tur = cok_parcali(alanlar, [("image[]", g) for g in gorseller])
    istek = urllib.request.Request(UC, data=govde, method="POST",
                                   headers={"Authorization": f"Bearer {anahtar}", "Content-Type": tur})
    try:
        with urllib.request.urlopen(istek, timeout=600) as yanit:
            return json.loads(yanit.read())
    except urllib.error.HTTPError as h:
        hata = h.read().decode("utf-8", "replace")
        try:
            hata = json.loads(hata)["error"]["message"]
        except (ValueError, KeyError):
            pass
        raise RuntimeError(f"HTTP {h.code}: {hata}") from None


def main(argv: list[str]) -> int:
    sys.stdout.reconfigure(encoding="utf-8")
    secenek = {"--model": "gpt-image-2.6-sunburst", "--kalite": "high", "--sonek": ""}
    kimlikler = []
    i = 0
    while i < len(argv):
        if argv[i] in secenek:
            secenek[argv[i]] = argv[i + 1]
            i += 2
            continue
        if not argv[i].startswith("--"):
            kimlikler.append(argv[i])
        i += 1
    if not kimlikler:
        print(__doc__)
        return 2
    seffaf = "--seffaf" in argv
    kuru = "--kuru" in argv
    kartlar = istem_devir._karakterler()
    VARSAYILAN_KLASOR.mkdir(parents=True, exist_ok=True)
    sonuc = []
    for kimlik in kimlikler:
        if kimlik.startswith("karakter-"):
            kart_id = kimlik[len("karakter-"):]
            if kart_id not in kartlar:
                print(f"{kimlik}: karakterler.json içinde yok, atlandı.")
                continue
            # Üslup bütün bölümlerde aynı; en son bölüm kaydından alınır.
            veri = json.loads(sorted(ISTEMLER.glob("b[0-9][0-9].json"))[-1].read_text(encoding="utf-8"))
            kayit = {"id": kimlik, "tip": "figur"}
            metin, ekle = istem_devir.karakter_sayfa_metni(kart_id, kartlar[kart_id]), []
        else:
            kayit_yolu = ISTEMLER / f"{kimlik[:3]}.json"
            veri = json.loads(kayit_yolu.read_text(encoding="utf-8"))
            kayit = next((k for k in veri["istemler"] if k["id"] == kimlik), None)
            if not kayit:
                print(f"{kimlik}: {kayit_yolu.name} içinde yok, atlandı.")
                continue
            metin, ekle = istem_devir.mesaj(veri["uslup"], kayit, kartlar)
        istem = f"{onsoz(veri['uslup'])}\n\n{metin}"
        if seffaf:
            istem = seffaflastir(istem)
        gorseller = [USLUP_GORSELI]
        for ad in ekle:
            p = referans_bul(ad)
            if p:
                gorseller.append(p)
            else:
                print(f"{kimlik}: UYARI referans bulunamadı, atlandı: {ad}")
        hedef = VARSAYILAN_KLASOR / f"{kimlik}{secenek['--sonek']}.png"
        if kuru:
            print(f"=== {kimlik} -> {hedef.name}\nEkler: {[g.name for g in gorseller]}\n\n{istem}\n")
            continue
        if hedef.exists():
            print(f"{kimlik}: {hedef.name} zaten var, atlandı (başka --sonek ver).")
            continue
        print(f"{kimlik}: üretiliyor ({secenek['--model']}, {secenek['--kalite']}, {len(gorseller)} referans)...", flush=True)
        bas = time.time()
        try:
            yanit = uret(istem, gorseller, secenek["--model"], secenek["--kalite"], seffaf)
        except RuntimeError as h:
            print(f"{kimlik}: HATA {h}")
            continue
        hedef.write_bytes(base64.b64decode(yanit["data"][0]["b64_json"]))
        sure = time.time() - bas
        with open(VARSAYILAN_KLASOR / "_api_kayit.jsonl", "a", encoding="utf-8") as f:
            f.write(json.dumps({"zaman": time.strftime("%Y-%m-%dT%H:%M:%S"), "kimlik": kimlik, "dosya": hedef.name,
                                "model": secenek["--model"], "kalite": secenek["--kalite"], "seffaf": seffaf,
                                "sure_sn": round(sure), "kullanim": yanit.get("usage")}, ensure_ascii=False) + "\n")
        uyari = [] if seffaf else denetle(hedef, kayit)
        sonuc.append((hedef.stem, hedef, uyari))
        print(f"{kimlik}: {hedef}  ({sure:.0f} sn, kullanım: {yanit.get('usage')})"
              + (f"\n   UYARI: {'; '.join(uyari)}" if uyari else ""))
    if sonuc:
        pafta(sonuc, VARSAYILAN_KLASOR / "_kontrol.jpg")
        print(f"Pafta: {VARSAYILAN_KLASOR / '_kontrol.jpg'}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
