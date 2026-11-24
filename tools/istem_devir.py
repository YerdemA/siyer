"""Görsel istem kaydından (content/gorseller/istemler/bXX.json) claude.ai'ye
verilecek tek parça devir metni üretir.

Kullanım (depo kökünden):
  .venv\\Scripts\\python.exe -I tools/istem_devir.py content/gorseller/istemler/b09.json [--varyant 2] [--atla u01,...] [--tur 4] [--chatgpt]

--tur d1: yalnız dinamizm turu (tools/dinamik_istemler.py); sayısal olmayan tur
ayrı dosyaya yazılır (<ad>-d1-chatgpt.md).
--chatgpt: Higgsfield yerine tek bir ChatGPT sohbetine sırayla yapıştırılacak
mesajlar (<ad>-chatgpt.md).
--sadece id1,id2: yalnız bu kimlikler; --chatgpt ile <ad>-<tur>-yeniden-chatgpt.md
dosyasına yazılır (reddedilen görsellerin yeniden üretimi; asıl mesaj dosyası korunur).
--karakterler [kimlik ...]: karakterler.json'dan referans sayfası mesajları
(karakterler-chatgpt.md).

Kayıtta "konu" alanı olan istemler yapılı biçimde yazılır (kamera, kişi sayısı,
karakter kartı, yerleşim, ışık, çıktı öncesi denetim); alanlar
docs/GORSEL_URETIM.md'de.

Çıktı aynı klasöre <ad>-devir.md olarak yazılır. Her istem; üslup istemi +
sahne istemi + yasaklar birleştirilmiş, son haliyle yer alır; claude.ai
tarafında hiçbir şey birleştirilmez ya da değiştirilmez.
"""
import json
import sys
from pathlib import Path


def birlestir(uslup: dict, kayit: dict) -> str:
    if "konu" in kayit:
        sahne = yapili_istem(kayit, _karakterler())
    else:
        sahne = kayit["istem"].replace("{yesil_perde_eki}", uslup["yesil_perde_eki"]).strip()
    return f"{uslup['istem']}\n\n{sahne}\n\n{uslup['yasaklar']}"


KARAKTER_DOSYASI = Path(__file__).resolve().parent.parent / "content/gorseller/istemler/karakterler.json"

# Yapılı istem (kayıtta "konu" alanı varsa). Alanlar docs/GORSEL_URETIM.md'de.
# tip: figur (yeşil perde, kırpılmadan sığdırılır, sahneye ayar.gorsel ile konur),
#      nesne (figur gibi, insan yok), zemin (alt kısmı dolu, ufkun üstü yeşil),
#      mekan (tam dolu iç/dış mekân, perde yok).
CEKIM = {
    "uzak": "Wide shot from far away, camera at standing eye level, looking straight ahead (no high angle, no bird's-eye view). People appear small.",
    "orta": "Medium-wide shot, camera at standing eye level, looking straight ahead (no high angle, no low angle). Full figures from head to feet.",
    "yakin": "Close shot, head and shoulders, camera at eye level, straight on or three-quarter view.",
    "detay": "Extreme close-up (macro detail), camera very close at eye level; only the described detail fills the frame.",
    "bakis":"Point of view of a person standing (or sitting, if stated) in the scene, at their eye level. The viewer's own body, hands, arms and feet never appear in the image.",
}
YERLESIM = {
    "figur": (
        "LAYOUT: Show every person and animal complete, from the top of the head (or head cloth) to the soles of the feet, "
        "with clear flat green space on all four sides (at least one tenth of the image width and height). "
        "Everyone stands on one and the same straight, horizontal foot line in the lower part of the image, at the same distance from the camera, "
        "arranged side by side from left to right. Never arrange figures in a line that recedes diagonally into the distance, "
        "and never place anyone higher in the image than the others. "
        "Draw NO ground, floor, cast shadow, horizon, rocks, plants, buildings, walls, doors, tents, mountains, sky or Kaaba: those are separate layers. "
        "Only the listed people, animals and hand-held objects, isolated on a perfectly flat, uniform chroma green background (#00B140), "
        "with no green tint on them."
    ),
    "yakin": (
        "LAYOUT: The figure is cut at mid-chest by the bottom edge of the image; clear flat green space above the head and on both sides. "
        "No background of any kind: perfectly flat, uniform chroma green (#00B140) behind the figure, no green tint on the figure."
    ),
    "nesne": (
        "LAYOUT: The object is shown complete with clear flat green space on all four sides (at least one tenth of the image). "
        "Draw only the object: no ground, cast shadow, people, hands or background; perfectly flat, uniform chroma green (#00B140) "
        "everywhere else, no green tint on the object."
    ),
}
ISIK_NOTR = (
    "LIGHT: even, neutral daylight from the front-left, soft paper shadows within the figures only. "
    "No sunset or night colouring, no dramatic light, no glow, no halo, no light rays (the app adds the time-of-day tint)."
)


def _karakterler() -> dict:
    return json.loads(KARAKTER_DOSYASI.read_text(encoding="utf-8"))["karakterler"]


def yapili_istem(kayit: dict, kartlar: dict) -> str:
    tip = kayit.get("tip", "figur")
    cekim = kayit.get("cekim", "orta")
    parcalar = [f"CAMERA: {CEKIM[cekim]}", f"SUBJECT: {kayit['konu'].strip()}"]

    kisiler = kayit.get("kisiler", [])
    insan = 0
    grup = False
    satirlar = []
    for n, k in enumerate(kisiler, 1):
        sayi = k.get("sayi", 1)
        if k.get("karakter"):
            tarif = kartlar[k["karakter"]]["en"]
        else:
            tarif = k["tarif"]
        if k.get("yaklasik"):
            # Kalabalık ve sürüde kesin sayı tutturulamaz; kaynak sayı vermiyorsa yaklaşık.
            grup = grup or not k.get("hayvan")
            adet = f"about {sayi} × "
        else:
            if not k.get("hayvan"):
                insan += sayi
            adet = f"{sayi} × " if sayi > 1 else ""
        tarif = tarif.rstrip(". ") + "."
        poz = f" Pose and place: {k['poz']}" if k.get("poz") else ""
        satirlar.append(f"{n}. {adet}{tarif}{poz}")
    if satirlar:
        if grup:
            baslik = (f"PEOPLE AND ANIMALS: draw only these; groups marked 'about' are approximate, every other item is an exact count"
                      f"{f' ({insan} individually listed people)' if insan else ''}. Keep every listed colour and feature exactly as written:")
        elif insan:
            baslik = (f"PEOPLE AND ANIMALS: draw exactly these and nobody else (exactly {insan} "
                      f"{'person' if insan == 1 else 'people'} in total). Keep every listed colour and feature exactly as written:")
        else:
            baslik = "ANIMALS AND OBJECTS: draw exactly these and no people:"
        parcalar.append(baslik + "\n" + "\n".join(satirlar))
    elif tip in ("zemin", "nesne"):
        parcalar.append("PEOPLE: none. No people, animals, hands or figures of any kind.")

    if tip == "zemin":
        ufuk = kayit.get("ufuk", 0.45)
        parcalar.append(
            f"LAYOUT: This is a ground layer. The horizon is a perfectly straight, horizontal line at {round(ufuk * 100)}% of the image height "
            "from the top; the ground fills everything below it to the bottom edge and to both side edges. "
            "Everything above the horizon is perfectly flat, uniform chroma green (#00B140): no sky, no clouds, no distant mountains. "
            "No green tint on the ground."
        )
    elif tip == "mekan":
        parcalar.append(
            "LAYOUT: Full frame, filled edge to edge; no green screen. Keep the important content inside the central area: "
            "the top 15%, the bottom 15% and 8% on each side will be cropped."
        )
    elif kayit.get("yerlesim") and tip == "nesne":
        perde = "Draw" + YERLESIM["nesne"].split("Draw", 1)[1]
        parcalar.append(f"LAYOUT: {kayit['yerlesim'].strip()} {perde}")
    elif kayit.get("yerlesim"):
        # Sürü, kalabalık gibi tek sıraya sığmayan figür katmanları için özel düzen;
        # perde kuralı aynen eklenir.
        perde = "Draw NO" + YERLESIM["figur"].split("Draw NO", 1)[1]
        if kayit.get("izin"):
            perde += f" The only exception: {kayit['izin'].strip()}"
        parcalar.append(f"LAYOUT: {kayit['yerlesim'].strip()} {perde}")
    else:
        metin = YERLESIM["yakin" if cekim == "yakin" else ("nesne" if tip == "nesne" else "figur")]
        if kayit.get("izin"):
            metin += f" The only exception: {kayit['izin'].strip()}"
        parcalar.append(metin)

    parcalar.append(kayit.get("isik") or ISIK_NOTR)
    if kayit.get("yasak"):
        parcalar.append(f"DO NOT DRAW: {kayit['yasak'].strip()}")
    denetim = [
        ("the individually listed people are all there, nobody extra" if grup else
         f"exactly {insan} {'person' if insan == 1 else 'people'}" if insan else "no people at all"),
        "every person has one head, two arms, two hands with five fingers each and two legs; no extra, missing, merged or floating hands, arms or legs",
        "every held object is held by a hand that belongs to a body",
        "faces appear only where allowed above; anyone marked 'from behind' shows no face, profile or cheek",
        "every clothing colour, beard colour and feature matches the description",
        "no text, letters, crosses, minarets, domes, crescents or glow",
    ]
    if tip in ("figur", "nesne"):
        denetim.append("the background is one flat, uniform green with no ground, horizon or shadow")
    if kayit.get("denetim"):
        # Genel liste bu görsele uymuyorsa (ör. göz yakın planındaki ışıklar) kayıt kendi listesini verir.
        denetim = kayit["denetim"]
    parcalar.append("BEFORE YOU OUTPUT, CHECK AND FIX: " + "; ".join(denetim) + ".")
    return "\n\n".join(parcalar)


KISA_YASAK = (
    "Rules: faces only for people the prompt allows, in simple paper cut-out style; no extra people beyond what is described; "
    "the Prophet never appears unless this prompt explicitly asks for him; "
    "no other prophet in any form; no minarets, domes, crescents, arches or tiles; no text or watermarks."
)


def mesaj(uslup: dict, k: dict, kartlar: dict) -> tuple[str, list[str]]:
    """Tek görselin istem metni ve iliştirilecek referans dosya adları.
    ChatGPT mesaj dosyası da API betiği (gorsel_uret.py) de bunu kullanır."""
    if "konu" in k:
        sahne = yapili_istem(k, kartlar)
    else:
        sahne = k["istem"].replace("{yesil_perde_eki}", uslup["yesil_perde_eki"]).strip()
    # Sıcak altın-beyaz yalnız nura ayrılmıştır (docs/GORSEL_USLUP.md → Renk ve ışık).
    nur_ister = "golden-white" in k.get("istem", k.get("konu", ""))
    nur_yasak = "" if nur_ister else (
        " No soft golden-white glow or halo anywhere; torch flames are orange-red, daylight is neutral."
    )
    # Yakın çekimde uzak çekimle tutarlılık için o sahnenin uzak görseli eklenir;
    # yapılı istemde ayrıca geçen her karakterin referans sayfası.
    ek = k.get("ekle", [])
    ekle = [e for e in ([ek] if isinstance(ek, str) else ek) if e]
    ekle += [f"karakter-{p['karakter']}.png" for p in k.get("kisiler", [])
             if p.get("karakter") and kartlar[p["karakter"]].get("referans_sayfasi", True)]
    ekle = list(dict.fromkeys(ekle))
    ek_cumle = ""
    if ekle:
        ek_cumle = (
            " The images attached to this message are references: character sheets show exactly how each named "
            "character must look (face, beard, clothing colours); object or building references (throne, sanctuary, houses) show exactly how that object must look; a wide shot shows the same scene. "
            "Match them exactly, but do not copy their composition or background."
        )
    if "konu" in k:
        metin = (
            f"Scene {k['id']}. ONE image, landscape 3:2. Flat paper cut-out style of the style reference: layered "
            f"textured paper shapes, muted earth palette; not photorealistic, not a 3D render.{ek_cumle}\n\n"
            f"{sahne}\n\n{KISA_YASAK}{nur_yasak}"
        )
    else:
        metin = (
            f"Scene {k['id']}. Keep the flat paper cut-out style of the reference image: layered textured paper shapes, "
            f"muted earth palette. Not photorealistic, not a 3D render.{ek_cumle} {sahne}\n\n{KISA_YASAK}{nur_yasak}"
        )
    return metin, ekle


def chatgpt(veri: dict, istemler: list[dict], kaynak: Path, ek: str = "") -> Path:
    """Tek ChatGPT sohbeti için: ilk mesaj üslubu ve kuralları sabitler, sonraki
    her mesaj tek görsel ister. ChatGPT 16:9 vermez; 3:2 yatay istenir. 16:9'a
    kırpma ve %10 taşma payıyla 1536×1024 görselin dinlenik kadrajda görünen
    kısmı yaklaşık x 128–1408, y 152–872'dir (yanlardan %8, üst/alttan %15)."""
    uslup = veri["uslup"]
    ilk = (
        "I am making a respectful documentary motion comic about the life of the Prophet in 6th- and 7th-century Arabia. "
        "The attached image is the style reference: match its paper cut-out look, palette and texture in every image I ask for in this chat. "
        "Use it only for style, not composition.\n\n"
        f"Style: {uslup['istem'].replace('Cinematic 16:9 framing.', 'Cinematic wide framing.')}\n\n"
        f"Strict rules for every image: {uslup['yasaklar']}\n\n"
        "Format for every image: landscape 3:2. Green-screen images are cut-out layers placed later over separate "
        "sky, mountain, ground and building layers: draw only what the message lists, complete and with green margin around it, "
        "and never draw any background, ground or shadow on them. Full-frame images will be cropped about 15% at the top and bottom "
        "and 8% on each side, so keep important elements inside that central area. "
        "Each message describes every person exactly (age, beard, clothing colours); the same named person must look identical "
        "in every image of this chat. Before outputting, always count people, arms, hands and legs and fix any error. "
        "Generate exactly one image per message. "
        "Do not reply with text beyond one short line. Reply 'Ready' now; I will send the scenes one by one."
    )
    satirlar = [
        f"# {veri['bolum']}: ChatGPT ile görsel üretimi",
        "",
        "**Hazırlık:** ChatGPT'de yeni bir sohbet aç. Üslup referansı olarak seçilen görseli (u01-d) ekle ve **Mesaj 0**'ı gönder.",
        f"Referans dosyası: Higgsfield galerisindeki iş `{uslup['referans']['is_id']}` ya da `content/gorseller/istemler/referans/uslup-u01d.png`.",
        "",
        "**Akış:** Mesajları sırayla, her birini ayrı gönder. Her görseli `İndirilenler\\siyer` klasörüne, "
        "mesaj başlığındaki kimlikle kaydet (ör. `b02-d-kasva.png`). Atladığın olursa Claude Code'a söyle.",
        "",
        "**Uzun sohbet üslubu kaydırır.** Görseller fotoğraf gibi olmaya başlarsa yeni sohbet aç, Mesaj 0'ı görselle yeniden gönder, kaldığın yerden devam et.",
        "",
        "**Görsel kötü çıkarsa** (yüz fotoğraf gibi ya da istenmeyen kişide görünüyor, fazladan el var, yazı çıkmış, yeşil zemin düz değil, nur istenmeyen yerde altın-beyaz parıltı var) "
        "aynı sohbette şunu yaz ve yenisini indir: "
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
    kartlar = _karakterler()
    for n, k in enumerate(istemler, 1):
        metin, ekle = mesaj(uslup, k, kartlar)
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
        if ekle:
            satirlar += ["**Bu mesaja ekle** (`content/gorseller/istemler/referans/` klasöründen): " + ", ".join(f"`{e}`" for e in ekle), ""]
        if notlar:
            satirlar += [f"*Kontrol: {'; '.join(notlar)}*", ""]
        satirlar += ["```text", metin, "```", ""]
    cikti = kaynak.with_name(kaynak.stem + ek + "-chatgpt.md")
    cikti.write_text("\n".join(satirlar), encoding="utf-8")
    return cikti


def karakter_sayfa_metni(i: str, k: dict) -> str:
    """Bir karakterin referans sayfası istemi (ChatGPT dosyası ve gorsel_uret.py ortak)."""
    if k.get("hayvan"):
        gorunum = "the same animal three times side by side: side view facing left, front three-quarter view, side view facing right"
    elif k.get("yuzsuz"):
        gorunum = ("the same person three times side by side, ALL WITHOUT ANY FACE: back view, back three-quarter view "
                   "from behind the left shoulder, back three-quarter view from behind the right shoulder")
    else:
        gorunum = "the same person three times side by side: front view, three-quarter view, side profile view"
    return (
        f"Character reference sheet {i}. ONE image, landscape 3:2. Flat paper cut-out style of the style reference; "
        "not photorealistic, not a 3D render.\n\n"
        f"CHARACTER: {k['en']}\n\n"
        f"LAYOUT: {gorunum}; full figure from head to feet, all three the same size, standing on one horizontal line, "
        "with flat green space around each. Perfectly flat, uniform chroma green background (#00B140), no ground, no shadow, "
        "no text or labels.\n\n"
        "LIGHT: even, neutral daylight; no glow.\n\n"
        "BEFORE YOU OUTPUT, CHECK AND FIX: all three views show the same person with identical clothing colours, beard and features; "
        "two arms, two hands with five fingers, two legs each; nothing else in the image."
    )


def karakter_sayfalari(idler: list[str] | None = None) -> Path:
    """Her karakter için bir referans sayfası: aynı kişi yan yana birkaç açıdan,
    yeşil perdede. Sonraki her istemde ilgili sayfa mesaja eklenir; görseller
    arası tutarlılığın (kural 2) asıl güvencesi budur."""
    kartlar = _karakterler()
    secilen = [i for i in kartlar if kartlar[i].get("referans_sayfasi", True) and not kartlar[i].get("referans_dosya")
               and (not idler or i in idler)]
    satirlar = [
        "# Karakter referans sayfaları: ChatGPT",
        "",
        "Bölüm istemlerinden ÖNCE üretilir. Mesaj 0'ı (üslup ve kurallar) bölüm dosyasındakiyle aynı gönder, sonra bunları sırayla.",
        "Her sayfayı `İndirilenler\\siyer` klasörüne `karakter-<kimlik>.png` adıyla kaydet ya da `tools/gorsel_al.py` ile adlandır.",
        "Claude Code her sayfayı karttaki tarifle karşılaştırır; onaylanan sayfa `content/gorseller/istemler/referans/` klasörüne konur ve o karakterin geçtiği her mesaja iliştirilir. Referans sayfası zaten olan karakterler (`referans_dosya` alanı dolu: Abdülmuttalib, Ebrehe, Vehb, Abdullah, Nüfeyl, Habeşli asker, fil) için sayfa üretilmez.",
        "",
    ]
    for n, i in enumerate(secilen, 1):
        k = kartlar[i]
        metin = karakter_sayfa_metni(i, k)
        satirlar += [f"## Sayfa {n}: karakter-{i}", "", f"*Kontrol: {k['ad']}. Kaynak: {k['kaynak']} Seçim: {k['secim']}*", "",
                     "```text", metin, "```", ""]
    cikti = KARAKTER_DOSYASI.with_name("karakterler-chatgpt.md")
    cikti.write_text("\n".join(satirlar), encoding="utf-8")
    return cikti


def main(argv: list[str]) -> int:
    if "--karakterler" in argv:
        idler = [a for a in argv if not a.startswith("--")]
        cikti = karakter_sayfalari(idler or None)
        print(cikti)
        return 0
    yollar = [a for a in argv if not a.startswith("--")]
    if not yollar:
        print(__doc__)
        return 2
    varyant = 2
    atla: set[str] = set()
    sadece: set[str] = set()
    for i, a in enumerate(argv):
        if a == "--varyant":
            varyant = int(argv[i + 1])
        if a == "--atla":
            atla = set(argv[i + 1].split(","))
        if a == "--tur":
            turlar = set(argv[i + 1].split(","))
        if a == "--sadece":
            sadece = set(argv[i + 1].split(","))
    yollar = [y for y in yollar if y.endswith(".json")]

    kaynak = Path(yollar[0])
    veri = json.loads(kaynak.read_text(encoding="utf-8"))
    uslup = veri["uslup"]
    ref = uslup["referans"]["is_id"]
    istemler = [k for k in veri["istemler"] if k["id"] not in atla]
    if "--tur" in argv:
        istemler = [k for k in istemler if str(k.get("tur")) in turlar]
    if sadece:
        istemler = [k for k in istemler if k["id"] in sadece]

    if "--chatgpt" in argv:
        # Sayısal olmayan tur (ör. d1) ayrı dosyaya yazılır; eski turların mesaj dosyası korunur.
        ek = ""
        if "--tur" in argv and not all(t.isdigit() for t in turlar):
            ek = "-" + "-".join(sorted(turlar))
        if sadece:
            ek += "-yeniden"
        cikti = chatgpt(veri, istemler, kaynak, ek)
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
