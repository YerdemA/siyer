"""Bütün bölümlerin metnini kontrol için tek bir Markdown dosyasına döker.

Kullanım (depo kökünden):
  python tools/bolum_metni.py [çıktı.md]      (varsayılan: docs/BOLUM_METINLERI.md)

İçerik: her bölümün numarası, başlığı, açıklaması; sahne sahne anlatım metni
(iddia kimlikleriyle), sahnenin yeri, şahısları ve görsel tarifi; bölümün
iddiaları (ifade, güç, gerekçe, kaynaklar ve doğrulama durumu, alternatif
rivayetler). Sonda uygulamada görünen öteki metinler: şahıslar sözlüğü,
yerler, zaman çizelgesi.

Dosya betikle üretilir; düzeltme bu dosyaya değil content/tr/ altındaki
JSON'a yapılır, sonra betik yeniden çalıştırılır.
"""
import json
import sys
from datetime import date
from pathlib import Path

KOK = Path(__file__).resolve().parent.parent
ICERIK = KOK / "content/tr"

GUC = {"guclu": "güçlü", "orta": "orta", "zayif": "zayıf"}
DOGRULAMA = {"bekliyor": "doğrulama bekliyor", "dogrulandi": "doğrulandı"}


def oku(yol: Path):
    return json.loads(yol.read_text(encoding="utf-8"))


def main(argv: list[str]) -> int:
    cikti = Path(argv[0]) if argv else KOK / "docs/BOLUM_METINLERI.md"
    kaynakca = {k["id"]: k for k in oku(ICERIK / "kaynakca.json")}
    sahislar = oku(ICERIK / "sahislar.json")
    sahis_ad = {s["id"]: s["ad"] for s in sahislar}
    yerler = oku(ICERIK / "yerler.json")
    yer_ad = {y["id"]: y["ad"] for y in yerler}
    zaman = oku(ICERIK / "zaman-cizelgesi.json")
    bolumler = sorted(
        (oku(p) for p in (ICERIK / "bolumler").glob("*.json") if not p.name.startswith("_")),
        key=lambda b: b.get("sira", 0),
    )
    bolum_ad = {b["id"]: f"Bölüm {b['sira']} · {b['baslik']}" for b in bolumler}

    def eser(a: dict) -> str:
        k = kaynakca.get(a.get("eser", ""), {})
        kunye = ", ".join(x for x in (k.get("yazar", ""), k.get("eser", "")) if x) or a.get("eser", "?")
        konum = a.get("konum", "") or "konum yok"
        durum = DOGRULAMA.get(a.get("dogrulama", ""), a.get("dogrulama", ""))
        return f"{kunye}, {konum} — *{durum}*"

    s = []
    s.append("# Bölüm Metinleri (kontrol nüshası)\n")
    s.append(
        f"Üretildi: {date.today().isoformat()} · `python tools/bolum_metni.py`. "
        "Bu dosya betikle üretilir; **düzeltmeler `content/tr/` altındaki JSON'a yapılır**, "
        "sonra dosya yeniden üretilir. Anlatımdaki `[i-…]` işaretleri, cümlenin bağlı olduğu "
        "iddiaları gösterir; iddialar ve kaynakları her bölümün sonundadır.\n"
    )
    toplam_sahne = sum(len(b["sahneler"]) for b in bolumler)
    toplam_iddia = sum(len(b["iddialar"]) for b in bolumler)
    toplam_atif = sum(len(i["kaynaklar"]) for b in bolumler for i in b["iddialar"])
    s.append(f"{len(bolumler)} bölüm, {toplam_sahne} sahne, {toplam_iddia} iddia, {toplam_atif} atıf.\n")
    s.append("## İçindekiler\n")
    for b in bolumler:
        s.append(f"- [Bölüm {b['sira']}: {b['baslik']}](#bölüm-{b['sira']}-{b['id']})")
    s.append("- [Ek A: Şahıslar sözlüğü](#ek-a-şahıslar-sözlüğü)")
    s.append("- [Ek B: Yerler](#ek-b-yerler)")
    s.append("- [Ek C: Zaman çizelgesi](#ek-c-zaman-çizelgesi)\n")

    for b in bolumler:
        s.append("\n---\n")
        s.append(f'<a id="bölüm-{b["sira"]}-{b["id"]}"></a>\n')
        s.append(f"## Bölüm {b['sira']}: {b['baslik']}\n")
        s.append(
            f"Kimlik: `{b['id']}` · Durum: {b.get('durum', '')} · "
            f"{len(b['sahneler'])} sahne · {len(b['iddialar'])} iddia\n"
        )
        s.append(f"**Açıklama:** {b.get('ozet', '')}\n")
        for n, sahne in enumerate(b["sahneler"], 1):
            yer = yer_ad.get(sahne.get("yer", ""), sahne.get("yer", "")) or "—"
            kisiler = ", ".join(sahis_ad.get(x, x) for x in sahne.get("sahislar", [])) or "—"
            s.append(f"### Sahne {n} (`{sahne['id']}`)\n")
            s.append(f"Yer: {yer} · Şahıslar: {kisiler}\n")
            for p in sahne.get("anlatim", []):
                isaret = " ".join(f"`[{i}]`" for i in p.get("iddialar", []))
                s.append(f"{p.get('metin', '')} {isaret}".rstrip() + "\n")
            tarif = sahne.get("gorsel", {}).get("tarif", "")
            if tarif:
                s.append(f"> *Görsel tarifi:* {tarif}\n")
        s.append(f"### İddialar ve kaynaklar ({b['sira']}. bölüm)\n")
        for i in b["iddialar"]:
            guc = GUC.get(i.get("guc", ""), i.get("guc", ""))
            s.append(f"**{i['id']}** ({guc}) — {i.get('ifade', '')}\n")
            for a in i.get("kaynaklar", []):
                s.append(f"- {eser(a)}")
            if not i.get("kaynaklar"):
                s.append("- **Kaynak yok**")
            s.append("")
            if i.get("gerekce"):
                s.append(f"*Gerekçe:* {i['gerekce']}\n")
            for r in i.get("alternatifRivayetler", []):
                s.append(f"*Alternatif rivayet:* {r.get('ifade', '')}")
                for a in r.get("kaynaklar", []):
                    s.append(f"  - {eser(a)}")
                s.append("")

    s.append("\n---\n")
    s.append("## Ek A: Şahıslar sözlüğü\n")
    for k in sahislar:
        ust = " · ".join(x for x in (k.get("lakap", ""), k.get("yakinlik", "")) if x)
        s.append(f"**{k['ad']}**" + (f" ({ust})" if ust else "") + f" — `{k['id']}`\n")
        if k.get("ozet"):
            isaret = " ".join(f"`[{i}]`" for i in k.get("iddialar", []))
            s.append(f"{k['ozet']} {isaret}".rstrip() + "\n")
        bol = ", ".join(bolum_ad.get(x, x) for x in sorted(k.get("bolumler", []))) or "—"
        s.append(f"Bölümler: {bol}\n")

    s.append("## Ek B: Yerler\n")
    for y in yerler:
        s.append(f"**{y['ad']}** — `{y['id']}`\n")
        if y.get("ozet"):
            isaret = " ".join(f"`[{i}]`" for i in y.get("iddialar", []))
            s.append(f"{y['ozet']} {isaret}".rstrip() + "\n")
        if y.get("konumKaynagi"):
            s.append(f"Konum kaynağı: {eser(y['konumKaynagi'])}\n")

    s.append("## Ek C: Zaman çizelgesi\n")
    s.append("| Yıl | Olay | Bölüm | İddia |")
    s.append("|---|---|---|---|")
    for z in sorted(zaman, key=lambda z: z.get("yil", 0)):
        yil = f"yakl. {z['yil']}" if z.get("yaklasik") else str(z.get("yil", ""))
        olay = z.get("olay", "").replace("|", "\\|")
        s.append(f"| {yil} | {olay} | {bolum_ad.get(z.get('bolum', ''), z.get('bolum', ''))} | `{z.get('iddia', '')}` |")

    cikti.write_text("\n".join(s) + "\n", encoding="utf-8", newline="\n")
    print(f"{cikti.relative_to(KOK)}: {len(bolumler)} bölüm, {toplam_sahne} sahne, {toplam_iddia} iddia")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
