# Not Defteri ve MCP Kurulumu (Windows 11)

Not: Google, NotebookLM'in adını Temmuz 2026'da **Gemini Notebook** olarak değiştirdi. Eski notebooklm.google.com adresi yenisine yönleniyor; araçların çoğu hâlâ eski adı kullanıyor.

## Önemli uyarı

Google'ın bu ürün için resmî bir MCP sunucusu yok. Aşağıdaki araç topluluk yapımıdır; belgelenmemiş dahili API'leri ve tarayıcı çerezlerini kullanır, Google'ın kullanım şartlarıyla uyumlu olmayabilir ve bir gün çalışmayı bırakabilir. Bu yüzden:

- Ana Google hesabını değil, **bu proje için açtığın ayrı bir Google hesabını** kullan.
- Kaynak PDF'lerinin bir kopyasını `kaynaklar/` klasöründe tut (yedek yol).

## Seçilen araç

`notebooklm-mcp-cli` (jacob-bd) — hem komut satırı (`nlm`) hem MCP sunucusu (`notebooklm-mcp`).
https://github.com/jacob-bd/notebooklm-mcp-cli

Sık anılan diğer seçenek `PleasePrompto/notebooklm-mcp` arşivlenmiş ve artık bakılmıyor; kullanma.

## Adımlar

1. **uv kur** (PowerShell):
   ```powershell
   winget install astral-sh.uv
   ```
2. **Aracı kur:**
   ```powershell
   uv tool install notebooklm-mcp-cli
   ```
3. **Giriş yap** (tarayıcı açılır, proje hesabıyla gir):
   ```powershell
   nlm login
   nlm login --check
   ```
4. **Not defterini oluştur**: Tarayıcıdan "Siyer – Peygamberlik Öncesi" not defterini aç, `docs/KAYNAKLAR.md` içindeki kaynakları yükle.
5. **Claude Code'a bağla**: Depodaki `.mcp.json` sunucuyu zaten tanımlar. Proje klasöründe `claude` çalıştırınca onay ister; onayla. Elle eklemek istersen:
   ```powershell
   claude mcp add --scope project notebook notebooklm-mcp
   ```
6. **Dene**: Claude Code içinde `/mcp` ile sunucunun bağlı olduğunu gör, sonra şunu sor:
   > Not defterlerimi listele ve "Siyer – Peygamberlik Öncesi" defterine Hilfü'l-Fudûl'ün hangi kaynaklarda geçtiğini sor.

## Kullanım kotası

Sohbet kullanımı yaklaşık 5 saatlik kayan bir pencereye ve haftalık bir üst sınıra göre ölçülüyor. Kalan hakkı görmek için:

```powershell
nlm usage
```

Kotayı korumak için Claude Code'un soruları toplu sorması CLAUDE.md'de istenmiştir.

## Sorun giderme

- Giriş düşerse: `nlm login` tekrar.
- Sunucu görünmüyorsa: Claude Code'u yeniden başlat, `/mcp` ile kontrol et.
- Araç tamamen bozulursa: Claude Code'a `kaynaklar/` klasöründen okumasını söyle; içerik kuralları aynen geçerli.
