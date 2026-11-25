import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ayarlar/tercihler.dart';
import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../icerik/paketler.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';
import '../tema.dart';

/// Ana sayfa: bölümler eski bir yol haritası gibi aşağı doğru, farklı açılarla
/// birbirini izler; aralarında noktalı yol. Son bölümden sonra zemin
/// yumuşakça geceye döner: oradan sonrası peygamberlik dönemi.
class BolumYolu extends ConsumerStatefulWidget {
  const BolumYolu({super.key});

  @override
  ConsumerState<BolumYolu> createState() => _BolumYoluState();
}

/// Kartların yeri ve açısı; ekran genişliğine göre hesaplanır.
class YolYerlesimi {
  YolYerlesimi(this.genislik, int sayi, {this.devamKarti = false})
      : ust = devamKarti ? baslikAlani + devamYuksekligi + 46 : 150 {
    for (var i = 0; i < sayi; i++) {
      final serbest = math.max(0.0, genislik - kartGenisligi - 2 * kenar);
      // Sola ve sağa salınan, her seferinde biraz farklı bir yol.
      final sol = kenar + serbest * _salinim[i % _salinim.length];
      kartlar.add(Rect.fromLTWH(sol, ust + i * adim, kartGenisligi, kartYuksekligi));
      acilar.add(0.05 * math.sin(i * 2.3 + 1.1));
    }
    // Yolun sonunda zemin geceye döner; gecenin içinde, ortada, henüz
    // gelmemiş dönemin kartı.
    if (sayi > 0) {
      donemGecisi = kartlar.last.bottom + 30;
      final gen = math.min(genislik - 2 * kenar, kartGenisligi + 40);
      yakinda = Rect.fromLTWH((genislik - gen) / 2, donemGecisi! + gecisBoyu + 10, gen, yakindaYuksekligi);
    }
  }

  final double genislik;
  static const kenar = 18.0;
  /// Başlığın yüksekliği; "devam et" kartı bunun altına gelir.
  static const baslikAlani = 108.0;
  static const devamYuksekligi = 104.0;

  /// Yarım bölüm varsa en üstte "kaldığın yerden devam et" kartı.
  final bool devamKarti;

  /// İlk bölüm kartının üstü.
  final double ust;
  static const kartYuksekligi = 200.0;

  /// Kartın üstündeki görsel şeridin yüksekliği.
  static const kapakYuksekligi = 74.0;
  static const adim = kartYuksekligi + 76;

  /// Kartların yatay yeri (0 sol, 1 sağ): düzenli zikzak değil, elle
  /// çizilmiş bir yol gibi.
  static const _salinim = [0.2, 0.9, 0.35, 1.0, 0.0, 0.75, 0.15, 0.95, 0.45, 0.05];
  final kartlar = <Rect>[];
  final acilar = <double>[];

  /// "Yakında" kartı (sonraki dönem); bölüm yoksa null.
  Rect? yakinda;

  /// Parşömenin geceye dönmeye başladığı yükseklik; bölüm yoksa null.
  double? donemGecisi;

  /// Parşömenden geceye geçişin boyu.
  static const gecisBoyu = 400.0;
  static const yakindaYuksekligi = 150.0;

  double get kartGenisligi => math.min(genislik * 0.68, 330);
  double get yukseklik => (yakinda?.bottom ?? (kartlar.isEmpty ? ust : kartlar.last.bottom)) + 200;
}

class _BolumYoluState extends ConsumerState<BolumYolu> {
  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final bolumler = ref.watch(bolumListesiProvider);
    // İlerleme okunamazsa yol yine gösterilir; yalnız ilerleme bilgisi eksik kalır.
    final ilerleme = ref.watch(ilerlemeProvider).value ?? const {};
    return bolumler.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
      data: (liste) => LayoutBuilder(builder: (context, k) {
        final yarimId = sonYarimBolum(ilerleme);
        final yarim = liste.where((b) => b.id == yarimId).firstOrNull;
        final y = YolYerlesimi(k.maxWidth, liste.length, devamKarti: yarim != null);
        // Sıradaki: bitirilmemiş ilk bölüm. Ondan sonrakiler soluk (yine açılabilir).
        final siradaki = liste.indexWhere((b) => ilerleme[b.id]?.bitti != true);
        final azHareket = hareketAz(context, ref);
        final boyutlar = ref.watch(paketBoyutlariProvider).value ?? const {};
        return SingleChildScrollView(
          // Alt boşluk ayrı bir dolgu olsaydı gecenin altında parşömen şerit
          // kalırdı; çizim alanı gezinme çubuğunun altına kadar uzanır.
          child: SizedBox(
            height: y.yukseklik + MediaQuery.paddingOf(context).bottom,
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: YolCizici(y))),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: YolYerlesimi.baslikAlani,
                  child: SafeArea(bottom: false, child: _Baslik(m: m)),
                ),
                if (yarim != null)
                  Positioned(
                    left: YolYerlesimi.kenar,
                    right: YolYerlesimi.kenar,
                    top: YolYerlesimi.baslikAlani,
                    height: YolYerlesimi.devamYuksekligi,
                    child: DevamKarti(bolum: yarim, ilerleme: ilerleme[yarim.id]!),
                  ),
                if (liste.isEmpty)
                  Positioned(
                    left: 24,
                    right: 24,
                    top: y.ust + 40,
                    child: Text(m.bolumYok, textAlign: TextAlign.center),
                  ),
                if (y.yakinda != null)
                  Positioned.fromRect(rect: y.yakinda!, child: YakindaKarti(m: m)),
                for (var i = 0; i < liste.length; i++)
                  Positioned.fromRect(
                    key: ValueKey(liste[i].id),
                    rect: y.kartlar[i],
                    child: BolumKarti(
                      bolum: liste[i],
                      ilerleme: ilerleme[liste[i].id],
                      aci: y.acilar[i],
                      siradaki: i == siradaki,
                      // Başlanmış bölüm (yarım ya da bitmiş) sırası gelmese de soluk değil.
                      soluk: siradaki >= 0 && i > siradaki && ilerleme[liste[i].id] == null,
                      azHareket: azHareket,
                      paket: ref.watch(paketDurumuProvider(liste[i].id)),
                      paketBoyutu: boyutlar[paketAdi(liste[i].id)],
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _Baslik extends StatelessWidget {
  const _Baslik({required this.m});

  final Metinler m;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dar ekranda iki satıra bölünmesin; gerekirse küçülür.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    m.uygulamaAdi,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: baslikYazisi,
                      fontSize: 26,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      color: Palet.murekkep,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m.yolAltBaslik,
                  style: const TextStyle(
                    fontFamily: baslikYazisi,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Palet.murekkepSoluk,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: m.zamanCizelgesi,
            color: Palet.murekkep,
            icon: const Icon(Icons.timeline),
            onPressed: () => context.push('/zaman'),
          ),
          IconButton(
            tooltip: m.ayarlar,
            color: Palet.murekkep,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/ayarlar'),
          ),
        ],
      ),
    );
  }
}

/// Bir bölüm kartı: üstte bölümün kendi sahnesinden bir şerit (kapak),
/// altında numara, ad ve özet. Dokununca kart hafifçe basılır ve bölüm
/// beklemeden açılır (eski çarpı animasyonu her açılışta bekletiyordu).
class BolumKarti extends StatefulWidget {
  const BolumKarti({
    super.key,
    required this.bolum,
    required this.aci,
    this.ilerleme,
    this.secildi,
    this.siradaki = false,
    this.soluk = false,
    this.azHareket = false,
    this.paket = const PaketHazir(),
    this.paketBoyutu,
  });

  /// Bölümün ses ve görselleri indirildi mi; inmemişse kartta boyutu görünür.
  final PaketDurumu paket;

  /// İndirme boyutu (bayt).
  final int? paketBoyutu;

  /// Hareketi azalt: kart basılınca küçülmez.
  final bool azHareket;

  /// İzlenecek sıradaki bölüm: köşesinde "Sıradaki" yazar.
  final bool siradaki;

  /// Sırası henüz gelmemiş bölüm: soluk görünür ama açılabilir.
  final bool soluk;

  final Bolum bolum;
  final BolumIlerlemesi? ilerleme;

  /// Kartın eğikliği (radyan).
  final double aci;
  final VoidCallback? secildi;

  @override
  State<BolumKarti> createState() => _BolumKartiState();
}

/// Kart kapağının dosyası: `assets/kartlar/b01.webp` (bölüm kimliğinin ilk üç harfi).
String kartKapagi(String bolumId) => 'assets/kartlar/${bolumId.split('-').first}.webp';

class _BolumKartiState extends State<BolumKarti> {
  bool _basili = false;
  bool _aciliyor = false;

  Future<void> _sec() async {
    if (_aciliyor) return;
    _aciliyor = true;
    widget.secildi?.call();
    // Sahne verilmez: oynatıcı kayıtlı ilerlemeden başlar.
    await context.push('/bolum/${widget.bolum.id}');
    _aciliyor = false;
  }

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final b = widget.bolum;
    final il = widget.ilerleme;
    final bitti = il?.bitti == true;
    final toplam = b.sahneler.length;
    final devam = il != null && !bitti && il.sonSahne > 1 && toplam > 0;
    final ekSatir = devam || widget.paket is PaketYok || widget.paket is PaketIniyor;
    const kose = BorderRadius.all(Radius.circular(6));
    final kart = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: kose,
        boxShadow: [
          BoxShadow(
            color: Palet.murekkep.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Material(
        color: Palet.kagitAcik,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: kose,
          side: BorderSide(color: Palet.murekkep.withValues(alpha: 0.55), width: 1.2),
        ),
        child: InkWell(
          onTap: _sec,
          onHighlightChanged: (b) => setState(() => _basili = b),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: YolYerlesimi.kapakYuksekligi,
                child: _Kapak(dosya: kartKapagi(b.id), soluk: widget.soluk),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              m.bolumNo(b.sira).toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                letterSpacing: 1.6,
                                fontWeight: FontWeight.w600,
                                color: Palet.murekkepSoluk,
                              ),
                            ),
                          ),
                          if (widget.siradaki && !bitti)
                            Text(
                              m.siradaki,
                              style: const TextStyle(
                                fontSize: 11,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Palet.kina,
                              ),
                            ),
                          if (bitti)
                            Text(
                              m.izlendi,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Palet.zeytin,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 1),
                      Text(
                        b.baslik,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: baslikYazisi,
                          fontSize: 19,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Palet.murekkep,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          b.ozet,
                          // Alttaki ilerleme ya da indirme satırı yer kaplar.
                          maxLines: ekSatir ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, height: 1.3, color: Palet.murekkepSoluk),
                        ),
                      ),
                      if (widget.paket case PaketYok() || PaketIniyor()) ...[
                        const SizedBox(height: 6),
                        _IndirmeIsareti(paket: widget.paket, boyut: widget.paketBoyutu),
                      ],
                      if (devam) ...[
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: (il.sonSahne - 1) / toplam,
                          minHeight: 3,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          m.kaldiginYer(il.sonSahne, toplam),
                          style: const TextStyle(fontSize: 11, color: Palet.murekkepSoluk),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Semantics(
      button: true,
      label: '${m.bolumNo(b.sira)}: ${b.baslik}',
      child: Transform.rotate(
        angle: widget.aci,
        child: AnimatedScale(
          scale: _basili && !widget.azHareket ? 0.97 : 1,
          duration: const Duration(milliseconds: 90),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Sırası gelmemiş bölüm soluk.
              Positioned.fill(child: Opacity(opacity: widget.soluk ? 0.6 : 1, child: kart)),
              // Numara mührü kartın sağ üst köşesine basılmış gibi.
              Positioned(
                right: -14,
                top: -16,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: widget.soluk ? 0.6 : 1,
                    child: _NumaraMuhru(sira: b.sira, bitti: bitti),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kartın üstündeki görsel şerit: bölümün kendi sahnesinden bir kesit; alt
/// kenarı kâğıda karışır. Sırası gelmemiş bölümde soluk, sepya tonlu.
/// Dosya yoksa (testler, eksik kapak) düz koyu parşömen.
class _Kapak extends StatelessWidget {
  const _Kapak({required this.dosya, this.soluk = false});

  final String dosya;
  final bool soluk;

  /// Gri + sıcak ton: eski bir gravür gibi.
  static const _sepya = ColorFilter.matrix([
    0.39, 0.77, 0.19, 0, 0, //
    0.35, 0.69, 0.17, 0, 0,
    0.27, 0.53, 0.13, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    // Kapaklar küçüktür (1000×250, tools/kart_kapagi.py); ayrıca küçültülmez.
    Widget resim = Image.asset(
      dosya,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, _, _) => const ColoredBox(color: Palet.kagitKoyu),
    );
    if (soluk) resim = ColorFiltered(colorFilter: _sepya, child: resim);
    return Stack(
      fit: StackFit.expand,
      children: [
        resim,
        // Alt kenar kâğıda karışır; üstte hafif gölge mührü öne çıkarır.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Palet.murekkep.withValues(alpha: 0.12),
                Palet.kagitAcik.withValues(alpha: 0),
                Palet.kagitAcik.withValues(alpha: 0),
                Palet.kagitAcik,
              ],
              stops: const [0, 0.3, 0.62, 1],
            ),
          ),
        ),
      ],
    );
  }
}

/// İnmemiş bölüm kartında: indirme simgesi ve boyut; inerken ilerleme halkası.
class _IndirmeIsareti extends StatelessWidget {
  const _IndirmeIsareti({required this.paket, this.boyut});

  final PaketDurumu paket;
  final int? boyut;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    const stil = TextStyle(fontSize: 11, color: Palet.murekkepSoluk);
    return Row(
      children: [
        if (paket case PaketIniyor(:final oran))
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(value: oran, strokeWidth: 2, color: Palet.kina),
          )
        else
          const Icon(Icons.download_outlined, size: 14, color: Palet.murekkepSoluk),
        const SizedBox(width: 4),
        Text(
          paket is PaketIniyor
              ? m.indiriliyor
              : boyut != null
                  ? m.indirmeBoyutu(mbMetni(boyut!, Localizations.localeOf(context).languageCode))
                  : m.indirilmedi,
          style: stil,
        ),
      ],
    );
  }
}

/// Bölüm numarası mühür gibi: kına kırmızısı daire; izlenmişse zeytin ve tik.
class _NumaraMuhru extends StatelessWidget {
  const _NumaraMuhru({required this.sira, required this.bitti});

  final int sira;
  final bool bitti;

  @override
  Widget build(BuildContext context) {
    final renk = bitti ? Palet.zeytin : Palet.kina;
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: renk,
        border: Border.all(color: Palet.kagitAcik, width: 2),
        boxShadow: [BoxShadow(color: renk.withValues(alpha: 0.6), spreadRadius: 1.5)],
      ),
      alignment: Alignment.center,
      child: bitti
          ? const Icon(Icons.check, color: Palet.kagitAcik, size: 24)
          : Text(
              '$sira',
              style: const TextStyle(
                fontFamily: baslikYazisi,
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: Palet.kagitAcik,
              ),
            ),
    );
  }
}

/// Gece tarafının renkleri: peygamberlik dönemi.
abstract final class DonemRengi {
  /// Alacakaranlık: parşömenden geceye geçişin ortası.
  static const alacakaranlik = Color(0xFF6B4A4E);

  /// Geceye inerken mor-lacivert.
  static const lacivert = Color(0xFF2B2A48);

  /// Gecenin dibi.
  static const gece = Color(0xFF161A2A);
}

/// Sayfanın zemini ve kartları bağlayan noktalı yol. Üst taraf eski bir
/// parşömen; son bölümden sonra zemin alacakaranlıktan geceye döner, yıldızlar
/// belirir ve yol altın noktalarla sürer.
class YolCizici extends CustomPainter {
  const YolCizici(this.yerlesim);

  final YolYerlesimi yerlesim;

  @override
  void paint(Canvas canvas, Size size) {
    final alan = Offset.zero & size;
    final gecis = yerlesim.donemGecisi;
    final gecisSonu = gecis == null ? null : gecis + YolYerlesimi.gecisBoyu;
    // Gecenin başladığı yere kadar parşömen ve lekeleri.
    final kagitAlani = gecisSonu == null ? alan : Rect.fromLTRB(0, 0, size.width, gecisSonu);
    canvas.drawRect(kagitAlani, Paint()..color = Palet.kagit);
    canvas.save();
    canvas.clipRect(kagitAlani);
    // Hafif lekeler (sabit tohum): eski kâğıt.
    final rnd = math.Random(605);
    final leke = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    for (var i = 0; i < (kagitAlani.height / 120).ceil(); i++) {
      leke.color = Color.fromARGB(10 + rnd.nextInt(14), 120, 80, 40);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * kagitAlani.height),
        size.width * (0.08 + rnd.nextDouble() * 0.16),
        leke,
      );
    }
    canvas.restore();

    if (gecis != null && gecisSonu != null) {
      // Parşömen → alacakaranlık → gece: yumuşak, uzun bir geçiş.
      final gecisAlani = Rect.fromLTRB(0, gecis, size.width, gecisSonu);
      canvas.drawRect(
        gecisAlani,
        Paint()
          // Saydamdan başlar: üstteki lekeli parşömenle arasında basamak olmasın.
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Palet.kagit.withValues(alpha: 0),
              Palet.kagitKoyu.withValues(alpha: 0.7),
              DonemRengi.alacakaranlik,
              DonemRengi.lacivert,
            ],
            stops: const [0, 0.3, 0.66, 1],
          ).createShader(gecisAlani),
      );
      final geceAlani = Rect.fromLTRB(0, gecisSonu, size.width, size.height);
      canvas.drawRect(
        geceAlani,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [DonemRengi.lacivert, DonemRengi.gece],
          ).createShader(geceAlani),
      );
      // Yıldızlar: geçişin ortasından itibaren yavaş yavaş belirir.
      final ry = math.Random(610);
      final yildizBasi = gecis + YolYerlesimi.gecisBoyu * 0.45;
      final sayi = ((size.height - yildizBasi) * size.width / 2600).round();
      for (var i = 0; i < sayi; i++) {
        final p = Offset(ry.nextDouble() * size.width, yildizBasi + ry.nextDouble() * (size.height - yildizBasi));
        final belir = ((p.dy - yildizBasi) / (YolYerlesimi.gecisBoyu * 0.7)).clamp(0.0, 1.0);
        final parlak = ry.nextDouble();
        canvas.drawCircle(
          p,
          0.6 + parlak * 1.1,
          Paint()..color = Palet.kagitAcik.withValues(alpha: belir * (0.25 + parlak * 0.55)),
        );
      }
      // "Yakında" kartının çevresinde, yukarıdan inen hafif bir ışık.
      final yakinda = yerlesim.yakinda;
      if (yakinda != null) {
        final merkez = yakinda.center - Offset(0, yakinda.height * 0.25);
        final r = size.width * 0.75;
        canvas.drawCircle(
          merkez,
          r,
          Paint()
            ..shader = RadialGradient(colors: [
              Palet.altin.withValues(alpha: 0.24),
              Palet.altin.withValues(alpha: 0.07),
              Palet.altin.withValues(alpha: 0),
            ], stops: const [0, 0.45, 1]).createShader(Rect.fromCircle(center: merkez, radius: r)),
        );
      }
    }

    // Kenarlarda kararma.
    final kenar = Paint()
      ..shader = LinearGradient(colors: [
        Palet.murekkep.withValues(alpha: 0.16),
        Palet.murekkep.withValues(alpha: 0),
        Palet.murekkep.withValues(alpha: 0),
        Palet.murekkep.withValues(alpha: 0.16),
      ], stops: const [0, 0.12, 0.88, 1]).createShader(alan);
    canvas.drawRect(alan, kenar);

    // Noktalı yol: başlıktan ilk karta ve kartlar arasında.
    final nokta = Paint()..color = Palet.murekkep.withValues(alpha: 0.5);
    void yol(Offset a, Offset b) {
      final p = Path()
        ..moveTo(a.dx, a.dy)
        ..cubicTo(a.dx, a.dy + 46, b.dx, b.dy - 46, b.dx, b.dy);
      for (final olcu in p.computeMetrics()) {
        for (var d = 6.0; d < olcu.length - 4; d += 11) {
          canvas.drawCircle(olcu.getTangentForOffset(d)!.position, 2.3, nokta);
        }
      }
    }

    final k = yerlesim.kartlar;
    if (k.isNotEmpty) {
      yol(Offset(size.width * 0.18, yerlesim.ust - 44), k.first.topCenter + Offset(-k.first.width * 0.12, 0));
    }
    for (var i = 0; i + 1 < k.length; i++) {
      yol(k[i].bottomCenter + Offset(k[i].width * 0.12 * (i.isEven ? 1 : -1), 0),
          k[i + 1].topCenter + Offset(k[i + 1].width * 0.12 * (i.isEven ? -1 : 1), 0));
    }
    final yakinda = yerlesim.yakinda;
    if (k.isNotEmpty && yakinda != null) {
      // Son bölümden "Yakında" kartına giden yol: mürekkep noktalar geceye
      // girdikçe altına döner.
      final a = k.last.bottomCenter + Offset(k.last.width * 0.12 * (k.length.isOdd ? 1 : -1), 0);
      final b = yakinda.topCenter;
      final p = Path()
        ..moveTo(a.dx, a.dy)
        ..cubicTo(a.dx, a.dy + 140, b.dx, b.dy - 160, b.dx, b.dy);
      for (final olcu in p.computeMetrics()) {
        for (var d = 6.0; d < olcu.length - 4; d += 11) {
          final oran = d / olcu.length;
          final renk = Color.lerp(
            Palet.murekkep.withValues(alpha: 0.5),
            Palet.altin.withValues(alpha: 0.85),
            ((oran - 0.35) / 0.4).clamp(0.0, 1.0),
          )!;
          canvas.drawCircle(olcu.getTangentForOffset(d)!.position, 2.3, Paint()..color = renk);
        }
      }
      // Kartın altında, aşağıda solan birkaç altın nokta (sonraki dönemler).
      final son = yakinda.bottomCenter;
      for (var i = 1; i <= 6; i++) {
        canvas.drawCircle(
          son + Offset(math.sin(i * 0.7) * 10, i * 13.0),
          1.8,
          Paint()..color = Palet.altin.withValues(alpha: 0.6 * (1 - i / 7)),
        );
      }
    }

    // Kenar süsleri: kartların boş bıraktığı yanlarda küçük kum tepeleri
    // (yalnız parşömen tarafında).
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = Palet.murekkep.withValues(alpha: 0.3);
    final rt = math.Random(17);
    final susSonu = gecis ?? size.height - 60;
    for (var i = 0; i < k.length * 2; i++) {
      final p = Offset(20 + rt.nextDouble() * (size.width - 40), yerlesim.ust + rt.nextDouble() * (size.height - yerlesim.ust - 60));
      if (p.dy > susSonu) continue;
      final r = Rect.fromCenter(center: p, width: 44, height: 22);
      if ([...k, ?yakinda].any((x) => x.inflate(14).overlaps(r))) continue;
      canvas.drawPath(
        Path()
          ..moveTo(p.dx - 14, p.dy)
          ..quadraticBezierTo(p.dx - 3, p.dy - 10, p.dx + 10, p.dy),
        kalem,
      );
      canvas.drawPath(
        Path()
          ..moveTo(p.dx - 2, p.dy + 5)
          ..quadraticBezierTo(p.dx + 7, p.dy - 2, p.dx + 17, p.dy + 4),
        kalem,
      );
    }
  }

  @override
  bool shouldRepaint(YolCizici eski) =>
      eski.yerlesim.genislik != yerlesim.genislik ||
      eski.yerlesim.kartlar.length != yerlesim.kartlar.length ||
      eski.yerlesim.ust != yerlesim.ust;
}

/// Yolun sonundaki, henüz gelmemiş dönemin kartı: gecenin içinde altın
/// kesik çizgili kenar, kum saati. Dokunulmaz.
class YakindaKarti extends StatelessWidget {
  const YakindaKarti({super.key, required this.m});

  final Metinler m;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${m.yakindaBaslik}. ${m.yakindaAlt}',
      excludeSemantics: true,
      child: Transform.rotate(
        angle: -0.015,
        child: CustomPaint(
          painter: const _KesikCerceve(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  m.yakindaUst.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w600,
                    color: Palet.altin,
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    m.yakindaBaslik,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: baslikYazisi,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Palet.kagitAcik,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 28, height: 1, color: Palet.altin),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.hourglass_empty_rounded, size: 16, color: Palet.altin),
                    ),
                    Container(width: 28, height: 1, color: Palet.altin),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  m.yakindaAlt,
                  style: const TextStyle(
                    fontFamily: baslikYazisi,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFD9C9A8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KesikCerceve extends CustomPainter {
  const _KesikCerceve();

  @override
  void paint(Canvas canvas, Size size) {
    final rr = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8));
    canvas.drawRRect(rr, Paint()..color = DonemRengi.gece.withValues(alpha: 0.55));
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = Palet.altin.withValues(alpha: 0.75);
    for (final olcu in (Path()..addRRect(rr)).computeMetrics()) {
      for (var d = 0.0; d < olcu.length; d += 12) {
        canvas.drawPath(olcu.extractPath(d, math.min(d + 6, olcu.length)), kalem);
      }
    }
  }

  @override
  bool shouldRepaint(_KesikCerceve eski) => false;
}

/// Ana sayfanın en üstünde, yarım bırakılmış son bölüme dönüş kartı.
/// Dokununca bölüm kalınan sahneden açılır (oynatıcı kayıtlı ilerlemeden başlar).
class DevamKarti extends StatelessWidget {
  const DevamKarti({super.key, required this.bolum, required this.ilerleme});

  final Bolum bolum;
  final BolumIlerlemesi ilerleme;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final toplam = bolum.sahneler.length;
    return Semantics(
      button: true,
      label: '${m.devamEt}: ${bolum.baslik}',
      excludeSemantics: true,
      child: Material(
        color: Palet.gece,
        elevation: 4,
        shadowColor: Palet.murekkep.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Palet.altin.withValues(alpha: 0.7), width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push('/bolum/${bolum.id}'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        m.devamEt,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Palet.altin),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${m.bolumNo(bolum.sira)} · ${bolum.baslik}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: baslikYazisi,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Palet.kagitAcik,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (toplam > 0)
                        LinearProgressIndicator(
                          value: (ilerleme.sonSahne - 1) / toplam,
                          minHeight: 3,
                          color: Palet.altin,
                          backgroundColor: Palet.kagitAcik.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      const SizedBox(height: 3),
                      Text(
                        m.sahneSayaci(ilerleme.sonSahne, toplam),
                        style: TextStyle(fontSize: 11, color: Palet.kagitAcik.withValues(alpha: 0.75)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Palet.kina),
                  child: const Icon(Icons.play_arrow, color: Palet.kagitAcik, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
