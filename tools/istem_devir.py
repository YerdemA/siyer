"""Görsel istem kaydından (content/gorseller/istemler/bXX.json) claude.ai'ye
verilecek tek parça devir metni üretir.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/istem_devir.py content/gorseller/istemler/b09.json [--varyant 2] [--atla u01,...] [--tur 4] [--chatgpt]

--chatgpt: Higgsfield yerine tek bir ChatGPT sohbetine sırayla yapıştırılacak
mesajlar (<ad>-chatgpt.md).

Çıktı aynı klasöre <ad>-devir.md olarak yazılır. Her istem; üslup istemi +
sahne istemi + yasaklar birleştirilmiş, son haliyle yer alır; claude.ai
tarafında hiçbir şey birleştirilmez ya da değiştirilmez.
"""
import json
import sys
from pathlib import Path


def birlestir(uslup: dict, kayit: dict) -> str:
    sahne = kayit["istem"].replace("{yesil_perde_eki}", uslup["yesil_perde_eki"]).strip()
    return f"{uslup['istem']}\n\n{sahne}\n\n{uslup['yasaklar']}"


KISA_YASAK = (
    "Rules: no visible faces; no extra people, hands or body parts beyond what is described; "
    "no figure, silhouette, shadow, hand or foot of the Prophet; no minarets, domes, crescents, arches or tiles; "
    "no text or watermarks."
)


def chatgpt(veri: dict, istemler: list[dict], kaynak: Path) -> Path:
    """Tek ChatGPT sohbeti için: ilk mesaj üslubu ve kuralları sabitler, sonraki
    her mesaj tek görsel ister. ChatGPT 16:9 vermez; 3:2 yatay istenir. 16:9'a
    kırpma ve %10 taşma payıyla 1536×1024 görselin dinlenik kadrajda görünen
    kısmı yaklaşık x 128–1408, y 152–872'dir (yanlardan %8, üst/alttan %15)."""
    uslup = veri["uslup"]
    ilk = (
        "I am making a respectful documentary motion comic about 7th-century Mecca. "
        "The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. "
        "Use it only for style, not composition.\n\n"
        f"Style: {uslup['istem'].replace('Cinematic 16:9 framing.', 'Cinematic wide framing.')}\n\n"
        f"Strict rules for every image: {uslup['yasaklar']}\n\n"
        "Format for every image: landscape 3:2. Edges will be cropped: about 15% at the top, 15% at the bottom "
        "and 8% on each side. Keep every important element (people, hands, faces turned away, key objects) well inside "
        "that central area; a single isolated object must sit fully inside the frame with empty margin around it. "
        "Generate exactly one image per message. "
        "Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one."
    )
    satirlar = [
        f"# {veri['bolum']}: ChatGPT ile görsel üretimi",
        "",
        "**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.",
        f"Referans dosyası: Higgsfield galerisindeki iş `{uslup['referans']['is_id']}` ya da Claude Code'un verdiği `u01d.png`.",
        "",
        "**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\\siyer` klasörüne, "
        "mesaj başlığındaki kimlikle kaydet (ör. `s03-deniz.png`). Atladığın olursa Claude Code'a söyle.",
        "",
        "**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.",
        "",
        "**Görsel kötü çıkarsa** (yüz görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil) aynı sohbette şunu yaz ve yenisini indir: "
        "`Regenerate this one: <sorun>. Keep everything else.`",
        "",
        "**Kota dolarsa** kaldığın mesaj numarasını not et; ertesi gün aynı sohbetten devam et.",
        "",
        "## Mesaj 0: üslup ve kurallar (görseli ekleyerek)",
        "",
        "```text",
        ilk,
        "```",
        "",
    ]
    for n, k in enumerate(istemler, 1):
        sahne = k["istem"].replace("{yesil_perde_eki}", uslup["yesil_perde_eki"]).strip()
        metin = (
            f"Scene {k['id']}. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, "
            f"muted earth palette. Not photorealistic, not a 3D render. {sahne}\n\n{KISA_YASAK}"
        )
        notlar = []
        isleme = k.get("isleme") or ("opak" if k.get("katman") == "gok" else "perde")
        notlar.append({
            "perde": "yeşil perde, zemin düz yeşil olmalı",
            "opak": "tam dolu görsel, perde yok",
            "sigdir": "yeşil perde; nesne kenarlara değmemeli",
        }.get(isleme, isleme))
        if k.get("not"):
            notlar.append(k["not"])
        satirlar += [f"## Mesaj {n}: {k['id']}", ""]
        if notlar:
            satirlar += [f"*Kontrol: {'; '.join(notlar)}*", ""]
        satirlar += ["```text", metin, "```", ""]
    cikti = kaynak.with_name(kaynak.stem + "-chatgpt.md")
    cikti.write_text("\n".join(satirlar), encoding="utf-8")
    return cikti


def main(argv: list[str]) -> int:
    yollar = [a for a in argv if not a.startswith("--")]
    if not yollar:
        print(__doc__)
        return 2
    varyant = 2
    atla: set[str] = set()
    for i, a in enumerate(argv):
        if a == "--varyant":
            varyant = int(argv[i + 1])
        if a == "--atla":
            atla = set(argv[i + 1].split(","))
        if a == "--tur":
            turlar = set(argv[i + 1].split(","))
    yollar = [y for y in yollar if y.endswith(".json")]

    kaynak = Path(yollar[0])
    veri = json.loads(kaynak.read_text(encoding="utf-8"))
    uslup = veri["uslup"]
    ref = uslup["referans"]["is_id"]
    istemler = [k for k in veri["istemler"] if k["id"] not in atla]
    if "--tur" in argv:
        istemler = [k for k in istemler if str(k.get("tur")) in turlar]

    if "--chatgpt" in argv:
        cikti = chatgpt(veri, istemler, kaynak)
        print(f"{cikti} ({len(istemler)} görsel + 1 hazırlık mesajı)")
        return 0

    satirlar = [
        f"# {veri['bolum']} görsel üretimi — Higgsfield devri",
        "",
        "Bu metni olduğu gibi claude.ai sohbetine yapıştır. Higgsfield bağlayıcısı, Claude Code'daki ile aynı hesapla bağlı olmalı.",
        "",
        "---",
        "",
        "Higgsfield MCP ile aşağıdaki görselleri üret. Kurallar:",
        "",
        "1. **Model ve ayarlar:** `model: nano_banana_pro`, `aspect_ratio: 16:9`, `resolution: 2k`.",
        f"2. **Üslup referansı:** her isteğe `medias: [{{\"value\": \"{ref}\", \"role\": \"image_references\"}}]` ekle. Bu, daha önce üretilmiş bir işin kimliği; yükleme gerekmez.",
        "3. **Yalnız sınırsız deneme hakkı:** her istekte `use_unlim: true`. Kredi harcama. Bir istek sınırsız hakla reddedilirse krediyle tekrar deneme. Önce `models_explore` ile sınırsız hakkın kapsadığı ayarlara bak; 2k kapsam dışıysa `1k` ile dene. O da olmazsa dur ve hangi istemde kaldığını yaz.",
        f"4. **Varyant:** her istemden {varyant} ayrı üretim (her biri ayrı istek). Birden çok istek için `generate_image_batch`, bekleme için `jobs_wait` kullan.",
        "5. **İstemleri değiştirme:** aşağıdaki istem metnini harfiyen gönder; kısaltma, ekleme, çeviri yok.",
        "6. **Denetim:** her sonuca bak. Şunlardan biri varsa o varyantı bir kez yeniden üret ve tabloya not düş:",
        "   - görünür bir yüz (göz, burun, ağız seçiliyorsa);",
        "   - istemde istenmeyen bir insan, el, kol ya da beden parçası (özellikle `s12-kumas`: tam dört çift el olmalı, beşinci el ya da kol olmamalı);",
        "   - yazı, harf, logo, filigran; minare, kubbe, hilal, kemer, çini;",
        "   - yeşil perdeli istemlerde zeminin düz yeşil olmaması.",
        "7. **Sonuç:** sonunda şu tabloyu ver (kod bloğu içinde, düz metin): `istem_id | varyant | job_id | durum | not`. Dosyaları indirmen gerekmiyor; Claude Code aynı hesaptan iş kimlikleriyle çeker.",
        "",
        f"Toplam: {len(istemler)} istem × {varyant} varyant = {len(istemler) * varyant} üretim.",
        "",
    ]
    for k in istemler:
        satirlar += [f"## {k['id']}", "", "```text", birlestir(uslup, k), "```", ""]

    cikti = kaynak.with_name(kaynak.stem + "-devir.md")
    cikti.write_text("\n".join(satirlar), encoding="utf-8")
    print(f"{cikti} ({len(istemler)} istem, {len(istemler) * varyant} üretim)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
