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
/// birbirini izler; aralarında noktalı yol. Bir bölüme dokununca kart
/// büyür, üstüne kına kırmızısı bir çarpı düşer, sonra bölüm açılır.
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
    // Yolun sonunda, ortada: henüz gelmemiş dönemin kartı.
    if (sayi > 0) {
      final gen = math.min(genislik - 2 * kenar, kartGenisligi + 40);
      yakinda = Rect.fromLTWH((genislik - gen) / 2, ust + sayi * adim + 14, gen, yakindaYuksekligi);
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
  static const kartYuksekligi = 136.0;
  static const adim = kartYuksekligi + 76;

  /// Kartların yatay yeri (0 sol, 1 sağ): düzenli zikzak değil, elle
  /// çizilmiş bir yol gibi.
  static const _salinim = [0.2, 0.9, 0.35, 1.0, 0.0, 0.75, 0.15, 0.95, 0.45, 0.05];
  final kartlar = <Rect>[];
  final acilar = <double>[];

  /// "Yakında" kartı (sonraki dönem); bölüm yoksa null.
  Rect? yakinda;
  static const yakindaYuksekligi = 150.0;

  double get kartGenisligi => math.min(genislik * 0.68, 330);
  double get yukseklik => (yakinda?.bottom ?? (kartlar.isEmpty ? ust : kartlar.last.bottom)) + 140;
}

class _BolumYoluState extends ConsumerState<BolumYolu> {
  /// Büyüyen kart en üstte çizilsin diye seçili bölümün kimliği.
  String? _secili;

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
        final efekt = ref.read(efektCalProvider);
        final azHareket = hareketAz(context, ref);
        final boyutlar = ref.watch(paketBoyutlariProvider).value ?? const {};
        final sira = [
          for (var i = 0; i < liste.length; i++)
            if (liste[i].id != _secili) i,
          for (var i = 0; i < liste.length; i++)
            if (liste[i].id == _secili) i,
        ];
        return SingleChildScrollView(
          padding: altPayli(context),
          child: SizedBox(
            height: y.yukseklik,
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
                for (final i in sira)
                  // Anahtar dışta: sıra değişince kartın durumu (animasyon) korunsun.
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
                      efekt: efekt,
                      azHareket: azHareket,
                      paket: ref.watch(paketDurumuProvider(liste[i].id)),
                      paketBoyutu: boyutlar[paketAdi(liste[i].id)],
                      secildi: () => setState(() => _secili = liste[i].id),
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

/// Bir bölüm kartı. Dokununca: kart görünür alana kaydırılır, büyüyüp
/// düzleşir, üstüne çarpı çizilir, bölüm açılır; dönüşte eski hâline gelir.
class BolumKarti extends StatefulWidget {
  const BolumKarti({
    super.key,
    required this.bolum,
    required this.aci,
    this.ilerleme,
    this.secildi,
    this.siradaki = false,
    this.soluk = false,
    this.efekt,
    this.azHareket = false,
    this.paket = const PaketHazir(),
    this.paketBoyutu,
  });

  /// Bölümün ses ve görselleri indirildi mi; inmemişse kartta boyutu görünür.
  final PaketDurumu paket;

  /// İndirme boyutu (bayt).
  final int? paketBoyutu;

  /// Hareketi azalt: kart büyümez, kaydırma anında, çarpı kısa sürede.
  final bool azHareket;

  /// İzlenecek sıradaki bölüm: köşesinde "Sıradaki" yazar.
  final bool siradaki;

  /// Sırası henüz gelmemiş bölüm: soluk görünür ama açılabilir.
  final bool soluk;

  /// Çarpı çizilirken `kalem` sesi.
  final void Function(String ad)? efekt;

  final Bolum bolum;
  final BolumIlerlemesi? ilerleme;

  /// Kartın eğikliği (radyan).
  final double aci;
  final VoidCallback? secildi;

  @override
  State<BolumKarti> createState() => _BolumKartiState();
}

class _BolumKartiState extends State<BolumKarti> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300));

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  Future<void> _sec() async {
    if (_ac.isAnimating) return;
    widget.secildi?.call();
    widget.efekt?.call('kalem');
    await Scrollable.ensureVisible(
      context,
      alignment: 0.4,
      duration: widget.azHareket ? Duration.zero : const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
    );
    if (!mounted) return;
    _ac.duration = Duration(milliseconds: widget.azHareket ? 500 : 1300);
    await _ac.forward(from: 0);
    if (!mounted) return;
    // Sahne verilmez: oynatıcı kayıtlı ilerlemeden başlar.
    await context.push('/bolum/${widget.bolum.id}');
    if (mounted) _ac.reset();
  }

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final b = widget.bolum;
    final il = widget.ilerleme;
    final bitti = il?.bitti == true;
    final toplam = b.sahneler.length;
    final devam = il != null && !bitti && il.sonSahne > 1 && toplam > 0;
    final kart = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _sec,
        borderRadius: BorderRadius.circular(6),
        child: Ink(
          decoration: BoxDecoration(
            color: Palet.kagitAcik,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Palet.murekkep.withValues(alpha: 0.55), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Palet.murekkep.withValues(alpha: 0.18),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                m.siradaki,
                                style: const TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: Palet.kina,
                                ),
                              ),
                            ),
                          if (bitti)
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                m.izlendi,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Palet.zeytin,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
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
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          b.ozet,
                          // Alttaki ilerleme ya da indirme satırı yer kaplar;
                          // üç satır sığmayıp satır ortasından kesiliyordu.
                          maxLines: devam || widget.paket is PaketYok || widget.paket is PaketIniyor ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, height: 1.3, color: Palet.murekkepSoluk),
                        ),
                      ),
                      if (widget.paket case PaketYok() || PaketIniyor()) ...[
                        const SizedBox(height: 6),
                        _IndirmeIsareti(paket: widget.paket, boyut: widget.paketBoyutu),
                      ],
                      if (devam) ...[
                        const SizedBox(height: 8),
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
              ],
            ),
          ),
        ),
      ),
    );
    return AnimatedBuilder(
      animation: _ac,
      builder: (context, cocuk) {
        final t = _ac.value;
        final yakin = widget.azHareket ? 0.0 : Curves.easeOutBack.transform((t / 0.35).clamp(0.0, 1.0));
        return Transform.rotate(
          angle: widget.aci * (1 - yakin.clamp(0.0, 1.0)),
          child: Transform.scale(
            scale: 1 + 0.12 * yakin,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(child: cocuk!),
                // Numara mührü kartın sağ üst köşesine basılmış gibi.
                Positioned(
                  right: -14,
                  top: -16,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: widget.soluk && t == 0 ? 0.55 : 1,
                      child: _NumaraMuhru(sira: b.sira, bitti: bitti),
                    ),
                  ),
                ),
                if (t > 0)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: CarpiCizici(
                          ((t - 0.38) / 0.2).clamp(0.0, 1.0),
                          ((t - 0.58) / 0.2).clamp(0.0, 1.0),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      child: Semantics(
        button: true,
        label: '${m.bolumNo(b.sira)}: ${b.baslik}',
        // Sırası gelmemiş bölüm soluk; dokununca (büyürken) canlanır.
        child: AnimatedBuilder(
          animation: _ac,
          builder: (context, c) => Opacity(opacity: widget.soluk && _ac.value == 0 ? 0.55 : 1, child: c),
          child: kart,
        ),
      ),
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

/// Kartın ortasına iki fırça darbesiyle çizilen çarpı (eski haritalardaki
/// "burası" işareti). [birinci] ve [ikinci] darbelerin ne kadarının
/// çizildiği (0–1).
class CarpiCizici extends CustomPainter {
  const CarpiCizici(this.birinci, this.ikinci);

  final double birinci;
  final double ikinci;

  @override
  void paint(Canvas canvas, Size size) {
    if (birinci <= 0) return;
    final m = size.center(Offset.zero);
    final r = math.min(size.width, size.height) * 0.36;
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(6, r * 0.14)
      ..color = Palet.kina.withValues(alpha: 0.88);
    void darbe(Offset a, Offset b, Offset bukum, double oran) {
      if (oran <= 0) return;
      final p = Path()
        ..moveTo(a.dx, a.dy)
        ..quadraticBezierTo(bukum.dx, bukum.dy, b.dx, b.dy);
      for (final olcu in p.computeMetrics()) {
        canvas.drawPath(olcu.extractPath(0, olcu.length * oran), kalem);
      }
    }

    darbe(m + Offset(-r, -r), m + Offset(r, r), m + Offset(r * 0.12, -r * 0.1), birinci);
    darbe(m + Offset(r, -r), m + Offset(-r, r), m + Offset(r * 0.08, r * 0.12), ikinci);
  }

  @override
  bool shouldRepaint(CarpiCizici eski) => eski.birinci != birinci || eski.ikinci != ikinci;
}

/// Sayfanın parşömen zemini ve kartları bağlayan noktalı yol.
class YolCizici extends CustomPainter {
  const YolCizici(this.yerlesim);

  final YolYerlesimi yerlesim;

  @override
  void paint(Canvas canvas, Size size) {
    final alan = Offset.zero & size;
    canvas.drawRect(alan, Paint()..color = Palet.kagit);
    // Hafif lekeler (sabit tohum): eski kâğıt.
    final rnd = math.Random(605);
    final leke = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    for (var i = 0; i < (size.height / 120).ceil(); i++) {
      leke.color = Color.fromARGB(10 + rnd.nextInt(14), 120, 80, 40);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        size.width * (0.08 + rnd.nextDouble() * 0.16),
        leke,
      );
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

    // Noktalı yol: başlıktan ilk karta, kartlar arasında ve sondan aşağı.
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
      // Son bölümden "Yakında" kartına giden yol soluklaşır: henüz yürünmedi.
      final a = k.last.bottomCenter + Offset(k.last.width * 0.12 * (k.length.isOdd ? 1 : -1), 0);
      final b = yakinda.topCenter;
      final p = Path()
        ..moveTo(a.dx, a.dy)
        ..cubicTo(a.dx, a.dy + 46, b.dx, b.dy - 46, b.dx, b.dy);
      for (final olcu in p.computeMetrics()) {
        for (var d = 6.0; d < olcu.length - 4; d += 11) {
          final oran = d / olcu.length;
          canvas.drawCircle(
            olcu.getTangentForOffset(d)!.position,
            2.3 - oran * 0.8,
            Paint()..color = Palet.murekkep.withValues(alpha: 0.5 - oran * 0.3),
          );
        }
      }
      // Kartın altında, aşağıda solan birkaç nokta (sonraki dönemler).
      final son = yakinda.bottomCenter;
      for (var i = 1; i <= 5; i++) {
        canvas.drawCircle(
          son + Offset(math.sin(i * 0.7) * 10, i * 12.0),
          1.6,
          Paint()..color = Palet.murekkep.withValues(alpha: 0.25 * (1 - i / 6)),
        );
      }
    }

    // Kenar süsleri: kartların boş bıraktığı yanlarda küçük kum tepeleri.
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = Palet.murekkep.withValues(alpha: 0.3);
    final rt = math.Random(17);
    for (var i = 0; i < k.length * 2; i++) {
      final p = Offset(20 + rt.nextDouble() * (size.width - 40), yerlesim.ust + rt.nextDouble() * (size.height - yerlesim.ust - 60));
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

/// Yolun sonundaki, henüz gelmemiş dönemin kartı: kesik çizgili kenar,
/// soluk kâğıt, kum saati mührü. Dokunulmaz.
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
                    color: Palet.murekkepSoluk,
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
                      color: Palet.murekkep,
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
                    color: Palet.murekkepSoluk,
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
    canvas.drawRRect(rr, Paint()..color = Palet.kagitAcik.withValues(alpha: 0.45));
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = Palet.murekkep.withValues(alpha: 0.45);
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
