"""b04-s07 göz dizisinin çekimlerini ve ses duraklarını hesaplar, bölüm dosyasına yazar.

Akış (Erdem, 2026-11-24): yamaç (ana görsel, nur) → üç çocuk aynı yere bakıyor →
üçü önden → kamera en soldaki çocuğun gözlerine yaklaşır, fark edilmeden göz yakın
planına geçer → sol göz → kamera sağ göze kayar → sağ göz → kamera yüze geri çekilir,
önden görselde sıradaki çocuğa kayar, onun gözlerine girer → … (üç çocuk, altı an).

İkinci sürüm (Erdem: "gözler arası geçiş çok kötü", "sahne çok hızlı"): çocuklar arası
çapraz geçiş (iki göz üst üste) kaldırıldı; geçişler hep önden görsel üzerinden, aynı
"dünyada". Anlatım sesine dokunulmadan cümle aralarındaki sessizliklere duraklar kondu.

Dünya: önden görsel (0–1). Her çocuğun göz görseli, önden görselde o çocuğun gözlerinin
üstüne ölçek kat küçük bir yama gibi oturur. Önden ve göz çekimleri aynı noktaya aynı
üstel hızla yaklaştığında, göz görseli (kenarı yumuşatılmış kopyası) yamanın içinde
belirir; geçiş seçilmez.

Ölçüler (piksel, 1536×1024 özgün; 16:9 kırpma üstten 80 px):
- Önden görsel göz bebekleri (koyu kahve, kirpik dışarıda): A (211.7, 481.2) (349.8, 476.2),
  B (720.4, 506.2) (854.4, 506.2), C (1224.7, 562.2) (1354.1, 560.0).
- Göz görselleri (üçünde aynı): yansıma dairesi merkezi sol (340, 628), sağ (1172, 628).
- Ses sessizlikleri: ffmpeg silencedetect (noise=-40dB, d=0.12); duraklar ortalarında.

Kullanım: python tools/goz_dizisi.py  (sonra icerik_dogrula, icerik_esitle)
"""
import json
import math
from pathlib import Path

KOK = Path(__file__).resolve().parent.parent
BOLUM = KOK / "content/tr/bolumler/b04-sut-anne.json"


def n(px, py):
    return px / 1536, (py - 80) / 864


G_SOL, G_SAG = n(340, 628), n(1172, 628)
G_ORTA = ((G_SOL[0] + G_SAG[0]) / 2, G_SOL[1])
V = G_SOL[1]
BEBEK = {
    "a": (n(211.7, 481.2), n(349.8, 476.2)),
    "b": (n(720.4, 506.2), n(854.4, 506.2)),
    "c": (n(1224.7, 562.2), n(1354.1, 560.0)),
}


def olcek(c):
    sol, sag = BEBEK[c]
    return (G_SAG[0] - G_SOL[0]) / (sag[0] - sol[0])


def dunyaya(c, u, v):
    """c çocuğunun göz görselindeki (u, v) noktasının önden görseldeki karşılığı."""
    sol, sag = BEBEK[c]
    s = olcek(c)
    return (sol[0] + sag[0]) / 2 + (u - G_ORTA[0]) / s, (sol[1] + sag[1]) / 2 + (v - G_ORTA[1]) / s


# Göz yakın planı (kenar görünmesin diye u sınırları).
Z = 1.74
U_MIN, U_MAX = 1 / (2 * Z) + 0.002, 1 - 1 / (2 * Z) - 0.002
U_YAK, Z_YAK = 0.30, 2.2   # yaklaşma hedefi; yumuşak kenar (%4) için z >= 1/(2*(U_YAK-0.04))
Z_ONDEN = 3.4              # önden görselde çocuğun yüzüne kayınca yakınlık

# Ses ve duraklar (sesin içindeki an, bekleme saniyesi).
SES = 23.6
BAS = 0.8
SONU = 1.2
DURAKLAR = [
    (6.45, 6.0),   # "…Cebrâil geldi." → önden görünüş, yaklaşma, ilk an
    (8.30, 6.5),   # "Onu yere yatırdı," → sağ gözde kal, ikinci çocuğa geç
    (10.65, 3.5),  # "…kalbini çıkardı;" → kıvılcımda kal
    (16.40, 6.5),  # "…payıydı» dedi." → pıhtıda kal, üçüncü çocuğa geç
    (21.20, 3.2),  # "…yıkadı," → leğende kal
    (23.50, 3.0),  # "…yerine koydu." → ışığın çekilişinde kal
]


def zamani(a, bitis=False):
    """Sesin a. saniyesinin sahne zamanı (oynatıcıdaki hesapla aynı)."""
    return BAS + a + sum(s for d, s in DURAKLAR if (d < a if bitis else d <= a))


def parcalar(sahne):
    kelime = [max(1, len(p["metin"].split())) for p in sahne["anlatim"]]
    a, cikti = 0.0, []
    for k in kelime:
        d = SES * k / sum(kelime)
        cikti.append((zamani(a), zamani(a + d, bitis=True)))
        a += d
    return cikti


def kadraj(x, y, z):
    return {"x": round(x, 4), "y": round(y, 4), "yakinlik": round(z, 3)}


def katman(id_, dosya):
    return {"id": id_, "dosya": dosya, "yerTutucu": "kapi-cercevesi", "derinlik": 0.6,
            "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.0}, "ton": False}}


class Kurgu:
    def __init__(self, pz):
        self.pz = pz
        self.cekimler = []

    def yer(self, t):
        for i, (b, s) in enumerate(self.pz):
            if b <= t < s:
                return i, round((t - b) / (s - b), 4)
        raise ValueError(t)

    def ekle(self, t, gecis, tarif, katmanlar, yol=None, kamera="sabit"):
        p, a = self.yer(t)
        c = {"parca": p}
        if a:
            c["an"] = a
        c.update({"gecis": gecis, "tarif": tarif, "kamera": kamera, "katmanlar": katmanlar})
        if yol:
            c["yol"] = yol
        self.cekimler.append(c)

    def yaklas(self, c, harf, t_kay, t_ust, t_goz, g_goz, t_tut, bas):
        """Önden görselde [bas] kadrajından c çocuğunun yüzüne kayar, sonra gözlerine
        üstel yaklaşır; göz görseli t_goz'da tam görünür, t_tut'ta yakınlık Z_YAK olur."""
        X, Y = dunyaya(c, U_YAK, V)
        s = olcek(c)
        self.ekle(t_kay[0], t_kay[1], f"Önden üç çocuk; kamera {harf} çocuğun yüzüne kayar.",
                  [katman("onden", "b04-d-cocuk-onden.webp")],
                  {"bas": bas, "son": kadraj(X, Y, Z_ONDEN)})
        t0 = t_ust - 0.2
        k = math.log(Z_YAK * s / Z_ONDEN) / (t_tut - t0)

        def zd(t):
            return Z_ONDEN * math.exp(k * (t - t0))

        assert zd(t_goz) / s >= 1 / (2 * (U_YAK - 0.04)) - 0.03, (harf, zd(t_goz) / s)
        self.ekle(t_ust, 0.2, f"Aynı görüntü: kamera {harf} çocuğun gözlerine yaklaşır.",
                  [katman("onden", "b04-d-cocuk-onden.webp")],
                  {"bas": kadraj(X, Y, zd(t0)), "son": kadraj(X, Y, zd(t_goz)), "egri": "duz"})
        self.ekle(t_goz, g_goz, f"{harf.capitalize()} çocuğun gözleri; yaklaşma sürerken önden görüntüden fark edilmeden geçilir.",
                  [katman("gozler", f"b04-d-gozler-{c}-gecis.webp")],
                  {"bas": kadraj(U_YAK, V, zd(t_goz - g_goz) / s), "son": kadraj(U_YAK, V, zd(t_tut) / s), "egri": "duz"})

    def gozler(self, c, harf, t_tut, t_kay, t_sag, sol, sag):
        """Sol gözde kal (Z_YAK'tan Z'ye açılarak), sağ göze kay, sağ gözde kal."""
        dosya = f"b04-d-gozler-{c}.webp"
        self.ekle(t_tut, 0.2, f"{harf.capitalize()} çocuğun sol gözü: {sol}", [katman("gozler", dosya)],
                  {"bas": kadraj(U_YAK, V, Z_YAK), "son": kadraj(U_YAK + 0.03, V, Z), "egri": "duz"})
        self.ekle(t_kay, 0.2, f"{harf.capitalize()} çocuğun gözleri: kamera yavaşça sol gözden sağ göze kayar.",
                  [katman("gozler", dosya)],
                  {"bas": kadraj(U_YAK + 0.03, V, Z), "son": kadraj(U_MAX - 0.04, V, Z)})
        self.ekle(t_sag, 0.2, f"{harf.capitalize()} çocuğun sağ gözü: {sag}", [katman("gozler", dosya)],
                  {"bas": kadraj(U_MAX - 0.04, V, Z), "son": kadraj(U_MAX, V, Z), "egri": "duz"})

    def geri_cekil(self, c, harf, t, t_dur):
        """Sağ gözden yüzün tamamına (göz görseli tam kadraj) geri çekilir, t_dur'da
        durur. Önden görsel ancak bu duruşta belirir; ikisi de durgunken üst üste
        biner, gözler kaymaz."""
        dosya = f"b04-d-gozler-{c}.webp"
        self.ekle(t, 0.2, f"{harf.capitalize()} çocuğun gözlerinden geri çekilir; iki göz birden görünür.",
                  [katman("gozler", dosya)],
                  {"bas": kadraj(U_MAX, V, Z), "son": kadraj(0.5, 0.5, 1.0)})
        self.ekle(t_dur, 0.2, f"{harf.capitalize()} çocuğun iki gözü, durgun.", [katman("gozler", dosya)],
                  {"bas": kadraj(0.5, 0.5, 1.0), "son": kadraj(0.5, 0.5, 1.0)})

    @staticmethod
    def bas_kadraji(c):
        """Geri çekilmenin sonunun önden görseldeki karşılığı (göz görseli tam kadraj)."""
        X, Y = dunyaya(c, 0.5, 0.5)
        return kadraj(X, Y, olcek(c))


def main():
    b = json.loads(BOLUM.read_text(encoding="utf-8"))
    s = next(x for x in b["sahneler"] if x["id"] == "b04-s07")
    pz = parcalar(s)
    k = Kurgu(pz)

    k.ekle(3.4, 0.9, "Üç çocuk yan yana, hepsi kadrajın solundaki aynı noktaya kilitlenmiş, şaşkın bakıyor; baktıkları görünmez.",
           [{"id": "bakis", "dosya": "b04-d-cocuk-bakis.webp", "yerTutucu": "kalabalik", "derinlik": 0.6,
             "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.05}, "ton": False}}],
           kamera="yavas-yaklasma")
    # A: "…Cebrâil geldi." sonrası durakta (7.25–13.25).
    k.yaklas("a", "birinci", (7.6, 1.0), 8.6, 11.4, 1.8, 11.65, kadraj(0.5, 0.5, 1.0))
    k.gozler("a", "birinci", 11.65, 12.6, 13.8,
             "yansımada beyaz ışık sütunu inmiş, altın küre yanında.",
             "yansımada altın küre yere yatmış, beyaz ışık kemer gibi üstüne eğilmiş.")
    # A → B: "Onu yere yatırdı," sonrası durakta (15.1–21.6).
    k.geri_cekil("a", "birinci", 16.0, 17.3)
    k.yaklas("b", "ikinci", (18.0, 0.6), 19.6, 21.6, 1.6, 21.85, k.bas_kadraji("a"))
    k.gozler("b", "ikinci", 21.85, 26.2, 27.4,
             "yansımada kemerin altında küreden parlak kıvılcım (kalp) yükseliyor.",
             "yansımada kıvılcımdan koyu bir iz (pıhtı) ayrılıp duman gibi dağılıyor.")
    # B → C: "…dedi." sonrası durakta (33.2–39.7).
    k.geri_cekil("b", "ikinci", 34.0, 35.3)
    k.yaklas("c", "üçüncü", (36.0, 0.6), 37.6, 39.6, 1.6, 39.85, k.bas_kadraji("b"))
    k.gozler("c", "üçüncü", 39.85, 46.2, 47.6,
             "yansımada kıvılcım altın leğende, suyun üstünde; damlalar düşüyor.",
             "yansımada kıvılcım yerine dönmüş, küre ayakta; beyaz ışık göğe çekiliyor.")

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
    g["cekimler"] = k.cekimler
    s["ses"]["duraklar"] = [{"an": a, "sure": d} for a, d in DURAKLAR]
    BOLUM.write_text(json.dumps(b, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    son = zamani(SES, bitis=True) + SONU
    print(f"ölçek a {olcek('a'):.2f}, b {olcek('b'):.2f}, c {olcek('c'):.2f}; {len(k.cekimler)} çekim; sahne {son:.1f} sn")
    for (b0, s0), p in zip(pz, s["anlatim"]):
        print(f"  parça {b0:5.2f}-{s0:5.2f}  {p['metin'][:40]}")


if __name__ == "__main__":
    main()
