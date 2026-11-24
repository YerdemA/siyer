r"""b04-s07 göz dizisinin çekimlerini hesaplar ve bölüm dosyasına yazar (üçüncü yol).

Akış (Erdem, 2026-11-25): yamaç (ana görsel, nur) → üç çocuk aynı yere bakıyor →
üçü önden → kamera en soldaki çocuğun gözlerine yaklaşır, yüz yakın planına geçilir →
üç çocuğun yüzü yan yana (tools/yuz_birlestir.py, b04-d-yuzler.webp); kamera hiçbir
efekt olmadan sağa kayar (Efendimiz her yansımada oynatıcının nuru): A sol göz, A sağ göz, B sol, B sağ, C sol, C sağ. Ses durağı
yok; süreler anlatımın kendi akışından.

Tek geçiş, önden görselden yüzlere: birleşik görselin ilk 1536 px'i (kenarı yumuşak,
b04-d-yuz-a-gecis.webp), önden görselde A'nın gözlerinin üstüne ölçekli bir yama gibi
oturur; ikisi aynı noktaya aynı üstel hızla yaklaşır.

Kullanım: .venv\Scripts\python.exe -I tools/goz_dizisi.py  (önce tools/yuz_birlestir.py; sonra icerik_dogrula, icerik_esitle)
"""
import json
import math
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import yuz_birlestir as yb  # noqa: E402

KOK = Path(__file__).resolve().parent.parent
BOLUM = KOK / "content/tr/bolumler/b04-sut-anne.json"

# Önden görselde A'nın göz bebekleri (özgün 1536×1024 px; kirpik dışarıda ölçüldü).
A_SOL, A_SAG = (211.7, 481.2), (349.8, 476.2)


def onden(px, py):
    return px / 1536, (py - 80) / 864


A_ORTA = onden((A_SOL[0] + A_SAG[0]) / 2, (A_SOL[1] + A_SAG[1]) / 2)
GOZ_ARALIK = yb.GOZLER["a"][1][0] - yb.GOZLER["a"][0][0]                # birleşik görselde
OLCEK = GOZ_ARALIK / (A_SAG[0] - A_SOL[0])                               # yüzler / önden
GEN_K = (yb.GEN + 2 * yb.ARALIK) / yb.GEN                                # birleşik genişlik, kadraj biriminde
V = yb.GOZ_Y / yb.YUK


def goz(c, sag):
    """Birleşik görselde c çocuğunun sol/sağ gözünün x'i (kadraj birimi)."""
    i = "abc".index(c)
    merkez = yb.GEN / 2 + i * yb.ARALIK
    return (merkez + (GOZ_ARALIK / 2 if sag else -GOZ_ARALIK / 2)) / yb.GEN


def dunyaya(u, v):
    """Yamadaki (birleşik görselin ilk kadrajı) noktanın önden görseldeki karşılığı."""
    return A_ORTA[0] + (u - 0.5) / OLCEK, A_ORTA[1] + (v - V) / OLCEK


Z = 1.7                    # gözde durunca yakınlık
U_YAK, Z_YAK = 0.30, 2.2   # yaklaşmanın sonu; yumuşak kenar (%4) görünmesin
Z_ONDEN = 3.4
SES, BAS = 23.6, 0.8


# Efendimiz yansımada oynatıcının nuru (Erdem, 2026-11-25). Silinen altın topların merkezi
# (yüz görselinde px; eski/yeni farkından), duruşu ve göz bebeği dairesi (merkez, yarıçap).
NUR_BOY = 100              # px (yüz görselinde); kuzulardan belirgin uzun, yatıkken de seçilsin
NUR_R = 176                # göz bebeği dairesi yarıçapı (px), halkanın içinde kalsın
NURLAR = [
    # (çocuk, göz, top x, top y, yatık mı, havada mı)
    ("a", 0, 456, 626, False, True),    # Cebrâil'in gelişi: ayakta
    ("a", 1, 1066, 677, True, False),   # yere yatırıldı
    ("b", 0, 471, 682, True, False),    # kalbin çıkarılışı
    ("b", 1, 1050, 682, True, False),   # pıhtı
    ("c", 0, 402, 700, True, False),    # leğende yıkanış
    ("c", 1, 1023, 649, False, True),   # yerine konuldu, ayakta
]


def nur_katmanlari(sadece=None):
    """Birleşik görselde (kadraj birimi) her göze nur; [sadece] verilirse yalnız o çocuk."""
    cikti = []
    for i, (c, sag, x, y, yatik, havada) in enumerate(NURLAR):
        if sadece and c != sadece:
            continue
        (gx, gy) = yb.GOZLER[c][sag]
        dx, dy, o = yb.birlesik_nokta(c, gx, gy)
        boy = NUR_BOY * o
        if yatik:
            # Ayak noktası sağda; -90° dönünce figür sola, yere uzanır. Gövde yere değsin.
            zemin = y + 22
            ax, ay, _ = yb.birlesik_nokta(c, x + NUR_BOY / 2, zemin - NUR_BOY * 0.17)
        else:
            ax, ay, _ = yb.birlesik_nokta(c, x, y + (34 if havada else 28))
        ayar = {"x": round(ax / yb.GEN, 4), "y": round(ay / yb.YUK, 4), "boy": round(boy / yb.YUK, 4),
                "guc": 3.0, "kim": "efendimiz", "hemen": True,
                "daire": {"x": round(dx / yb.GEN, 4), "y": round(dy / yb.YUK, 4), "r": round(NUR_R * o / yb.GEN, 4)}}
        if yatik:
            ayar["aci"] = -90
        cikti.append({"id": f"nur-{c}{sag}", "dosya": "", "yerTutucu": "nur", "derinlik": 0.6, "ayar": ayar})
    return cikti


def parcalar(sahne):
    kelime = [max(1, len(p["metin"].split())) for p in sahne["anlatim"]]
    t, cikti = BAS, []
    for k in kelime:
        d = SES * k / sum(kelime)
        cikti.append((t, t + d))
        t += d
    return cikti


def kadraj(x, y, z):
    return {"x": round(x, 4), "y": round(y, 4), "yakinlik": round(z, 3)}


def tam(id_, dosya, x=0.5, olcek=1.0):
    return {"id": id_, "dosya": dosya, "yerTutucu": "kapi-cercevesi", "derinlik": 0.6,
            "ayar": {"gorsel": {"x": round(x, 4), "y": 0.5, "olcek": round(olcek, 4)}, "ton": False}}


def main():
    b = json.loads(BOLUM.read_text(encoding="utf-8"))
    s = next(x for x in b["sahneler"] if x["id"] == "b04-s07")
    pz = parcalar(s)
    cekimler = []

    def ekle(t, gecis, tarif, katmanlar, yol=None, kamera="sabit"):
        for i, (b0, s0) in enumerate(pz):
            if b0 <= t < s0:
                c = {"parca": i}
                a = round((t - b0) / (s0 - b0), 4)
                if a:
                    c["an"] = a
                break
        else:
            raise ValueError(t)
        c.update({"gecis": gecis, "tarif": tarif, "kamera": kamera, "katmanlar": katmanlar})
        if yol:
            c["yol"] = yol
        cekimler.append(c)

    onden_k = [tam("onden", "b04-d-cocuk-onden.webp")]
    yuzler = [tam("yuzler", "b04-d-yuzler.webp", x=GEN_K / 2, olcek=GEN_K)] + nur_katmanlari()

    ekle(1.7, 0.7, "Üç çocuk yan yana, hepsi kadrajın solundaki aynı noktaya kilitlenmiş, şaşkın bakıyor; baktıkları görünmez.",
         [{"id": "bakis", "dosya": "b04-d-cocuk-bakis.webp", "yerTutucu": "kalabalik", "derinlik": 0.6,
           "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.05}, "ton": False}}], kamera="yavas-yaklasma")

    # Önden: A'nın yüzüne kay, sonra gözlerine üstel yaklaş; yama (yüzlerin ilk kadrajı) belirir.
    X, Y = dunyaya(U_YAK, V)
    T_O1, T_O2, T_G, G_G, T_H = 3.0, 3.9, 5.9, 1.3, 6.15
    ekle(T_O1, 0.6, "Üç çocuk önden, izleyiciye bakar gibi şaşkın; kamera en soldaki çocuğun yüzüne kayar.", onden_k,
         {"bas": kadraj(0.5, 0.5, 1.0), "son": kadraj(X, Y, Z_ONDEN)})
    t0 = T_O2 - 0.2
    k = math.log(Z_YAK * OLCEK / Z_ONDEN) / (T_H - t0)

    def zd(t):
        return Z_ONDEN * math.exp(k * (t - t0))

    assert zd(T_G) / OLCEK >= 1 / (2 * (U_YAK - 0.04)), zd(T_G) / OLCEK
    ekle(T_O2, 0.2, "Aynı görüntü: kamera en soldaki çocuğun gözlerine yaklaşır.", onden_k,
         {"bas": kadraj(X, Y, zd(t0)), "son": kadraj(X, Y, zd(T_G)), "egri": "duz"})
    ekle(T_G, G_G, "Birinci çocuğun gözleri, yakın plan; yaklaşma sürerken önden görüntüden fark edilmeden geçilir.",
         [tam("yama", "b04-d-yuz-a-gecis.webp")] + nur_katmanlari("a"),
         {"bas": kadraj(U_YAK, V, zd(T_G - G_G) / OLCEK), "son": kadraj(U_YAK, V, Z_YAK), "egri": "duz"})

    # Yüzler: kamera sağa kayar. Duruşta hafif sürüklenme (düz), aradaki kayma yumuşak.
    x_max = GEN_K - 1 / (2 * Z) - 0.001
    duruslar = [
        (T_H, U_YAK, Z_YAK, 7.0, U_YAK, "Birinci çocuğun sol gözü: yansımada beyaz ışık sütunu inmiş, altın ışık topu yanında."),
        (7.9, goz("a", True), Z, 8.9, goz("a", True) + 0.01, "Birinci çocuğun sağ gözü: top çimene inmiş, sütun hemen yanında."),
        (10.1, goz("b", False), Z, 11.5, goz("b", False) + 0.01, "İkinci çocuğun sol gözü: toptan parlak kıvılcım (kalp) yükseliyor."),
        (12.4, goz("b", True), Z, 16.9, goz("b", True) + 0.02, "İkinci çocuğun sağ gözü: kıvılcımdan koyu bir iz (pıhtı) ayrılıp dağılıyor."),
        (18.2, goz("c", False), Z, 21.8, goz("c", False) + 0.015, "Üçüncü çocuğun sol gözü: kıvılcım altın leğende, suyun üstünde."),
        (22.7, goz("c", True), Z, None, goz("c", True), "Üçüncü çocuğun sağ gözü: kıvılcım topa dönmüş, sütun göğe çekiliyor."),
    ]
    onceki = None
    for (t_bas, x0, z0, t_son, x1, tarif) in duruslar:
        x0, x1 = min(x0, x_max), min(x1, x_max)
        if onceki is not None:
            ox, oz, ot = onceki
            ekle(ot, 0.2, "Kamera yüzler boyunca sağa kayar.", yuzler,
                 {"bas": kadraj(ox, V, oz), "son": kadraj(x0, V, z0)})
        ekle(t_bas, 0.2, tarif, yuzler, {"bas": kadraj(x0, V, z0), "son": kadraj(x1, V, Z), "egri": "duz"})
        onceki = (x1, Z, t_son)

    g = s["gorsel"]
    g["tarif"] = ("Gündüz, Sa'doğulları yurdunda otlu bir yamaç: uzakta kuzular arasında oynayan üç çocuk (arkadan); "
                  "solda boş bırakılan yerde Efendimiz'in nuru. Olay bundan sonra çocukların gözlerindeki yansımayla anlatılır.")
    g["katmanlar"] = [
        {"id": "oyun", "dosya": "b04-d-oyun.webp", "yerTutucu": "zemin", "derinlik": 0.6,
         "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.05}, "ton": False}},
        {"id": "nur", "dosya": "", "yerTutucu": "nur", "derinlik": 0.6,
         "ayar": {"x": 0.36, "y": 0.624, "boy": 0.17, "guc": 2.5, "kim": "efendimiz"}},
    ]
    g["kamera"] = "yavas-yaklasma"
    g["cekimler"] = cekimler
    s["ses"].pop("duraklar", None)
    BOLUM.write_text(json.dumps(b, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"ölçek {OLCEK:.3f}, birleşik genişlik {GEN_K:.3f} kadraj, {len(cekimler)} çekim")


if __name__ == "__main__":
    main()
