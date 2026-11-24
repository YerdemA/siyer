r"""Dinamizm turu (d1) görsellerini sahnelere yerleştirir (docs/DINAMIZM.md).

Her görsel, istem kaydındaki (content/gorseller/istemler/bXX.json, tur d1) sahnenin
ilk hedef parçasında başlayan ayrı bir çekim olur (tam dolu görsel, `ayar.gorsel`
olcek 1.05, `ton: false`).

Kurallar:
- Hedef parçada başlayan ve kendi katmanı olmayan (yalnız ana görseli kadrajlayan,
  yani ortak Mekke/Kâbe görüntüsü) çekim yeni görsele yer açmak için kaldırılır.
- Aynı parçaya düşen çekimler parça içinde `an` ile sıralanır (metin bölünmez).
- Hedef ilk parçaysa ana görsel açılış olarak kısa kalır, yeni görsel parçanın
  içinde (an ≈ 0.35) başlar.
- Boş bırakılan yere Efendimiz'in nuru gerekiyorsa NUR'daki ayarla katman eklenir.
- Zamanlama oynatıcıyla aynı hesaplanır (ses süresi ffprobe ile); 3 sn'den kısa
  kalan ya da oynatıcının atlayacağı çekim raporlanır.

Kullanım: .venv\Scripts\python.exe -I tools/d1_yerlestir.py b01 [--yaz]
(--yaz olmadan yalnız plan yazdırılır; görseller İndirilenler\siyer\yeni\'den okunur.)
"""
import json
import subprocess
import sys
from pathlib import Path

from PIL import Image

KOK = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(KOK / "tools"))
import gorsel_katman as gk  # noqa: E402

YENI = Path.home() / "Downloads/siyer/yeni"
GORSEL = KOK / "content/gorseller"
KAMERALAR = ["yavas-yaklasma", "yatay-kayma", "yavas-uzaklasma"]
GECIS = 0.8

# Türkçe tarif (oynatıcının tarif panelinde ve doğrulamada).
TARIF = {
    "b01-d-issiz-vadi": "Şafak, çıplak dağlar arasında bomboş bir vadi tabanı; tek bir kuru çalı, rüzgârın kaldırdığı ince kum.",
    "b01-d-vadi-tabani": "Yere yakın bakış: çatlamış kuru toprak ve taşlar; ne bitki ne ekin, uzakta çıplak yamaçlar.",
    "b01-d-safak-sirt": "Vadiden yukarı bakış: sivri, çıplak bir dağ sırtı; ilk ışık yalnız tepelere vuruyor.",
    "b01-d-temel-tamam": "Harçsız taşlardan alçak duvarın üst sırası: bir taş daha yerine konmuş, havada ince toz.",
    "b01-d-ziyaretciler": "İkindi: sade giyimli ziyaretçiler küçük gruplar hâlinde alçak, üstü açık Kâbe'ye yürüyor; uzakta birkaç çadır.",
    "b01-d-put-tasima": "Gece: üç Huzâalı, kaba yontulmuş taş bir putu tahta sedye üstünde Kâbe'ye taşıyor; öndeki meşale tutuyor.",
    "b01-d-kusay-ittifak": "Alacakaranlık: develi ve yaya müttefikler, elini kaldırıp konuşan Kusay'ın çevresinde.",
    "b01-d-ev-yapimi": "Gündüz, Kâbe çevresi: Kureyşliler kerpiç ve taştan evler yapıyor; kenarda keçi kılı çadır toplanıyor.",
    "b01-d-kabe-ic": "Şafak, eski Kâbe'nin içi: harçsız taş duvarlar, üstü açık; duvar diplerinde putlar, karşıda en büyükleri Hübel; yerde ağzı yarı örtülü kuyu.",
    "b01-d-uzlasma": "Akşam, Kâbe avlusu: iki ayrı gruptan iki yaşlı Kureyşli öne çıkıp birbirinin kolunu tutuyor.",
    "b01-d-putlar": "Şafak, Kâbe'nin çevresi: her biri farklı, Kâbe'den küçük kaba putlar ve dikili taşlar.",
    "b01-d-pazar": "Gündüz, Mekke'de pazar: dışarıdan gelen tüccarlar tahıl, hurma, kumaş ve deri seriyor; çökmüş develer.",
    "b01-d-antlasma": "Gündüz, kervan yolunda bir kabile yurdu: Hâşim kabile reisiyle el sıkışıyor; arkada adamları ve yüklü develer.",
    "b01-d-huzur": "Akşam, Mekke: aileler evlerinin önünde ekmek ve hurma paylaşıyor; ocak dumanları, arkada Kâbe.",
    "b01-d-siginma": "İkindi, bir kabile yurdu: devesini çeken yalnız yolcuyu reis elini uzatarak karşılıyor.",
    "b01-d-zulum": "Gündüz, bir kuyu başı: varlıklı bir adam yoksul yaşlıyı kuyudan itiyor; yaşlının kabı yere düşüyor.",
    "b02-d-develer-donus": "Gündüz: Habeşli askerler otlaktan alınan yüksüz deve sürüsünü sürüyor; sağda Kureyşliler karşılıyor.",
    "b02-d-ordu-hazir": "Şafak: Habeş ordusu saf saf dizilmiş, başında süslü baş örtülü fil; bir komutan buyruk veriyor.",
    "b03-d-kabileler": "Şafak, geniş Arap toprakları: sürüleriyle dağınık kabile yurtları, uzakta Mekke vadisi.",
    "b03-d-kura-oklari": "Kâbe'nin içi, yakın: bir bekçinin elleri deri sadaktan tüysüz fal oklarını çekiyor; arkada bulanık Hübel.",
    "b03-d-kabe-ic-kura": "Kâbe'nin içi: Hübel'in önünde bekçi fal oklarını kaldırıyor; Abdülmuttalib ve oğulları bekliyor, Abdullah arkadan.",
    "b03-d-on-deve": "Gündüz, Kâbe yakını: on deve sıra hâlinde; Abdullah arkadan, yanında Abdülmuttalib.",
    "b03-d-yesrib-hasta": "Gece, Yesrib'de bir oda: Abdullah yatakta, arkadan; iki yaşlı Neccâroğlu başı önde yanında oturuyor.",
    "b03-d-amine-bekleyis": "Alacakaranlık: Âmine kapı eşiğinde arkadan, kuzeye giden yola bakıyor.",
    "b03-d-kabe-ic-dua": "Kâbe'nin içi: Abdülmuttalib putlara sırtını dönmüş, arkadan, başını göğe kaldırmış dua ediyor.",
    "b03-d-sut-anne-arayis": "Gündüz, Mekke'nin girişi: Abdülmuttalib vadinin ağzında çöl yoluna bakıyor; uzakta yolcular.",
    "b04-d-kitlik": "Gündüz, kuraklıkta bir bedevi yurdu: çatlamış toprak, kaburgaları sayılan zayıf keçiler, direkte boş bir su tulumu.",
    "b04-d-mekkeye-donus": "İkindi, Mekke vadisine inen yol: Halîme eşeğinde arkadan, Hâris yanında yürüyor; ilk evler görünüyor.",
    "b04-d-ust-mahalle": "Gündüz, Mekke'nin üst mahallesi: dar, taşlı bir yokuş; Halîme arkadan, telaşla çıkıyor.",
    "b04-d-varaka-bulus": "Gündüz, Mekke'de bir sokak: Varaka ve bir Kureyşli yürüyor; aralarında Efendimiz'in nuru.",
    "b05-d-ev-avlu": "Sabah, Mekke'de küçük bir avlu: Âmine duvar dibinde arkadan oturuyor; önünde Efendimiz'in nuru.",
    "b05-d-gece-konak": "Gece, Yesrib yolunda konak: çökmüş develer, ateş başında Ümmü Eymen ve Âmine arkadan.",
    "b06-d-yol": "Gündüz, Mekke'de bir sokak: Ebû Tâlib yavaş yürüyor, yanındaki Efendimiz'in nuruna şefkatle bakıyor.",
    "b06-d-cobanlar": "Alacakaranlık, Mekke yakınında taş bir yalak: koyunlar su içiyor, yalağa dayalı bir çoban değneği.",
    "b06-d-bahira-soru": "Gündüz, Busrâ'daki manastırın önü: Bahîrâ taş sekide öne eğilmiş soru soruyor; karşısında Efendimiz'in nuru, arkada Kureyşliler.",
    "b06-d-bahira-yakin": "Bahîrâ yakın plan: gözleri sessiz bir hayretle açık, eli göğsünde.",
    "b07-d-ukaz-yakin": "Ukâz panayırında yakın: hasırlarda kumaş, deri, testiler, hurma; tüccar elleri küçük bir terazide tartıyor.",
    "b07-d-silah-birakma": "Ukâz'da: farklı kabilelerden adamlar kılıçlarını ve mızraklarını çadırın yanına bırakıyor; ikisi el sıkışıyor.",
    "b07-d-ovunen": "Ukâz'da: alçak bir kayaya çıkmış biri göğsünü gere gere övünüyor; aşağıdakiler öfkeli, işaret ediyor.",
    "b07-d-toz-savas": "İkindi, geniş bir ova: uzakta iki kalabalık toz bulutu içinde çarpışıyor; hiçbir şey seçilmiyor.",
    "b07-d-iki-saf": "Gündüz, geniş ova: iki kabile ordusu uzun saflar hâlinde karşı karşıya; arada boş toprak.",
    "b07-d-toplanma": "İkindi, Abdullah b. Cüd'ân'ın evinin kapısı: Kureyş boylarının yaşlıları birer birer geliyor, Zübeyr karşılıyor.",
    "b07-d-genc-katilim": "Gündüz, Abdullah b. Cüd'ân'ın avlusu: Kureyşliler yemin için halka olmuş; Zübeyr'in yanında Efendimiz'in nuru.",
    "b07-d-hak-teslim": "Gündüz, Mekke'de pazar sokağı: varlıklı bir adam bohçayı yabancı tüccara geri veriyor; arkada antlaşmanın üyeleri.",
    "b07-d-kizil-develer": "İkindi, taşlı bir ova: alçak güneşte kızıl tüylü develer otluyor; çoban yok.",
    "b08-d-emanet": "Gündüz, Mekke'de bir ev önü: iki Kureyşli mühürlü bir bohçayı Efendimiz'in nuruna uzatıyor.",
    "b08-d-rahip-meysere": "Gündüz, Busrâ yakınındaki manastırın yanı: yaşlı rahip Meysere'ye uzaktaki gölgeli ağacı gösteriyor.",
    "b08-d-kizlar": "Gündüz, Hz. Hatice'nin evinin avlusu: dört kız hasırda arkadan oturuyor; Hz. Hatice arkalarında, gölgede.",
    "b08-d-kasim-kabir": "Alacakaranlık, Mekke yakınında çıplak bir tepenin eteği: birkaç taşla belirlenmiş küçük, sade bir kabir.",
    "b08-d-hicret-yolu": "Şafak, kuzeye uzanan çöl yolu: develer üstünde birkaç kadın, çok küçük ve arkadan.",
    "b08-d-zeyd-kacirilis": "Gündüz, çöl: atlı akıncılar küçük bir oğlanı elinden tutup götürüyor; uzakta devedeki kadın arkasından uzanıyor.",
    "b08-d-hatice-oda": "Akşam, Hz. Hatice'nin evinde bir oda: Hz. Hatice minderde arkadan; önünde haberci kadın hafifçe eğiliyor.",
    "b08-d-kitlik": "Gündüz, kıtlıkta Mekke'de bir avlu: boş, devrik küpler, tek zayıf keçi, hasırda birkaç kuru hurma çekirdeği.",
    "b08-d-hatira": "Gece, bir oda: hasır üstünde minder, üzerinde katlanmış şarap kırmızısı bir pelerin; yanında kirmen ve küçük bir sandık.",
    "b09-d-duvar-boy": "Şafak, alçak Kâbe'nin köşesi yakından: harçsız taşlar; yanında bir Kureyşli yukarı bakıyor.",
    "b09-d-duveyk": "Gündüz, Mekke'de bir sokak: Kureyşliler açık bohça tutan Düveyk'i sıkıştırıyor, biri bohçayı gösteriyor.",
    "b09-d-kabe-ic-kuyu": "Kâbe'nin içi: biri hazinenin saklandığı kuyunun başında diz çökmüş; arkasında bir Kureyşli, duvar dibinde putlar.",
    "b09-d-kabe-ic-tavan": "Yeniden yapılan Kâbe'nin içi: bir sıra taş bir sıra ahşap hatıllı yüksek duvarlar, ağır kalaslı düz tavan, duvar boyunca merdiven.",
    "b09-d-yuksek-kapi": "Gündüz, yeni Kâbe'nin yerden yüksek tek kanatlı kapısı; dibinde bir Kureyşli yukarı bakıyor.",
    "b10-d-tepeden": "İkindi, Mekke'nin üstündeki kayalık yamaçtan (onun gözünden): vadide evler ve yeni, yüksek Kâbe.",
    "b10-d-tavaf-put": "Gündüz, Mekke vadisinde açık bir alan: kalabalık kaba bir taş putun çevresinde dönüyor, bazıları ona bez bağlıyor.",
    "b10-d-dagilis": "Şafak, Mekke dışında bir yol ayrımı: dört adam ayrı yollara dağılıyor, ikisi dönüp bakıyor.",
    "b10-d-varaka-kitap": "Gece, kandille aydınlanan küçük bir oda: Varaka hasırda oturmuş uzun bir tomar okuyor.",
    "b10-d-osman-bizans": "Gündüz, yüksek surlu bir Bizans şehrinin taş kapısı: Osman b. Hüveyris devesiyle geliyor, kapıda nöbetçiler.",
    "b10-d-yahudi-alim": "Gündüz, Şam'da taş bir evin gölgeli revakı: Zeyd b. Amr hasırda yaşlı bir Yahudi âlimi dinliyor.",
    "b10-d-hristiyan-alim": "Gündüz, Şam'da küçük taş bir manastırın önü: Zeyd b. Amr, elini kaldırıp konuşan yaşlı bir keşişi dinliyor.",
    "b10-d-zeyd-yuz-cevirme": "Gündüz, Mekke'de kaba bir taş putun yanı: adamlar düz taşa et sunuyor; yaşlı Zeyd elini kaldırıp yüz çeviriyor.",
    "b10-d-kiz-kurtarma": "Gündüz, Mekke'nin kenarı: yaşlı Zeyd sert bakışlı bir adamdan küçük bir kızın elini nazikçe alıyor; kız arkadan.",
    "b10-d-zeyd-kabir": "Alacakaranlık, kuru bir vadi: üst üste yığılmış taşlardan sade bir kabir, yanında tek bir dikenli çalı.",
}

# Yeni görsel gerekmeyen yerlerde mevcut bir d1 görselinin yeniden kullanımı (DINAMIZM.md):
# sahne → [(parça, d1 kimliği)]. Parçaya eski çekim gibi girer; aynı parçanın yeni görseli ardından.
YENIDEN = {
    "b01-s12": [(3, "b01-d-putlar")],   # Ca'fer'in sözleri: önce putlara tapma, sonra zulüm
}

# Boş bırakılan yere Efendimiz'in nuru (kadraj birimi; ayak noktası x, y; boy).
# Değerler görselin 16:9 kırpılmış hâline göre, ayar.gorsel olcek 1.05 hesaba katılarak.
NUR = {}


def sure(dosya):
    c = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", str(dosya)],
                       capture_output=True, text=True)
    return float(c.stdout.strip() or 0)


def parcalar(sahne, ses):
    kelime = [max(1, len(p["metin"].split())) for p in sahne["anlatim"]]
    t, cikti = 0.8, []
    for k in kelime:
        d = ses * k / sum(kelime)
        cikti.append((t, t + d))
        t += d
    return cikti


def katman(kayit):
    return {"id": kayit["katman"], "dosya": kayit["dosya"], "yerTutucu": "kapi-cercevesi", "derinlik": 0.6,
            "ayar": {"gorsel": {"x": 0.5, "y": 0.5, "olcek": 1.05}, "ton": False}}


def main(argv):
    bolum = argv[0]
    yaz = "--yaz" in argv
    kayitlar = json.loads((GORSEL / f"istemler/{bolum}.json").read_text(encoding="utf-8"))["istemler"]
    kayitlar = [k for k in kayitlar if k.get("tur") == "d1"]
    bolum_yolu = next((KOK / "content/tr/bolumler").glob(f"{bolum}-*.json"))
    b = json.loads(bolum_yolu.read_text(encoding="utf-8"))
    sahneler = {s["id"]: s for s in b["sahneler"]}

    hazir = []
    for k in kayitlar:
        png = YENI / f"{k['id']}.png"
        if png.exists():
            hazir.append(k)
        elif not any(any(l.get("dosya") == k["dosya"] for l in c.get("katmanlar", []))
                     for s in b["sahneler"] for c in [s["gorsel"], *s["gorsel"].get("cekimler", [])]):
            print(f"  görsel yok, atlandı: {k['id']}")
    sayac = 0
    for sid in sorted({k["sahne"] for k in hazir}):
        s = sahneler[sid]
        g = s["gorsel"]
        eski = g.get("cekimler", [])
        yeniler = [k for k in hazir if k["sahne"] == sid]
        hedefler = {k["parca"][0] for k in yeniler}
        kalan, kaldirilan = [], []
        for c in eski:
            ortak = not c.get("katmanlar") and c.get("parca") in hedefler and not c.get("an")
            (kaldirilan if ortak else kalan).append(c)
        tum = {k["id"]: k for k in kayitlar}
        for p, kid in YENIDEN.get(sid, []):
            kalan.append({"parca": p, "tarif": TARIF[kid], "kamera": "yavas-uzaklasma", "katmanlar": [katman(tum[kid])]})
        for k in yeniler:
            c = {"parca": k["parca"][0], "tarif": TARIF[k["id"]], "kamera": KAMERALAR[sayac % 3],
                 "katmanlar": [katman(k)] + ([NUR[k["id"]]] if k["id"] in NUR else [])}
            c["_yeni"] = k["id"]
            sayac += 1
            kalan.append(c)
        # Parça içinde sırala: eskiler (kendi an'ıyla) önce, yeniler ardından eşit aralıkla.
        gruplar = {}
        for c in kalan:
            gruplar.setdefault(c["parca"], []).append(c)
        sonuc = []
        for p in sorted(gruplar):
            grup = gruplar[p]
            eskiler = [c for c in grup if "_yeni" not in c]
            yeni_grup = [c for c in grup if "_yeni" in c]
            bas = 0.35 if p == 0 else (0.0 if not eskiler else 0.5)
            adim = (1 - bas) / max(1, len(yeni_grup)) if (p == 0 or eskiler) else 1 / len(yeni_grup)
            for i, c in enumerate(yeni_grup):
                a = round(bas + i * adim, 3)
                if a:
                    c["an"] = a
            grup = sorted(eskiler + yeni_grup, key=lambda c: c.get("an", 0))
            sonuc += grup
        # Zamanlama denetimi
        ses = sure(KOK / "content/tr/ses" / s["ses"]["anlatim"])
        pz = parcalar(s, ses)
        son_t = pz[-1][1] + 1.2
        print(f"{sid} ({ses:.1f} sn, {len(s['anlatim'])} parça)" + (f"  kaldırılan ortak çekim: {len(kaldirilan)}" if kaldirilan else ""))
        onceki = 0.0
        zamanlar = []
        for c in sonuc:
            b0, s0 = pz[c["parca"]]
            t = b0 + (s0 - b0) * c.get("an", 0)
            zamanlar.append(t)
        zamanlar.append(son_t)
        print(f"   0.0 ana görsel ({zamanlar[0]:.1f} sn)")
        for i, c in enumerate(sonuc):
            t = zamanlar[i]
            uyar = ""
            if t - GECIS < onceki - 1e-6:
                uyar = "  !! ATLANIR (öncekine çok yakın)"
            elif zamanlar[i + 1] - t < 3:
                uyar = "  ! kısa"
            ad = c.get("_yeni") or ("[" + ", ".join(l["dosya"] for l in c.get("katmanlar", [])) + "]" if c.get("katmanlar") else "kadraj")
            print(f"  {t:5.1f} p{c['parca']} an {c.get('an', 0):<5} {ad} ({zamanlar[i + 1] - t:.1f} sn){uyar}")
            onceki = t
        for c in sonuc:
            c.pop("_yeni", None)
        g["cekimler"] = sonuc
    if yaz:
        for k in hazir:
            img = gk.kirp_olcekle(Image.open(YENI / f"{k['id']}.png").convert("RGB"))
            img.save(GORSEL / k["dosya"], "WEBP", quality=72, method=6)
        bolum_yolu.write_text(json.dumps(b, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(f"yazıldı: {len(hazir)} görsel, {bolum_yolu.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
