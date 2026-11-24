"""b04-s07 göz dizisinin çekimlerini hesaplar ve bölüm dosyasına yazar.

Akış (Erdem, 2026-11-24): yamaç (ana görsel, nur) → üç çocuk aynı yere bakıyor →
üçü önden → kamera en soldaki çocuğun gözlerine yaklaşır ve fark edilmeden göz
yakın planına geçer → kamera sağa kayarak A'nın sol/sağ, B'nin sol/sağ, C'nin
sol/sağ gözünü gösterir; her gözde olayın bir anı.

Yüzden göze geçiş: önden görsel ile göz görseli aynı "dünyaya" yerleştirilir.
Göz görseli, önden görselde A'nın gözlerinin üstüne [OLCEK] kat küçültülmüş bir
yama gibi oturur. İki çekim de aynı noktaya aynı üstel hızla yaklaşır; geçiş
sırasında göz görseli (kenarları yumuşatılmış kopyası) yamanın içinde belirir.

Ölçüler (piksel, 1536×1024 özgün; 16:9 kırpma üstten 80 px):
- Önden görsel, A'nın göz bebekleri: sol (211.6, 469.4), sağ (354.5, 461.1).
- Göz görselleri (üçünde de aynı): yansıma dairesi merkezi sol (340, 628), sağ (1172, 628).

Kullanım: python tools/goz_dizisi.py  (sonra icerik_dogrula, icerik_esitle)
"""
import json
import math
from pathlib import Path

KOK = Path(__file__).resolve().parent.parent
BOLUM = KOK / "content/tr/bolumler/b04-sut-anne.json"


def n(px, py):
    """Özgün pikseli 16:9 kırpılmış görselde 0–1 konuma çevirir."""
    return px / 1536, (py - 80) / 864


A_SOL, A_SAG = n(211.6, 469.4), n(354.5, 461.1)
G_SOL, G_SAG = n(340, 628), n(1172, 628)
OLCEK = (G_SAG[0] - G_SOL[0]) / (A_SAG[0] - A_SOL[0])  # göz görseli / önden görsel
A_ORTA = ((A_SOL[0] + A_SAG[0]) / 2, (A_SOL[1] + A_SAG[1]) / 2)
G_ORTA = ((G_SOL[0] + G_SAG[0]) / 2, (G_SOL[1] + G_SAG[1]) / 2)


def dunyaya(u, v):
    """Göz görselindeki noktanın önden görseldeki karşılığı."""
    return A_ORTA[0] + (u - G_ORTA[0]) / OLCEK, A_ORTA[1] + (v - G_ORTA[1]) / OLCEK


# Göz yakın planı: yakınlık ve kamera sınırları (kenar görünmesin).
Z = 1.74
U_MIN, U_MAX = 1 / (2 * Z) + 0.002, 1 - 1 / (2 * Z) - 0.002
V = G_SOL[1]

# Parça süreleri sesten, kelime sayısına göre (oynatıcıyla aynı hesap).
SES = 23.6
BAS = 0.8


def parcalar(sahne):
    kelime = [max(1, len(p["metin"].split())) for p in sahne["anlatim"]]
    t, cikti = BAS, []
    for k in kelime:
        d = SES * k / sum(kelime)
        cikti.append((t, t + d))
        t += d
    return cikti


def yer(t, pz):
    """Sahne içi saniyeyi (parça, an) çiftine çevirir."""
    for i, (b, s) in enumerate(pz):
        if b <= t < s:
            return i, round((t - b) / (s - b), 4)
    raise ValueError(t)


def kadraj(x, y, z):
    return {"x": round(x, 4), "y": round(y, 4), "yakinlik": round(z, 3)}


def katman(id_, dosya):
    return {"id": id_, "dosya": dosya, "yerTutucu": "kapi-cercevesi", "derinlik": 0.6,
            "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.0}, "ton": False}}


def main():
    b = json.loads(BOLUM.read_text(encoding="utf-8"))
    s = next(x for x in b["sahneler"] if x["id"] == "b04-s07")
    pz = parcalar(s)

    # --- Yaklaşma: önden görselde A'ya, sonra göze (dünya koordinatı) ---
    # Yaklaşmanın göz görselindeki hedefi: sol göze yakın, ama yumuşak kenar (%4) görünmesin
    # diye geçiş bittiğinde yakınlık >= 1 / (2 * (U_YAK - 0.04)) olmalı.
    U_YAK = 0.30
    X, Y = dunyaya(U_YAK, V)
    T_O1, G_O1 = 3.1, 0.6             # önden 1: tam kadrajdan A'nın yüzüne
    T_O2, G_O2 = 4.2, 0.2             # önden 2: aynı noktaya üstel yaklaşma
    Z0 = 3.4                          # önden 2 başında yakınlık
    T_G, G_G = 5.9, 1.3               # göz görseli (yumuşak kenarlı) geçişi
    T_H = 6.15                        # göz görseli tam yakınlıkta (Z_SON); geçişten 0,05 sn sonra
    Z_SON = 2.0                       # sonra tutuşta 1.74'e açılır
    t0 = T_O2 - G_O2
    k = math.log(Z_SON * OLCEK / Z0) / (T_H - t0)

    def zd(t):
        return Z0 * math.exp(k * (t - t0))

    cekimler = []

    def ekle(t, gecis, tarif, katmanlar, yol, kamera="sabit"):
        p, a = yer(t, pz)
        c = {"parca": p}
        if a:
            c["an"] = a
        c.update({"gecis": gecis, "tarif": tarif, "kamera": kamera, "katmanlar": katmanlar})
        if yol:
            c["yol"] = yol
        cekimler.append(c)

    ekle(1.7, 0.8, "Üç çocuk yan yana, hepsi kadrajın solundaki aynı noktaya kilitlenmiş, şaşkın bakıyor; baktıkları görünmez.",
         [{"id": "bakis", "dosya": "b04-d-cocuk-bakis.webp", "yerTutucu": "kalabalik", "derinlik": 0.6,
           "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.05}, "ton": False}}],
         None, kamera="yavas-yaklasma")
    ekle(T_O1, G_O1, "Üç çocuk önden, izleyiciye bakar gibi şaşkın; kamera en soldaki çocuğun yüzüne kayar.",
         [katman("onden", "b04-d-cocuk-onden.webp")],
         {"bas": kadraj(0.5, 0.5, 1.0), "son": kadraj(X, Y, Z0)})
    ekle(T_O2, G_O2, "Aynı görüntü: kamera en soldaki çocuğun gözlerine yaklaşır.",
         [katman("onden", "b04-d-cocuk-onden.webp")],
         {"bas": kadraj(X, Y, zd(t0)), "son": kadraj(X, Y, zd(T_G)), "egri": "duz"})
    ug = U_YAK
    ekle(T_G, G_G, "Birinci çocuğun gözleri; yaklaşma sürerken önden görüntüden fark edilmeden geçilir. Sol gözde Cebrâil'in gelişi (ışık).",
         [katman("gozler", "b04-d-gozler-a-gecis.webp")],
         {"bas": kadraj(ug, V, zd(T_G - G_G) / OLCEK), "son": kadraj(ug, V, zd(T_H) / OLCEK), "egri": "duz"})

    def cocuk(dosya, harf, t_sol, g_sol, t_kay, t_sag, sol, sag, u_bas=U_MIN, z_bas=Z):
        ekle(t_sol, g_sol, f"{harf} çocuğun sol gözü: {sol}",
             [katman("gozler", dosya)],
             {"bas": kadraj(u_bas, V, z_bas), "son": kadraj(max(u_bas, U_MIN) + 0.04, V, Z), "egri": "duz"})
        ekle(t_kay, 0.2, f"{harf} çocuğun gözleri: kamera sol gözden sağ göze kayar.",
             [katman("gozler", dosya)],
             {"bas": kadraj(max(u_bas, U_MIN) + 0.04, V, Z), "son": kadraj(U_MAX - 0.05, V, Z)})
        ekle(t_sag, 0.2, f"{harf} çocuğun sağ gözü: {sag}",
             [katman("gozler", dosya)],
             {"bas": kadraj(U_MAX - 0.05, V, Z), "son": kadraj(U_MAX, V, Z), "egri": "duz"})

    cocuk("b04-d-gozler-a.webp", "Birinci", T_H, 0.2, 7.0, 7.9,
          "yansımada beyaz ışık sütunu inmiş, altın küre yanında.",
          "yansımada altın küre yere yatmış, beyaz ışık kemer gibi üstüne eğilmiş.", u_bas=U_YAK, z_bas=Z_SON)
    cocuk("b04-d-gozler-b.webp", "İkinci", 9.3, 0.8, 11.2, 12.4,
          "yansımada kemerin altında küreden parlak kıvılcım (kalp) yükseliyor.",
          "yansımada kıvılcımdan koyu bir iz (pıhtı) ayrılıp duman gibi dağılıyor.")
    cocuk("b04-d-gozler-c.webp", "Üçüncü", 17.9, 0.8, 21.0, 22.2,
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
    g["cekimler"] = cekimler
    BOLUM.write_text(json.dumps(b, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"ölçek {OLCEK:.3f}, dünya hedefi ({X:.4f}, {Y:.4f}), üstel hız {k:.3f}/sn, {len(cekimler)} çekim")
    for c in cekimler:
        print(c["parca"], c.get("an", 0), c["gecis"], c["katmanlar"][0]["dosya"], c.get("yol", {}).get("bas"), "->", c.get("yol", {}).get("son"))


if __name__ == "__main__":
    main()
