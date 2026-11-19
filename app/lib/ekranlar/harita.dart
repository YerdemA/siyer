import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../l10n/app_localizations.dart';
import 'atif_listesi.dart';
import 'harita_cografya.dart';

/// Parşömen harita (docs/GORSEL_USLUP.md → Harita). Gerçek harita değildir;
/// yerler yaklaşık konumlarıyla işaretlenir. Kıyı, dağ süsleri, pusula ve
/// kervan yolları kodla, mürekkep çizimi gibi çizilir ([ParsomenCizici]).
///
/// [bolge] `tum` (bütün harita) ya da `mekke` (Mekke çevresi, büyütülmüş).
/// Bütün haritada Mekke çevresindeki yakın yerler gizlenir; yerine dokununca
/// ayrıntı haritasını açan bir çerçeve çizilir.
class HaritaEkrani extends ConsumerWidget {
  const HaritaEkrani({super.key, this.bolge = 'tum'});

  final String bolge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final b = haritaBolgeleri[bolge] ?? tumHarita;
    final tum = b.id == tumHarita.id;
    final yerler = ref.watch(yerlerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(tum ? m.harita : m.haritaMekkeCevresi)),
      backgroundColor: const Color(0xFF1B1511),
      body: yerler.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) {
          final gorunen = [
            for (final y in liste)
              if (b.icerir(Offset(y.x, y.y)) && (!tum || y.id == 'mekke' || !mekkeCevresi.icerir(Offset(y.x, y.y)))) y,
          ];
          final konumlar = {for (final y in liste) y.id: Offset(y.x, y.y)};
          return InteractiveViewer(
            maxScale: 6,
            child: Center(
              child: AspectRatio(
                aspectRatio: b.oran,
                child: LayoutBuilder(builder: (context, k) {
                  final boyut = Size(k.maxWidth, k.maxHeight);
                  Offset ekran(Offset p) => Offset(
                        (p.dx - b.alan.left) / b.alan.width * boyut.width,
                        (p.dy - b.alan.top) / b.alan.height * boyut.height,
                      );
                  final cerceve = tum
                      ? Rect.fromPoints(ekran(mekkeCevresi.alan.topLeft), ekran(mekkeCevresi.alan.bottomRight))
                      : null;
                  final cerceveEtiketi = cerceve == null
                      ? null
                      : Rect.fromLTWH(cerceve.right + 4, cerceve.center.dy - 9, m.haritaMekkeCevresi.length * 6.6 + 22, 18);
                  final yerlesim = etiketYerlesimi(
                    gorunen,
                    boyut,
                    konum: (y) => ekran(Offset(y.x, y.y)),
                    dolu: [?cerceveEtiketi],
                  );
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: ParsomenCizici(
                            pencere: b.alan,
                            suslerKagitta: tum,
                            yerler: konumlar,
                            bos: [
                              for (final e in yerlesim) ...[e.etiket, Rect.fromCircle(center: e.nokta, radius: 10)],
                              ?cerceve,
                              ?cerceveEtiketi,
                            ],
                            kuzey: m.pusulaKuzey,
                            kizildeniz: tum ? m.haritaKizildeniz : '',
                          ),
                        ),
                      ),
                      Positioned.fill(child: CustomPaint(painter: _CizgiCizici(yerlesim))),
                      if (cerceve != null) ...[
                        Positioned.fromRect(
                          rect: cerceve,
                          child: GestureDetector(
                            onTap: () => context.push('/harita/mekke'),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xAA4A2F1B), width: 1.2),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fromRect(
                          rect: cerceveEtiketi!,
                          child: _CerceveEtiketi(
                            metin: m.haritaMekkeCevresi,
                            onTap: () => context.push('/harita/mekke'),
                          ),
                        ),
                      ],
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
          );
        },
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
/// [konum] yerin ekrandaki noktası (verilmezse x, y doğrudan [alan]'a
/// oranlanır); [dolu] etiketlerin kaçınacağı başka alanlar.
List<EtiketYeri> etiketYerlesimi(
  List<Yer> yerler,
  Size alan, {
  Offset Function(Yer)? konum,
  List<Rect> dolu = const [],
}) {
  const yukseklik = 16.0;
  const basamaklar = [10.0, -26.0, 28.0, -44.0, 46.0, -62.0, 64.0, -80.0, 82.0];
  final noktalar = {
    for (final y in yerler) y.id: konum?.call(y) ?? Offset(y.x * alan.width, y.y * alan.height),
  };
  final kapali = [...dolu, for (final n in noktalar.values) Rect.fromCircle(center: n, radius: 9)];
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
      if (!kapali.any((d) => d.overlaps(r))) {
        secilen = r;
        break;
      }
    }
    kapali.add(secilen);
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

const _etiketYazisi = TextStyle(
  color: _murekkep,
  fontSize: 12,
  height: 1.2,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.italic,
);

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
            style: _etiketYazisi,
          ),
        ),
      );
}

class _CerceveEtiketi extends StatelessWidget {
  const _CerceveEtiketi({required this.metin, required this.onTap});

  final String metin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: metin,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.zoom_in, size: 16, color: _murekkep),
              const SizedBox(width: 2),
              Flexible(
                child: Text(metin, maxLines: 1, softWrap: false, overflow: TextOverflow.visible, style: _etiketYazisi),
              ),
            ],
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

/// Parşömen zemini ve mürekkep çizimi: kâğıt, deniz (kıyıya koşut dalga
/// çizgileriyle), kıyı, dağ ve kum süsleri, kervan yolları, pusula ve kenar
/// çerçevesi. [pencere] haritanın ekranda görünen bölümüdür (0–1 harita
/// koordinatlarında; bütün harita için (0, 0, 1, 1)). [bos] alanlara (nokta,
/// etiket) süs konmaz.
///
/// [suslerKagitta]: kenar kararması, lekeler, pusula ve çerçeve kâğıdın
/// kendisine çizilir; pencere kâğıttan genişse dışı karanlık masa olur
/// (oynatıcıdaki harita geçişinde kamera kâğıdın üstünde gezer). Yanlışsa
/// bunlar ekrana çizilir (büyütülmüş "Mekke çevresi" haritası).
class ParsomenCizici extends CustomPainter {
  const ParsomenCizici({
    this.pencere = const Rect.fromLTRB(0, 0, 1, 1),
    this.suslerKagitta = true,
    this.yerler = const {},
    this.bos = const [],
    this.kuzey = 'K',
    this.kizildeniz = '',
  });

  final Rect pencere;
  final bool suslerKagitta;

  /// Yer kimliği → harita koordinatı (0–1); kervan yolları için.
  final Map<String, Offset> yerler;
  final List<Rect> bos;
  final String kuzey;
  final String kizildeniz;

  static const _kagit = Color(0xFFE6D3A8);
  static const _deniz = Color(0xFFC9C6A6);
  static const masa = Color(0xFF1B1511);

  @override
  void paint(Canvas canvas, Size size) {
    final alan = Offset.zero & size;
    final b = pencere;
    Offset ekran(Offset p) => Offset(
          (p.dx - b.left) / b.width * size.width,
          (p.dy - b.top) / b.height * size.height,
        );
    Offset nokta(Nokta n) => ekran(izdusum(n.$1, n.$2));
    Path cizgi(List<Nokta> l) {
      final p = Path()..moveTo(nokta(l.first).dx, nokta(l.first).dy);
      for (final n in l.skip(1)) {
        final e = nokta(n);
        p.lineTo(e.dx, e.dy);
      }
      return p;
    }

    final kagit = Rect.fromPoints(ekran(Offset.zero), ekran(const Offset(1, 1)));
    // Süslerin çerçevesi: kâğıt ya da ekran.
    final cerceve = suslerKagitta ? kagit : alan;
    // Haritanın kendi ölçeği (kâğıt genişliği); süsler buna göre büyür.
    final birim = kagit.width;
    canvas.save();
    canvas.clipRect(alan);
    if (suslerKagitta) {
      canvas.drawRect(alan, Paint()..color = masa);
      canvas.clipRect(kagit);
    }
    canvas.drawRect(alan, Paint()..color = _kagit);

    // Deniz: Kızıldeniz (iki kıyı arası) ve Akdeniz (sol üst köşe).
    final kizil = cizgi(arabistanKiyisi);
    for (final n in afrikaKiyisi.reversed) {
      final e = nokta(n);
      kizil.lineTo(e.dx, e.dy);
    }
    kizil.close();
    final ak = cizgi(akdenizKiyisi);
    for (final n in const <Nokta>[(36.0, 30.0), (30.0, 30.0)]) {
      final e = nokta(n);
      ak.lineTo(e.dx, e.dy);
    }
    ak.close();
    final deniz = Path.combine(PathOperation.union, kizil, ak);
    canvas.drawPath(deniz, Paint()..color = _deniz);

    // Kıyıya koşut dalga çizgileri (eski haritalardaki gibi), denize doğru.
    canvas.save();
    canvas.clipPath(deniz);
    final dalga = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final arabistan = cizgi(arabistanKiyisi);
    final afrika = cizgi(afrikaKiyisi);
    final akdenizKiyi = cizgi(akdenizKiyisi);
    for (var i = 1; i <= 3; i++) {
      final d = i * 0.012 * cerceve.width;
      dalga.color = _murekkep.withValues(alpha: 0.32 - i * 0.07);
      canvas.drawPath(arabistan.shift(Offset(-d, 0)), dalga);
      canvas.drawPath(akdenizKiyi.shift(Offset(-d, 0)), dalga);
      canvas.drawPath(afrika.shift(Offset(d, 0)), dalga);
    }
    canvas.restore();

    // Kıyı çizgisi.
    final kiyi = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeJoin = StrokeJoin.round
      ..color = _murekkep.withValues(alpha: 0.85);
    canvas.drawPath(arabistan, kiyi);
    canvas.drawPath(afrika, kiyi);
    canvas.drawPath(akdenizKiyi, kiyi);

    // Deniz adı (Akdeniz köşede çok dar, adı yazılmaz).
    if (kizildeniz.isNotEmpty) {
      final a = nokta((25.8, 35.6)), z = nokta((17.8, 40.6));
      _yazi(canvas, kizildeniz, nokta((22.45, 37.75)), math.atan2(z.dy - a.dy, z.dx - a.dx), birim * 0.032);
    }

    // Kum: kara üstünde ince serpinti ve küçük kum tepeleri.
    final sus = cerceve.deflate(16);
    final serpinti = Paint()..color = _murekkep.withValues(alpha: 0.16);
    final rs = math.Random(9);
    for (var i = 0; i < 420; i++) {
      final p = ekran(Offset(rs.nextDouble(), rs.nextDouble()));
      final r = 0.5 + rs.nextDouble() * 0.5;
      if (!sus.contains(p) || deniz.contains(p)) continue;
      canvas.drawCircle(p, r, serpinti);
    }
    final daglarEkranda = [for (final d in daglar) nokta(d)];
    final tepeBoyu = math.min(birim * 0.03, 15.0);
    final rt = math.Random(41);
    for (var i = 0; i < 34; i++) {
      final p = ekran(Offset(0.06 + rt.nextDouble() * 0.9, 0.08 + rt.nextDouble() * 0.88));
      final r = Rect.fromCenter(center: p, width: tepeBoyu * 3, height: tepeBoyu * 1.8);
      if (!sus.contains(p) ||
          deniz.contains(p) ||
          deniz.contains(r.centerLeft) ||
          deniz.contains(r.centerRight) ||
          bos.any((x) => x.overlaps(r)) ||
          daglarEkranda.any((d) => (d - p).distance < tepeBoyu * 3)) {
        continue;
      }
      _kumTepesi(canvas, p, tepeBoyu);
    }

    // Dağ süsleri: noktaların ve etiketlerin üstüne gelmez.
    final dagBoyu = math.min(birim * 0.03, 16.0);
    for (final p in daglarEkranda) {
      final r = Rect.fromCenter(center: p, width: dagBoyu * 3, height: dagBoyu * 1.6);
      if (!sus.contains(p) || bos.any((x) => x.overlaps(r))) continue;
      _dag(canvas, p, dagBoyu);
    }

    // Kervan yolları: kesik çizgi.
    final yol = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..color = const Color(0xFF7A3B1E).withValues(alpha: 0.55);
    for (final y in kervanYollari) {
      final noktalar = [for (final id in y) if (yerler[id] != null) ekran(yerler[id]!)];
      for (var i = 0; i + 1 < noktalar.length; i++) {
        _kesik(canvas, noktalar[i], noktalar[i + 1], yol, math.min(cerceve.width * 0.012, 10));
      }
    }

    // Kâğıt dokusu: kenarlarda kararma, sabit tohumlu hafif lekeler.
    canvas.drawRect(
      cerceve,
      Paint()
        ..shader = const RadialGradient(
          radius: 0.85,
          colors: [Color(0x00000000), Color(0x00000000), Color(0x664A2F1B)],
          stops: [0, 0.6, 1],
        ).createShader(cerceve),
    );
    final rnd = math.Random(605);
    final leke = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    for (var i = 0; i < 14; i++) {
      leke.color = Color.fromARGB(14 + rnd.nextInt(14), 120, 80, 40);
      canvas.drawCircle(
        cerceve.topLeft + Offset(rnd.nextDouble() * cerceve.width, rnd.nextDouble() * cerceve.height),
        cerceve.shortestSide * (0.04 + rnd.nextDouble() * 0.1),
        leke,
      );
    }

    // Pusula: sağ üst köşe.
    final kisa = math.min(cerceve.width, cerceve.height * 1.2);
    _pusula(canvas, cerceve.topLeft + Offset(cerceve.width - kisa * 0.14, kisa * 0.14), kisa * 0.07);

    // Çift kenar çerçevesi.
    final kenar = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0x994A2F1B);
    canvas.drawRect(cerceve.deflate(10), kenar..strokeWidth = 1.5);
    canvas.drawRect(cerceve.deflate(14), kenar..strokeWidth = 0.6);
    canvas.restore();
  }

  /// Küçük bir kum tepesi: üst üste iki yay, altında birkaç kum tanesi.
  void _kumTepesi(Canvas canvas, Offset p, double s) {
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..color = _murekkep.withValues(alpha: 0.42);
    canvas.drawPath(
      Path()
        ..moveTo(p.dx - s, p.dy)
        ..quadraticBezierTo(p.dx - s * 0.25, p.dy - s * 0.75, p.dx + s * 0.7, p.dy - s * 0.05),
      kalem,
    );
    kalem.color = _murekkep.withValues(alpha: 0.3);
    canvas.drawPath(
      Path()
        ..moveTo(p.dx - s * 0.1, p.dy + s * 0.35)
        ..quadraticBezierTo(p.dx + s * 0.5, p.dy - s * 0.15, p.dx + s * 1.2, p.dy + s * 0.3),
      kalem,
    );
    final tane = Paint()..color = _murekkep.withValues(alpha: 0.3);
    for (final d in const [Offset(-0.5, 0.35), Offset(0.05, 0.6), Offset(0.6, 0.62)]) {
      canvas.drawCircle(p + d * s, 0.8, tane);
    }
  }

  void _yazi(Canvas canvas, String metin, Offset merkez, double aci, double boy) {
    if (metin.isEmpty) return;
    final tp = TextPainter(
      text: TextSpan(
        text: metin,
        style: TextStyle(
          color: _murekkep.withValues(alpha: 0.6),
          fontSize: boy,
          fontStyle: FontStyle.italic,
          letterSpacing: boy * 0.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(merkez.dx, merkez.dy);
    canvas.rotate(aci);
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  /// Küçük bir dağ: iki tepe, gölgeli yamaç.
  void _dag(Canvas canvas, Offset p, double s) {
    final kalem = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeJoin = StrokeJoin.round
      ..color = _murekkep.withValues(alpha: 0.6);
    final golge = Paint()..color = _murekkep.withValues(alpha: 0.14);
    void tepe(Offset t, double g) {
      final sol = t + Offset(-g, g * 0.9), sag = t + Offset(g, g * 0.9);
      canvas.drawPath(Path()..moveTo(t.dx, t.dy)..lineTo(sag.dx, sag.dy)..lineTo(t.dx, sag.dy)..close(), golge);
      canvas.drawPath(Path()..moveTo(sol.dx, sol.dy)..lineTo(t.dx, t.dy)..lineTo(sag.dx, sag.dy), kalem);
    }

    tepe(p + Offset(-s * 0.45, -s * 0.35), s * 0.75);
    tepe(p + Offset(s * 0.5, -s * 0.1), s * 0.55);
  }

  void _kesik(Canvas canvas, Offset a, Offset b, Paint kalem, double adim) {
    final uzunluk = (b - a).distance;
    if (uzunluk == 0) return;
    final yon = (b - a) / uzunluk;
    for (var t = 0.0; t < uzunluk; t += adim * 1.8) {
      canvas.drawLine(a + yon * t, a + yon * math.min(t + adim, uzunluk), kalem);
    }
  }

  void _pusula(Canvas canvas, Offset m, double r) {
    final ince = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = _murekkep.withValues(alpha: 0.7);
    final koyu = Paint()..color = _murekkep.withValues(alpha: 0.75);
    final acik = Paint()..color = const Color(0xFFF0E2BF);
    canvas.drawCircle(m, r * 0.78, ince);
    canvas.drawCircle(m, r * 0.7, ince);
    for (var i = 0; i < 8; i++) {
      final aci = -math.pi / 2 + i * math.pi / 4;
      final uzun = i.isEven ? r : r * 0.55;
      final ucu = m + Offset(math.cos(aci), math.sin(aci)) * uzun;
      final yan = Offset(math.cos(aci + math.pi / 2), math.sin(aci + math.pi / 2)) * (r * 0.13);
      // Her kol iki yarım: biri koyu, biri açık (eski pusula güllerindeki gibi).
      canvas.drawPath(Path()..moveTo(m.dx, m.dy)..lineTo(ucu.dx, ucu.dy)..lineTo(m.dx + yan.dx, m.dy + yan.dy)..close(), koyu);
      final ac = Path()..moveTo(m.dx, m.dy)..lineTo(ucu.dx, ucu.dy)..lineTo(m.dx - yan.dx, m.dy - yan.dy)..close();
      canvas.drawPath(ac, acik);
      canvas.drawPath(ac, ince);
    }
    final tp = TextPainter(
      text: TextSpan(
        text: kuzey,
        style: TextStyle(color: _murekkep, fontSize: r * 0.42, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, m + Offset(-tp.width / 2, -r - tp.height - 2));
  }

  @override
  bool shouldRepaint(ParsomenCizici eski) =>
      eski.pencere != pencere || eski.yerler != yerler || eski.bos != bos || eski.kuzey != kuzey;
}
