import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../l10n/app_localizations.dart';
import 'atif_listesi.dart';

/// Parşömen harita (docs/GORSEL_USLUP.md → Harita). Gerçek harita değildir;
/// yerler yaklaşık konumlarıyla işaretlenir. Parşömen illüstrasyonu gelene
/// kadar zemin kodla çizilir.
class HaritaEkrani extends ConsumerWidget {
  const HaritaEkrani({super.key});

  /// Parşömenin en/boy oranı (yerler.json'daki x, y bu alana göre 0–1).
  static const oran = 3 / 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final yerler = ref.watch(yerlerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(m.harita)),
      backgroundColor: const Color(0xFF1B1511),
      body: yerler.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) => InteractiveViewer(
          maxScale: 6,
          child: Center(
            child: AspectRatio(
              aspectRatio: oran,
              child: LayoutBuilder(builder: (context, k) {
                final yerlesim = etiketYerlesimi(liste, Size(k.maxWidth, k.maxHeight));
                return Stack(
                  children: [
                    const Positioned.fill(child: CustomPaint(painter: ParsomenCizici())),
                    Positioned.fill(child: CustomPaint(painter: _CizgiCizici(yerlesim))),
                    for (final e in yerlesim) ...[
                      Positioned(
                        left: e.nokta.dx - 8,
                        top: e.nokta.dy - 8,
                        child: _Nokta(yer: e.yer, onTap: () => _yerGoster(context, e.yer)),
                      ),
                      Positioned.fromRect(
                        rect: e.etiket,
                        child: _Etiket(yer: e.yer, onTap: () => _yerGoster(context, e.yer)),
                      ),
                    ],
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _yerGoster(BuildContext context, Yer y) {
    final m = Metinler.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (c) => Consumer(builder: (c, ref, _) {
        final bolumler = ref.watch(bolumListesiProvider).value ?? const <Bolum>[];
        final tema = Theme.of(c).textTheme;
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Text(y.ad, style: tema.titleLarge),
            if (y.ozet.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(y.ozet),
              const SizedBox(height: 4),
              AtifListesi(iddialar: y.iddialar),
            ],
            const SizedBox(height: 8),
            Text(m.konumYaklasik, style: tema.bodySmall?.copyWith(color: Theme.of(c).hintColor)),
            for (final id in y.bolumler)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.play_circle_outline),
                title: Text(bolumler.where((b) => b.id == id).firstOrNull?.baslik ?? id),
                onTap: () {
                  Navigator.pop(c);
                  context.push('/bolum/$id');
                },
              ),
          ],
        );
      }),
    );
  }
}

/// Bir yerin noktası ve etiketinin ekrandaki yeri.
class EtiketYeri {
  const EtiketYeri(this.yer, this.nokta, this.etiket);
  final Yer yer;
  final Offset nokta;
  final Rect etiket;

  /// Etiket noktadan uzağa itildiyse aralarına çizgi çekilir.
  bool get cizgili => (etiket.center.dy - nokta.dy).abs() > 30;
}

/// Etiketleri birbirine ve noktalara binmeyecek biçimde yerleştirir: önce
/// noktanın altı, sonra üstü, sonra giderek uzaklaşan basamaklar.
List<EtiketYeri> etiketYerlesimi(List<Yer> yerler, Size alan) {
  const yukseklik = 16.0;
  const basamaklar = [10.0, -26.0, 28.0, -44.0, 46.0, -62.0, 64.0, -80.0, 82.0];
  final noktalar = {for (final y in yerler) y.id: Offset(y.x * alan.width, y.y * alan.height)};
  final dolu = [for (final n in noktalar.values) Rect.fromCircle(center: n, radius: 9)];
  final sirali = [...yerler]..sort((a, b) => a.y != b.y ? a.y.compareTo(b.y) : a.x.compareTo(b.x));
  final sonuc = <EtiketYeri>[];
  for (final y in sirali) {
    final n = noktalar[y.id]!;
    final genislik = y.ad.length * 6.6 + 8;
    Rect aday(double dy) {
      final r = Rect.fromLTWH(n.dx - genislik / 2, n.dy + dy, genislik, yukseklik);
      // Parşömen dışına taşmasın.
      final sol = r.left.clamp(2.0, math.max(2.0, alan.width - genislik - 2));
      return r.translate(sol - r.left, 0);
    }

    var secilen = aday(basamaklar.first);
    for (final dy in basamaklar) {
      final r = aday(dy);
      if (!dolu.any((d) => d.overlaps(r))) {
        secilen = r;
        break;
      }
    }
    dolu.add(secilen);
    sonuc.add(EtiketYeri(y, n, secilen));
  }
  return sonuc;
}

const _murekkep = Color(0xFF4A2F1B);

class _Nokta extends StatelessWidget {
  const _Nokta({required this.yer, required this.onTap});

  final Yer yer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _murekkep, width: 2),
            color: const Color(0xFF9C3B22),
          ),
        ),
      );
}

class _Etiket extends StatelessWidget {
  const _Etiket({required this.yer, required this.onTap});

  final Yer yer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: yer.ad,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Text(
            yer.ad,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
            style: const TextStyle(
              color: _murekkep,
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
}

class _CizgiCizici extends CustomPainter {
  const _CizgiCizici(this.yerlesim);
  final List<EtiketYeri> yerlesim;

  @override
  void paint(Canvas canvas, Size size) {
    final kalem = Paint()
      ..color = const Color(0x994A2F1B)
      ..strokeWidth = 1;
    for (final e in yerlesim.where((e) => e.cizgili)) {
      final hedef = e.etiket.center.dy > e.nokta.dy ? e.etiket.topCenter : e.etiket.bottomCenter;
      canvas.drawLine(e.nokta, hedef, kalem);
    }
  }

  @override
  bool shouldRepaint(_CizgiCizici eski) => eski.yerlesim != yerlesim;
}

/// Geçici parşömen zemini: sıcak kâğıt rengi, kenarlarda kararma, hafif leke.
/// Kıyı çizgisi ya da gerçek coğrafya çizilmez (kaynak gerektirir).
class ParsomenCizici extends CustomPainter {
  const ParsomenCizici();

  @override
  void paint(Canvas canvas, Size size) {
    final alan = Offset.zero & size;
    canvas.drawRect(alan, Paint()..color = const Color(0xFFE6D3A8));
    canvas.drawRect(
      alan,
      Paint()
        ..shader = RadialGradient(
          radius: 0.85,
          colors: const [Color(0x00000000), Color(0x00000000), Color(0x664A2F1B)],
          stops: const [0, 0.6, 1],
        ).createShader(alan),
    );
    // Sabit tohumlu hafif lekeler: her açılışta aynı görünür.
    final rnd = math.Random(605);
    final leke = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    for (var i = 0; i < 14; i++) {
      leke.color = Color.fromARGB(18 + rnd.nextInt(18), 120, 80, 40);
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        size.shortestSide * (0.04 + rnd.nextDouble() * 0.1),
        leke,
      );
    }
    canvas.drawRect(
      alan.deflate(10),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = const Color(0x994A2F1B),
    );
  }

  @override
  bool shouldRepaint(ParsomenCizici eski) => false;
}
