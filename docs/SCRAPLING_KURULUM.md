# Scrapling ile Kaynak Edinme (Windows 11)

`docs/KAYNAKLAR.md` A listesindeki açık erişimli kaynakları (TDV maddeleri, DergiPark makaleleri, Diyanet yayınları vb.) elle tek tek indirmek yerine [Scrapling](https://github.com/D4Vinci/Scrapling) ile ediniriz. Araç iki biçimde kullanılır: komut satırı (`scrapling`) ve Claude Code için MCP sunucusu (`scrapling-mcp`).

Scrapling yalnızca geliştirme aracıdır; uygulamaya girmez. Uygulamada sunucu ve ağ üzerinden içerik çekme yoktur.

## Kurallar

- **Yalnızca A listesi.** Telifli eserlerin (B listesi) internetteki kopyalarını indirme; korsan olur.
- **Atıf kuralı değişmez.** Atıf yalnızca not defterinden ya da `kaynaklar/` klasöründeki dosyadan alınır. Scrapling ile ekranda görülen bir web sayfası atıf kaynağı değildir; önce `kaynaklar/` altına kaydedilir, sonra oradan okunur. Cilt/sayfa için matbu nüshanın PDF'i esastır.
- **Siteleri yorma.** İstekleri art arda değil aralıklı gönder, aynı dosyayı ikinci kez indirme, sitenin kullanım şartlarına ve robots.txt'ine uy.
- **Önce düz HTTP.** Tarayıcı modu ve engel aşma seçenekleri (`--solve-cloudflare` vb.) yalnızca sayfa JavaScript olmadan açılmıyorsa kullanılır; giriş ya da ödeme duvarını aşmak için kullanılmaz.
- İndirilenler `kaynaklar/` klasörüne gider ve git'e girmez.

## Kurulum

Depo kökünde, PowerShell ile (Python 3.10+ gerekir):

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install "scrapling[ai,shell]"
.\.venv\Scripts\scrapling.exe install
.\.venv\Scripts\python.exe -m patchright install chromium
```

Son satır gereklidir: `scrapling install` tek başına tarayıcı modunun istediği Chromium sürümünü indirmeyebiliyor ("Executable doesn't exist ... chrome.exe" hatası). `.venv/` git'e girmez; her makinede yeniden kurulur.

MCP sunucusu depodaki `.mcp.json` içinde `scrapling` adıyla tanımlıdır. Proje klasöründe `claude` çalıştırınca onay ister; onayla, `/mcp` ile bağlı olduğunu gör.

## Komut satırından kullanım

Çıktı dosyasının uzantısı biçimi belirler: `.md` Markdown, `.txt` düz metin, `.html` ham HTML.

```powershell
# Düz HTTP (çoğu kaynak için yeterli)
.\.venv\Scripts\scrapling.exe extract get "https://islamansiklopedisi.org.tr/hilful-fudul" kaynaklar\tdv\hilful-fudul.md

# Tarayıcıyla (JavaScript isteyen sayfalar)
.\.venv\Scripts\scrapling.exe extract fetch "<adres>" kaynaklar\<dosya>.md
```

TDV madde sayfalarında matbu nüshanın PDF bağlantısı (`cdn2.islamansiklopedisi.org.tr/dosya/...pdf`) sayfa metninde yer alır; madde sayfası çekildikten sonra PDF bu bağlantıdan indirilir. PDF gibi ikili dosyalar için `Invoke-WebRequest -OutFile` yeterlidir.

## Claude Code içinden kullanım

Örnek istek:

> `docs/KAYNAKLAR.md` C bölümündeki "Olaylar" maddelerinin TDV sayfalarını Scrapling ile bul, matbu PDF'lerini `kaynaklar/tdv/` altına indir ve indirilenleri listele.

Sık kullanılan araçlar: `make_request` (düz HTTP), `browser_fetch_once` (tarayıcıyla tek sayfa), `browser_open` / `browser_fetch` / `browser_extract` (oturumlu gezinme).

## Sorun giderme

- **"Executable doesn't exist ... chrome.exe"**: `.\.venv\Scripts\python.exe -m patchright install chromium`
- **Konsolda bozuk Türkçe karakter ya da kodlama hatası**: `$env:PYTHONIOENCODING='utf-8'` verip yeniden dene.
- **Sunucu `/mcp` içinde görünmüyor**: `.venv` kurulu mu bak, Claude Code'u yeniden başlat.
- **Güncelleme**: `.\.venv\Scripts\python.exe -m pip install -U "scrapling[ai,shell]"`, ardından kurulumdaki son iki satır.
