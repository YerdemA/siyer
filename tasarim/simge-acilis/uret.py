"""Uygulama simgesi ve açılış ekranı taslaklarını SVG olarak üretir.

Kullanım (depo kökünden):
  python tasarim/simge-acilis/uret.py

Renkler app/lib/tema.dart → Palet ile aynıdır. Çıktılar bu klasöre yazılır;
onizleme.html hepsini maskelerle ve küçük boyutta gösterir.
"""
import math
from pathlib import Path

KLASOR = Path(__file__).resolve().parent

# app/lib/tema.dart → Palet
KAGIT_ACIK = "#F3E8CF"
KAGIT = "#E6D3A8"
KAGIT_KOYU = "#D5BE8E"
MUREKKEP = "#3B2716"
MUREKKEP_SOLUK = "#6E5236"
KINA = "#9C3B22"
ALTIN = "#C2913F"
GECE = "#1E2230"
SERIF = "'Noto Serif', Georgia, 'Times New Roman', serif"


def parsomen_zemin(w: int, h: int, kimlik: str) -> str:
    """Parşömen dolgu + kenar kararması tanımları ve dikdörtgen."""
    return f"""
  <defs>
    <radialGradient id="{kimlik}-kararma" cx="50%" cy="48%" r="70%">
      <stop offset="0.55" stop-color="{MUREKKEP}" stop-opacity="0"/>
      <stop offset="1" stop-color="{MUREKKEP}" stop-opacity="0.32"/>
    </radialGradient>
    <filter id="{kimlik}-doku" x="0" y="0" width="100%" height="100%">
      <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="7"/>
      <feColorMatrix values="0 0 0 0 0.23  0 0 0 0 0.15  0 0 0 0 0.09  0 0 0 0.09 0"/>
      <feComposite in2="SourceGraphic" operator="in"/>
    </filter>
  </defs>
  <rect width="{w}" height="{h}" fill="{KAGIT}"/>
  <rect width="{w}" height="{h}" fill="{KAGIT}" filter="url(#{kimlik}-doku)"/>
  <rect width="{w}" height="{h}" fill="url(#{kimlik}-kararma)"/>"""


def yildiz(cx: float, cy: float, r: float, renk: str, ic: float = 0.0, ic_renk: str = "") -> str:
    """Sekiz köşeli yıldız (iç içe iki kare); isteğe bağlı iç daire."""
    kareler = []
    for aci in (0, 45):
        noktalar = []
        for k in range(4):
            a = math.radians(aci + 45 + k * 90)
            noktalar.append(f"{cx + r * math.cos(a):.1f},{cy + r * math.sin(a):.1f}")
        kareler.append(f'<polygon points="{" ".join(noktalar)}" fill="{renk}"/>')
    daire = f'<circle cx="{cx}" cy="{cy}" r="{ic}" fill="{ic_renk}"/>' if ic else ""
    return "\n    ".join(kareler) + daire


def muhur(cx: float, cy: float, r: float, zemin: str = KINA, yazi: str = KAGIT_ACIK) -> str:
    """Kına kırmızısı mühür: çift halka, nokta dizisi, ortada sekiz köşeli yıldız."""
    noktalar = "".join(
        f'<circle cx="{cx + r * 0.80 * math.cos(math.radians(a)):.1f}" '
        f'cy="{cy + r * 0.80 * math.sin(math.radians(a)):.1f}" r="{r * 0.025:.1f}" fill="{yazi}"/>'
        for a in range(0, 360, 15)
    )
    return f"""
  <g>
    <circle cx="{cx}" cy="{cy}" r="{r * 1.04}" fill="{MUREKKEP}" opacity="0.18" transform="translate({r * 0.03} {r * 0.05})"/>
    <circle cx="{cx}" cy="{cy}" r="{r}" fill="{zemin}"/>
    <circle cx="{cx}" cy="{cy}" r="{r * 0.92}" fill="none" stroke="{yazi}" stroke-width="{r * 0.025}"/>
    <circle cx="{cx}" cy="{cy}" r="{r * 0.68}" fill="none" stroke="{yazi}" stroke-width="{r * 0.018}"/>
    {noktalar}
    {yildiz(cx, cy, r * 0.5, yazi, r * 0.2, zemin)}
    {yildiz(cx, cy, r * 0.15, yazi)}
  </g>"""


def pusula(cx: float, cy: float, r: float, koyu: str = MUREKKEP, acik: str = KAGIT_ACIK, altin: str = ALTIN) -> str:
    """Eski haritalardaki pusula gülü: sekiz kol, her kol yarı koyu yarı açık."""
    kollar = []
    for i in range(8):
        a = -math.pi / 2 + i * math.pi / 4
        uzun = r if i % 2 == 0 else r * 0.55
        ux, uy = cx + uzun * math.cos(a), cy + uzun * math.sin(a)
        yx, yy = r * 0.13 * math.cos(a + math.pi / 2), r * 0.13 * math.sin(a + math.pi / 2)
        kollar.append(f'<polygon points="{cx},{cy} {ux:.1f},{uy:.1f} {cx + yx:.1f},{cy + yy:.1f}" fill="{koyu}"/>')
        kollar.append(
            f'<polygon points="{cx},{cy} {ux:.1f},{uy:.1f} {cx - yx:.1f},{cy - yy:.1f}" fill="{acik}" '
            f'stroke="{koyu}" stroke-width="{r * 0.012:.1f}"/>'
        )
    return f"""
  <g>
    <circle cx="{cx}" cy="{cy}" r="{r * 0.82}" fill="none" stroke="{altin}" stroke-width="{r * 0.05}"/>
    <circle cx="{cx}" cy="{cy}" r="{r * 0.72}" fill="none" stroke="{koyu}" stroke-width="{r * 0.015}"/>
    {"".join(kollar)}
    <circle cx="{cx}" cy="{cy}" r="{r * 0.07}" fill="{KINA}"/>
  </g>"""


def noktali_yol(d: str, renk: str, kalinlik: float, aralik: float) -> str:
    return (
        f'<path d="{d}" fill="none" stroke="{renk}" stroke-width="{kalinlik}" '
        f'stroke-linecap="round" stroke-dasharray="0 {aralik}"/>'
    )


def carpi(cx: float, cy: float, r: float, renk: str = KINA) -> str:
    k = r * 0.28
    return f"""
  <g stroke="{renk}" stroke-width="{k}" stroke-linecap="round" fill="none">
    <path d="M{cx - r},{cy - r} Q{cx + r * 0.12},{cy - r * 0.1} {cx + r},{cy + r}"/>
    <path d="M{cx + r},{cy - r} Q{cx + r * 0.08},{cy + r * 0.12} {cx - r},{cy + r}"/>
  </g>"""


def kum_tepeleri(noktalar, s: float, renk: str = MUREKKEP, opaklik: float = 0.35) -> str:
    parca = []
    for x, y in noktalar:
        parca.append(
            f'<path d="M{x - s},{y} Q{x - s * 0.25},{y - s * 0.75} {x + s * 0.7},{y - s * 0.05}" />'
            f'<path d="M{x - s * 0.1},{y + s * 0.35} Q{x + s * 0.5},{y - s * 0.15} {x + s * 1.2},{y + s * 0.3}" opacity="0.7"/>'
        )
    return (
        f'<g fill="none" stroke="{renk}" stroke-width="{s * 0.09:.1f}" stroke-linecap="round" '
        f'opacity="{opaklik}">{"".join(parca)}</g>'
    )


def svg(w: int, h: int, govde: str) -> str:
    return f'<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}">{govde}\n</svg>\n'


# ---------------------------------------------------------------- simgeler
# 1024×1024; Android uyarlanabilir simgede önemli öğeler ortadaki %66'lık
# daire içinde kalır (maske kenarları kırpar).
S = 1024
SIMGELER = {
    "simge-1-muhur": (
        "Mühür",
        "Ana sayfadaki numara mührünün büyüğü: kına kırmızısı, çift halka, ortada sekiz köşeli yıldız. "
        "Küçük boyutta en okunaklı olan; uygulamanın 'damga' dilini taşır.",
        parsomen_zemin(S, S, "s1") + muhur(512, 512, 300),
    ),
    "simge-2-pusula": (
        "Pusula",
        "Haritadaki pusula gülü, altın halkayla. Yolculuk ve harita fikrini verir; dinî bir sembol taşımaz.",
        parsomen_zemin(S, S, "s2")
        + noktali_yol("M150,880 C330,760 260,600 470,560", MUREKKEP_SOLUK, 16, 34)
        + pusula(560, 470, 300),
    ),
    "simge-3-yol": (
        "Yol ve çarpı",
        "Ana sayfanın kendisi: kıvrılan noktalı yol ve hedefte kına kırmızısı çarpı. "
        "Uygulamanın 'yolculuk' anlatısına en yakın olanı; küçük boyutta noktalar silikleşebilir.",
        parsomen_zemin(S, S, "s3")
        + kum_tepeleri([(250, 330), (720, 760), (330, 760)], 70)
        + noktali_yol("M190,840 C420,820 300,600 520,560 C720,520 600,330 700,300", MUREKKEP, 26, 52)
        + carpi(720, 290, 120),
    ),
    "simge-4-gece-muhur": (
        "Gece mührü",
        "Mührün koyu sürümü: gece laciverdi zemin, altın mühür. Telefonun karanlık temasında ve "
        "parlak simgelerin arasında öne çıkar.",
        f'<rect width="{S}" height="{S}" fill="{GECE}"/>'
        + "".join(
            f'<circle cx="{x}" cy="{y}" r="{r}" fill="{KAGIT_ACIK}" opacity="0.5"/>'
            for x, y, r in [(170, 180, 5), (860, 220, 4), (820, 840, 5), (200, 820, 4), (520, 120, 3), (930, 560, 3)]
        )
        + muhur(512, 512, 300, zemin=ALTIN, yazi=GECE),
    ),
}

# ---------------------------------------------------------------- açılış
# 1080×1920 dikey; Android 12+ açılışında yalnız ortadaki simge ve zemin
# rengi gösterilir, tam ekran taslaklar eski sürümler ve marka ekranı içindir.
W, H = 1080, 1920


def baslik(renk: str, alt_renk: str, y: int) -> str:
    return f"""
  <text x="540" y="{y}" text-anchor="middle" font-family="{SERIF}" font-size="76" font-weight="700" fill="{renk}">Resulü Ekrem'in Hayatı</text>
  <text x="540" y="{y + 70}" text-anchor="middle" font-family="{SERIF}" font-size="40" font-style="italic" fill="{alt_renk}">Peygamberlik öncesi</text>"""


ACILISLAR = {
    "acilis-1-parsomen": (
        "Parşömen",
        "Uygulamanın kendi zemini: parşömen, ortada mühür, altta başlık ve aşağı inen noktalı yol "
        "(ana sayfaya geçişi müjdeler). Uygulamaya en tutarlı geçiş.",
        parsomen_zemin(W, H, "a1")
        + kum_tepeleri([(200, 360), (860, 300), (180, 1560), (900, 1640), (760, 520)], 60, opaklik=0.25)
        + muhur(540, 760, 230)
        + baslik(MUREKKEP, MUREKKEP_SOLUK, 1120)
        + noktali_yol("M540,1260 C600,1360 460,1440 540,1560 C600,1650 520,1720 540,1800", MUREKKEP, 12, 30),
    ),
    "acilis-2-gece": (
        "Gece",
        "Gece laciverdi zemin, seyrek yıldızlar, altın pusula ve parşömen renginde başlık. "
        "Hira'daki gecelere ve 'yolculuğa çıkış'a gönderme; karanlık temalı telefonlarda göz almaz.",
        f'<rect width="{W}" height="{H}" fill="{GECE}"/>'
        + "".join(
            f'<circle cx="{(i * 397) % W}" cy="{(i * 613) % 1300 + 60}" r="{2 + i % 3}" fill="{KAGIT_ACIK}" opacity="{0.25 + (i % 4) * 0.12:.2f}"/>'
            for i in range(1, 46)
        )
        + pusula(540, 760, 250, koyu=ALTIN, acik=GECE, altin=KAGIT_ACIK)
        + baslik(KAGIT_ACIK, ALTIN, 1150),
    ),
    "acilis-3-harita": (
        "Harita",
        "Haritanın kendisinden bir kesit: Kızıldeniz kıyısı, Şam'dan Mekke'ye inen kervan yolu ve "
        "Mekke'de çarpı; başlık üstte. Uygulamanın harita ve yolculuk özelliklerini tanıtır.",
        parsomen_zemin(W, H, "a3")
        + f'<path d="M0,820 L120,900 L230,1060 L300,1260 L380,1480 L470,1640 L560,1920 L0,1920 Z" fill="#C9C6A6"/>'
        + f'<path d="M0,820 L120,900 L230,1060 L300,1260 L380,1480 L470,1640 L560,1920" fill="none" stroke="{MUREKKEP}" stroke-width="5" opacity="0.85"/>'
        + "".join(
            f'<path d="M{-30 * k},{820} L{120 - 30 * k},900 L{230 - 30 * k},1060 L{300 - 30 * k},1260 L{380 - 30 * k},1480 L{470 - 30 * k},1640 L{560 - 30 * k},1920" fill="none" stroke="{MUREKKEP}" stroke-width="2" opacity="{0.3 - k * 0.07:.2f}"/>'
            for k in (1, 2, 3)
        )
        + kum_tepeleri([(760, 1100), (880, 1480), (640, 1700), (900, 900)], 55, opaklik=0.3)
        + noktali_yol("M260,640 C360,860 420,1040 470,1200 C520,1330 540,1380 560,1430", "#7A3B1E", 10, 26)
        + f'<circle cx="260" cy="640" r="16" fill="{KINA}" stroke="{MUREKKEP}" stroke-width="4"/>'
        + f'<text x="290" y="625" font-family="{SERIF}" font-size="38" font-style="italic" fill="{MUREKKEP}">Şam</text>'
        + carpi(565, 1440, 52)
        + f'<text x="640" y="1455" font-family="{SERIF}" font-size="42" font-style="italic" font-weight="700" fill="{MUREKKEP}">Mekke</text>'
        + pusula(900, 720, 90)
        + baslik(MUREKKEP, MUREKKEP_SOLUK, 300),
    ),
}


def onizleme() -> str:
    def kart(ad, baslik_, aciklama, tip):
        if tip == "simge":
            gorsel = f"""
        <div class="maskeler">
          <figure><img src="{ad}.svg" class="kare"><figcaption>Kare</figcaption></figure>
          <figure><img src="{ad}.svg" class="daire"><figcaption>Daire</figcaption></figure>
          <figure><img src="{ad}.svg" class="yuvarlak"><figcaption>Yuvarlak kare</figcaption></figure>
          <figure><img src="{ad}.svg" class="kucuk"><figcaption>48 px</figcaption></figure>
        </div>"""
        else:
            gorsel = f'<img src="{ad}.svg" class="acilis">'
        return f"""
      <section class="kart">
        <h3>{baslik_} <code>{ad}.svg</code></h3>
        {gorsel}
        <p>{aciklama}</p>
      </section>"""

    simgeler = "".join(kart(k, b, a, "simge") for k, (b, a, _) in SIMGELER.items())
    acilislar = "".join(kart(k, b, a, "acilis") for k, (b, a, _) in ACILISLAR.items())
    return f"""<!doctype html>
<html lang="tr"><head><meta charset="utf-8"><title>Simge ve açılış taslakları</title>
<style>
  body {{ margin: 0; padding: 32px; background: {KAGIT}; color: {MUREKKEP}; font-family: system-ui, sans-serif; }}
  h1, h2, h3 {{ font-family: {SERIF}; }}
  .izgara {{ display: grid; grid-template-columns: repeat(auto-fill, minmax(460px, 1fr)); gap: 24px; }}
  .kart {{ background: {KAGIT_ACIK}; border: 1px solid {MUREKKEP_SOLUK}; border-radius: 8px; padding: 16px; }}
  .kart p {{ font-size: 14px; line-height: 1.45; color: {MUREKKEP_SOLUK}; }}
  code {{ font-size: 12px; color: {MUREKKEP_SOLUK}; font-weight: normal; }}
  .maskeler {{ display: flex; gap: 14px; align-items: flex-end; }}
  figure {{ margin: 0; text-align: center; font-size: 11px; color: {MUREKKEP_SOLUK}; }}
  img.kare {{ width: 120px; height: 120px; }}
  img.daire {{ width: 120px; height: 120px; border-radius: 50%; }}
  img.yuvarlak {{ width: 120px; height: 120px; border-radius: 28%; }}
  img.kucuk {{ width: 48px; height: 48px; border-radius: 28%; }}
  img.acilis {{ width: 100%; max-width: 300px; display: block; margin: 0 auto; border-radius: 18px; border: 6px solid #111; }}
</style></head>
<body>
  <h1>Simge ve açılış ekranı taslakları</h1>
  <p>Renkler uygulamanın paletinden (app/lib/tema.dart). Simgeler Android maskeleriyle ve gerçek
  boyutunda (48 px) gösterilir. Kaynaklar SVG; <code>python tasarim/simge-acilis/uret.py</code> ile yeniden üretilir.</p>
  <h2>Simge</h2>
  <div class="izgara">{simgeler}</div>
  <h2>Açılış ekranı</h2>
  <div class="izgara">{acilislar}</div>
</body></html>
"""


def main() -> None:
    for ad, (_, _, govde) in SIMGELER.items():
        (KLASOR / f"{ad}.svg").write_text(svg(S, S, govde), encoding="utf-8")
    for ad, (_, _, govde) in ACILISLAR.items():
        (KLASOR / f"{ad}.svg").write_text(svg(W, H, govde), encoding="utf-8")
    (KLASOR / "onizleme.html").write_text(onizleme(), encoding="utf-8")
    print(f"{len(SIMGELER)} simge, {len(ACILISLAR)} açılış ekranı, onizleme.html → {KLASOR}")


if __name__ == "__main__":
    main()
