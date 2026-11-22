"""Elle görsel üretimi için yerel yardımcı (ChatGPT).

Kullanım (depo kökünden):
  python tools/gorsel_yardimci.py            # tarayıcıda http://127.0.0.1:8765 açılır

Ne yapar:
- `content/gorseller/istemler/*-chatgpt.md` mesaj dosyalarını okur; her mesajı
  kart olarak gösterir (eksik olanlar önce). Mesaj 0 (üslup) en üstte.
- "Ekleri kopyala": mesajın referans görsellerini panoya dosya olarak koyar;
  ChatGPT'de Ctrl+V ile eklenir. Olmazsa "Klasörde aç" ekleri tek klasöre
  koyup Explorer'da açar (Ctrl+A ile sürükle).
- "İstemi kopyala": istem metnini panoya koyar ve mesajı indirme kuyruğuna ekler.
- İndirilenler ve İndirilenler\\siyer klasörlerini izler. Yeni bir görsel
  inince kuyruğun başındaki kimlikle `İndirilenler\\siyer\\yeni\\<kimlik>.png`
  olarak taşır. Kuyruk boşsa görsel "atanmamış" listesine düşer, oradan
  kimlik seçilir. Aynı kimlikte görsel varsa eskisi `yeni\\_onceki\\`'ne gider.

Yalnız 127.0.0.1'de dinler; dışarıya bağlanmaz.
"""
import json
import os
import re
import shutil
import subprocess
import sys
import threading
import time
import webbrowser
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse

KOK = Path(__file__).resolve().parent.parent
ISTEM = KOK / "content/gorseller/istemler"
REFERANS = ISTEM / "referans"
GORSELLER = KOK / "content/gorseller"
INDIRILENLER = Path.home() / "Downloads"
SIYER = INDIRILENLER / "siyer"
YENI = SIYER / "yeni"
ARSIV = SIYER / "arsiv"
EKLER = SIYER / "_ekler"
IZLENEN = [INDIRILENLER, SIYER]
GORSEL_UZANTI = {".png", ".jpg", ".jpeg", ".webp"}
PORT = 8765

kilit = threading.Lock()
kuyruk: list[str] = []          # indirme bekleyen kimlikler (sırayla)
atanmamis: list[str] = []       # kuyruk boşken inen dosyaların tam yolu
olaylar: list[dict] = []        # son atamalar (en yeni sonda)


# ---------------------------------------------------------------- mesajlar

def mesajlari_oku(md: Path) -> dict:
    t = md.read_text(encoding="utf-8").replace("\r\n", "\n")
    parcalar = re.split(r"^## Mesaj (\d+): (.*)$", t, flags=re.M)
    baslik = parcalar[0].strip()
    mesajlar = []
    for i in range(1, len(parcalar), 3):
        no, ad, govde = int(parcalar[i]), parcalar[i + 1].strip(), parcalar[i + 2]
        istem = re.search(r"```text\n(.*?)\n```", govde, flags=re.S)
        ekle_satiri = next((s for s in govde.split("\n") if s.startswith("**Bu mesaja ekle**")), "")
        ekler = re.findall(r"`([^`/\\]+\.png)`", ekle_satiri)
        kontrol = next((s.strip("*") for s in govde.split("\n") if s.startswith("*Kontrol:")), "")
        kimlik = ad if re.fullmatch(r"b\d\d-[\w-]+", ad) else None
        if no == 0:  # üslup referansı başlıkta yol olarak geçer; örnek dosya adları atlanır
            ekler = [Path(e).name for e in re.findall(r"`([^`]+\.png)`", baslik) if (REFERANS / Path(e).name).exists()]
        mesajlar.append({"no": no, "ad": ad, "kimlik": kimlik, "istem": istem.group(1) if istem else "",
                         "ekler": [e for e in ekler if (REFERANS / e).exists()],
                         "eksik_ekler": [e for e in ekler if not (REFERANS / e).exists()],
                         "kontrol": kontrol, "durum": durum(kimlik) if kimlik else ""})
    return {"baslik": baslik, "mesajlar": mesajlar}


def durum(kimlik: str) -> str:
    if (GORSELLER / f"{kimlik}.webp").exists():
        return "islendi"
    bolum = kimlik[:3]
    for uz in GORSEL_UZANTI:
        if (ARSIV / bolum / f"{kimlik}{uz}").exists():
            return "islendi"
    for uz in GORSEL_UZANTI:
        if (YENI / f"{kimlik}{uz}").exists():
            return "indirildi"
    return "eksik"


# ---------------------------------------------------------------- izleme

def gorsel_mi(p: Path) -> bool:
    return p.is_file() and p.suffix.lower() in GORSEL_UZANTI


def izlenecek_mi(p: Path) -> bool:
    # Bizim ürettiğimiz ya da zaten adlandırılmış dosyalar (bXX-..., _onizleme...) atlanır.
    return gorsel_mi(p) and not re.match(r"(b\d\d-|_)", p.name)


def mevcut() -> set[Path]:
    return {p for d in IZLENEN if d.exists() for p in d.iterdir() if gorsel_mi(p)}


def yeniye_tasi(kaynak: Path, kimlik: str) -> Path:
    YENI.mkdir(parents=True, exist_ok=True)
    hedef = YENI / f"{kimlik}{kaynak.suffix.lower()}"
    for uz in GORSEL_UZANTI:
        eski = YENI / f"{kimlik}{uz}"
        if eski.exists():
            (YENI / "_onceki").mkdir(exist_ok=True)
            yedek = YENI / "_onceki" / f"{kimlik}-{time.strftime('%H%M%S')}{uz}"
            shutil.move(eski, yedek)
    shutil.move(kaynak, hedef)
    return hedef


def izleyici():
    gorulen = mevcut()
    boyut: dict[Path, int] = {}
    while True:
        time.sleep(1)
        try:
            simdi = mevcut()
        except OSError:
            continue
        for p in simdi - gorulen:
            if not izlenecek_mi(p):
                gorulen.add(p)
                continue
            try:
                b = p.stat().st_size
            except OSError:
                continue
            if b == 0 or boyut.get(p) != b:   # yazılması bitene kadar bekle
                boyut[p] = b
                continue
            gorulen.add(p)
            with kilit:
                if kuyruk:
                    kimlik = kuyruk.pop(0)
                    hedef = yeniye_tasi(p, kimlik)
                    olaylar.append({"kimlik": kimlik, "dosya": hedef.name, "kaynak": p.name, "saat": time.strftime("%H:%M:%S")})
                else:
                    atanmamis.append(str(p))
        gorulen &= simdi | {p for p in gorulen if p.exists()}


# ---------------------------------------------------------------- pano / explorer

def ekleri_panoya(adlar: list[str]) -> str:
    yollar = [str(REFERANS / a) for a in adlar if (REFERANS / a).exists()]
    if not yollar:
        return "Bu mesajın eki yok."
    liste = ",".join("'" + y.replace("'", "''") + "'" for y in yollar)
    subprocess.run(["powershell", "-NoProfile", "-STA", "-Command", f"Set-Clipboard -Path {liste}"], check=True)
    return f"{len(yollar)} ek panoda; ChatGPT'de Ctrl+V."


def ekleri_klasorde(adlar: list[str]) -> str:
    if EKLER.exists():
        shutil.rmtree(EKLER)
    EKLER.mkdir(parents=True)
    for a in adlar:
        if (REFERANS / a).exists():
            shutil.copy2(REFERANS / a, EKLER / a)
    subprocess.Popen(["explorer", str(EKLER)])
    return "Ekler klasörde; Ctrl+A ile seçip ChatGPT'ye sürükle."


# ---------------------------------------------------------------- sunucu

class Isleyici(BaseHTTPRequestHandler):
    def log_message(self, *a):
        pass

    def _json(self, veri, kod=200):
        b = json.dumps(veri, ensure_ascii=False).encode()
        self.send_response(kod)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(b)))
        self.end_headers()
        self.wfile.write(b)

    def _dosya(self, p: Path):
        if not p.is_file():
            self.send_error(404)
            return
        tur = {".png": "image/png", ".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".webp": "image/webp"}.get(p.suffix.lower(), "application/octet-stream")
        b = p.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", tur)
        self.send_header("Content-Length", str(len(b)))
        self.send_header("Cache-Control", "max-age=60")
        self.end_headers()
        self.wfile.write(b)

    def do_GET(self):
        u = urlparse(self.path)
        q = parse_qs(u.query)
        if u.path == "/":
            b = SAYFA.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(b)))
            self.end_headers()
            self.wfile.write(b)
        elif u.path == "/api/dosyalar":
            self._json(sorted(p.name for p in ISTEM.glob("*-chatgpt.md")))
        elif u.path == "/api/mesajlar":
            ad = Path(q.get("md", [""])[0]).name
            self._json(mesajlari_oku(ISTEM / ad))
        elif u.path == "/api/durum":
            with kilit:
                self._json({"kuyruk": list(kuyruk), "olaylar": olaylar[-15:],
                            "atanmamis": [Path(p).name for p in atanmamis if Path(p).exists()]})
        elif u.path.startswith("/referans/"):
            self._dosya(REFERANS / Path(u.path).name)
        elif u.path.startswith("/indirilen/"):
            ad = Path(u.path).name
            with kilit:
                yol = next((Path(p) for p in atanmamis if Path(p).name == ad), None)
            self._dosya(yol) if yol else self.send_error(404)
        else:
            self.send_error(404)

    def do_POST(self):
        u = urlparse(self.path)
        uzunluk = int(self.headers.get("Content-Length", 0))
        veri = json.loads(self.rfile.read(uzunluk) or b"{}")
        try:
            if u.path == "/api/ekler-pano":
                self._json({"mesaj": ekleri_panoya(veri["ekler"])})
            elif u.path == "/api/ekler-klasor":
                self._json({"mesaj": ekleri_klasorde(veri["ekler"])})
            elif u.path == "/api/bekle":
                with kilit:
                    if veri["kimlik"] not in kuyruk:
                        kuyruk.append(veri["kimlik"])
                self._json({"tamam": True})
            elif u.path == "/api/kuyruktan-cikar":
                with kilit:
                    if veri["kimlik"] in kuyruk:
                        kuyruk.remove(veri["kimlik"])
                self._json({"tamam": True})
            elif u.path == "/api/ata":
                with kilit:
                    yol = next((Path(p) for p in atanmamis if Path(p).name == veri["dosya"]), None)
                    if not yol or not yol.exists():
                        return self._json({"mesaj": "Dosya bulunamadı."}, 404)
                    atanmamis.remove(str(yol))
                    hedef = yeniye_tasi(yol, veri["kimlik"])
                    olaylar.append({"kimlik": veri["kimlik"], "dosya": hedef.name, "kaynak": yol.name, "saat": time.strftime("%H:%M:%S")})
                self._json({"tamam": True})
            elif u.path == "/api/yoksay":
                with kilit:
                    atanmamis[:] = [p for p in atanmamis if Path(p).name != veri["dosya"]]
                self._json({"tamam": True})
            else:
                self.send_error(404)
        except Exception as e:  # yerel araç: hatayı sayfada göster
            self._json({"mesaj": f"Hata: {e}"}, 500)


SAYFA = r"""<!doctype html>
<html lang="tr"><head><meta charset="utf-8"><title>Görsel yardımcısı</title>
<style>
body{font:14px system-ui,sans-serif;margin:0;background:#f4efe6;color:#2b2620}
header{position:sticky;top:0;background:#3b3128;color:#fff;padding:8px 14px;display:flex;gap:12px;align-items:center;flex-wrap:wrap;z-index:2}
header select,header label{font-size:14px}
#kuyruk{font-weight:600}
main{display:grid;grid-template-columns:1fr 300px;gap:14px;padding:14px}
.kart{background:#fff;border-radius:8px;padding:10px 12px;margin-bottom:10px;border-left:6px solid #c9b79c}
.kart.eksik{border-left-color:#c0392b}.kart.indirildi{border-left-color:#e0a800}.kart.islendi{border-left-color:#3c8d40;opacity:.6}
.kart.bekliyor{outline:3px solid #e0a800}
.ust{display:flex;justify-content:space-between;align-items:center;gap:8px}
.ad{font-weight:700;font-size:15px}.etiket{font-size:12px;padding:2px 6px;border-radius:4px;background:#eee}
.kontrol{color:#6b5e50;font-size:12px;margin:4px 0}
.ekler{display:flex;gap:6px;flex-wrap:wrap;margin:6px 0}.ekler img{height:64px;border-radius:4px;border:1px solid #ddd}
button{font:inherit;padding:6px 10px;border-radius:6px;border:1px solid #8a7660;background:#fff;cursor:pointer}
button.ana{background:#3b3128;color:#fff;border-color:#3b3128}
button:active{transform:translateY(1px)}
details pre{white-space:pre-wrap;font-size:12px;background:#faf7f2;padding:8px;max-height:260px;overflow:auto}
aside{position:sticky;top:60px;align-self:start}
aside .kutu{background:#fff;border-radius:8px;padding:10px;margin-bottom:10px}
aside img{width:100%;border-radius:4px}
#bildirim{position:fixed;bottom:14px;left:50%;transform:translateX(-50%);background:#2b2620;color:#fff;padding:8px 14px;border-radius:6px;display:none}
.uyari{color:#c0392b;font-size:12px}
</style></head><body>
<header>
  <b>Görsel yardımcısı</b>
  <select id="md"></select>
  <label><input type="checkbox" id="yalnizEksik" checked> yalnız eksikler</label>
  <span>Sıradaki indirme → <span id="kuyruk">—</span></span>
</header>
<main><div id="liste"></div>
<aside>
  <div class="kutu"><b>Atanmamış indirmeler</b><div id="atanmamis"><i>yok</i></div></div>
  <div class="kutu"><b>Son taşınanlar</b><div id="olaylar"><i>yok</i></div></div>
</aside></main>
<div id="bildirim"></div>
<script>
let veri=null, durumVeri={kuyruk:[],olaylar:[],atanmamis:[]};
const $=s=>document.querySelector(s);
function bildir(m){const b=$('#bildirim');b.textContent=m;b.style.display='block';clearTimeout(b._t);b._t=setTimeout(()=>b.style.display='none',3000)}
async function post(u,v){const r=await fetch(u,{method:'POST',body:JSON.stringify(v)});return r.json()}
async function dosyalar(){
  const l=await (await fetch('/api/dosyalar')).json();
  $('#md').innerHTML=l.map(d=>`<option>${d}</option>`).join('');
  const son=localStorage.getItem('md'); if(son&&l.includes(son))$('#md').value=son;
  yukle();
}
async function yukle(){
  localStorage.setItem('md',$('#md').value);
  veri=await (await fetch('/api/mesajlar?md='+encodeURIComponent($('#md').value))).json();
  ciz();
}
function ciz(){
  const eksik=$('#yalnizEksik').checked;
  const kartlar=veri.mesajlar.filter(m=>!eksik||m.no===0||m.durum!=='islendi').map(m=>{
    const bekl=m.kimlik&&durumVeri.kuyruk.includes(m.kimlik);
    const et={eksik:'eksik',indirildi:'yeni\\ klasöründe',islendi:'işlendi'}[m.durum]||'';
    return `<div class="kart ${m.durum} ${bekl?'bekliyor':''}" id="m${m.no}">
      <div class="ust"><span class="ad">Mesaj ${m.no}: ${m.ad}</span>${et?`<span class="etiket">${et}</span>`:''}</div>
      ${m.kontrol?`<div class="kontrol">${m.kontrol}</div>`:''}
      ${m.ekler.length?`<div class="ekler">${m.ekler.map(e=>`<img src="/referans/${encodeURIComponent(e)}" title="${e}">`).join('')}</div>`:''}
      ${m.eksik_ekler.length?`<div class="uyari">Referans klasöründe yok: ${m.eksik_ekler.join(', ')}</div>`:''}
      <div style="display:flex;gap:6px;flex-wrap:wrap">
        ${m.ekler.length?`<button onclick="eklerPano(${m.no})">1 · Ekleri kopyala (${m.ekler.length})</button><button onclick="eklerKlasor(${m.no})">Klasörde aç</button>`:''}
        <button class="ana" onclick="istem(${m.no})">${m.ekler.length?'2':'1'} · İstemi kopyala</button>
        ${bekl?`<button onclick="cikar('${m.kimlik}')">Bekleme</button>`:(m.kimlik?`<button onclick="bekle('${m.kimlik}')">İndirmeyi bekle</button>`:'')}
      </div>
      <details><summary>İstemi göster</summary><pre>${m.istem.replace(/</g,'&lt;')}</pre></details>
    </div>`}).join('');
  $('#liste').innerHTML=`<details><summary>Dosyanın açıklaması</summary><pre>${veri.baslik.replace(/</g,'&lt;')}</pre></details>`+kartlar;
}
const mesaj=no=>veri.mesajlar.find(m=>m.no===no);
async function eklerPano(no){const r=await post('/api/ekler-pano',{ekler:mesaj(no).ekler});bildir(r.mesaj)}
async function eklerKlasor(no){const r=await post('/api/ekler-klasor',{ekler:mesaj(no).ekler});bildir(r.mesaj)}
async function istem(no){
  const m=mesaj(no); await navigator.clipboard.writeText(m.istem);
  if(m.kimlik){await post('/api/bekle',{kimlik:m.kimlik}); bildir('İstem panoda. İnecek görsel → '+m.kimlik)} else bildir('İstem panoda.');
  durum();
}
async function bekle(k){await post('/api/bekle',{kimlik:k});durum()}
async function cikar(k){await post('/api/kuyruktan-cikar',{kimlik:k});durum()}
async function ata(dosya,sel){const k=document.getElementById(sel).value;if(!k)return;await post('/api/ata',{dosya,kimlik:k});durum();yukle()}
async function yoksay(dosya){await post('/api/yoksay',{dosya});durum()}
let sonOlay='', sonKuyruk='', sonAtanmamis='';
async function durum(){
  durumVeri=await (await fetch('/api/durum')).json();
  $('#kuyruk').textContent=durumVeri.kuyruk.length?durumVeri.kuyruk.join(', '):'—';
  const kimlikler=veri?veri.mesajlar.filter(m=>m.kimlik).map(m=>m.kimlik):[];
  const a=JSON.stringify(durumVeri.atanmamis);
  if(a!==sonAtanmamis){sonAtanmamis=a;
  $('#atanmamis').innerHTML=durumVeri.atanmamis.length?durumVeri.atanmamis.map((d,i)=>`
    <div style="margin-top:8px"><img src="/indirilen/${encodeURIComponent(d)}"><div style="font-size:12px">${d}</div>
    <select id="s${i}"><option value="">kimlik seç…</option>${kimlikler.map(k=>`<option>${k}</option>`).join('')}</select>
    <button onclick="ata('${d.replace(/'/g,"\\'")}','s${i}')">Ata</button> <button onclick="yoksay('${d.replace(/'/g,"\\'")}')">Yok say</button></div>`).join(''):'<i>yok</i>';}
  $('#olaylar').innerHTML=durumVeri.olaylar.length?durumVeri.olaylar.slice().reverse().map(o=>`<div style="font-size:12px">${o.saat} · <b>${o.dosya}</b><br><span style="color:#888">${o.kaynak}</span></div>`).join(''):'<i>yok</i>';
  const s=JSON.stringify(durumVeri.olaylar.at(-1)||'');
  const k=JSON.stringify(durumVeri.kuyruk);
  if(veri&&s!==sonOlay){sonOlay=s;sonKuyruk=k;yukle()} else if(veri&&k!==sonKuyruk){sonKuyruk=k;ciz()}
}
$('#md').onchange=yukle; $('#yalnizEksik').onchange=ciz;
dosyalar(); setInterval(durum,2000);
</script></body></html>"""


def main():
    threading.Thread(target=izleyici, daemon=True).start()
    sunucu = ThreadingHTTPServer(("127.0.0.1", PORT), Isleyici)
    adres = f"http://127.0.0.1:{PORT}"
    print(f"Görsel yardımcısı: {adres}  (kapatmak için Ctrl+C)")
    print(f"İzlenen: {', '.join(str(d) for d in IZLENEN)} → {YENI}")
    if "--tarayicisiz" not in sys.argv:
        webbrowser.open(adres)
    try:
        sunucu.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
