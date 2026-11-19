import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../ekranlar/harita.dart';
import '../ekranlar/harita_cografya.dart';
import '../icerik/model.dart';
import '../l10n/app_localizations.dart';
import '../tema.dart';

/// Haritanın kamerası: ekranın ortasına gelen nokta (0–1 harita
/// koordinatları) ve görünen yükseklik (1 = bütün haritanın boyu).
class HaritaKamerasi {
  const HaritaKamerasi(this.merkez, this.yukseklik);

  /// Bütün harita, kenarda biraz masa payıyla.
  static const tum = HaritaKamerasi(Offset(0.5, 0.5), 1.08);

  /// Bir yere yakın çekim. Mekke çevresindeki yerler birbirine çok yakın
  /// olduğundan daha çok yaklaşılır.
  factory HaritaKamerasi.yer(Yer y) {
    final p = Offset(y.x, y.y);
    return HaritaKamerasi(p, mekkeCevresi.icerir(p) ? 0.09 : 0.28);
  }

  final Offset merkez;
  final double yukseklik;

  /// Ekranda görünen pencere; harita 3:4, ekran ne oranda olursa.
  Rect pencere(Size ekran) {
    final g = yukseklik * ekran.width * 4 / (3 * ekran.height);
    return Rect.fromCenter(center: merkez, width: g, height: yukseklik);
  }

  /// Yakınlık logaritmik değişir; böylece yaklaşma hızı her ölçekte aynı görünür.
  static HaritaKamerasi ara(HaritaKamerasi a, HaritaKamerasi b, double t) => HaritaKamerasi(
        Offset.lerp(a.merkez, b.merkez, t)!,
        math.exp(ui.lerpDouble(math.log(a.yukseklik), math.log(b.yukseklik), t)!),
      );
}

/// Bölüm başında ve uzak bir yere geçilirken araya giren harita: önceki
/// yerden (yoksa bütün haritadan) uzaklaşır, bütün haritayı gösterir, yeni
/// yere yaklaşır ve yerin adını gösterir. Dokununca ya da "Geç"le biter.
///
/// Mekke ile Hira gibi aynı çevredeki yerler arasında gösterilmez
/// ([haritaGecisiGerekir]).
class HaritaGecisi extends StatefulWidget {
  const HaritaGecisi({
    super.key,
    required this.yerler,
    required this.hedef,
    this.onceki,
    required this.bitti,
    this.efekt,
  });

  /// Açılışta `parsomen` sesini çalmak için.
  final void Function(String ad)? efekt;

  final List<Yer> yerler;
  final Yer hedef;
  final Yer? onceki;
  final VoidCallback bitti;

  @override
  State<HaritaGecisi> createState() => _HaritaGecisiState();
}

/// Sahne [onceki]den [yeni]ye geçerken harita gösterilmeli mi: yer değiştiyse
/// ve ikisi birden Mekke çevresinde değilse.
bool haritaGecisiGerekir(Yer? onceki, Yer yeni) {
  if (onceki == null) return true;
  if (onceki.id == yeni.id) return false;
  return !(mekkeCevresi.icerir(Offset(onceki.x, onceki.y)) && mekkeCevresi.icerir(Offset(yeni.x, yeni.y)));
}

class _HaritaGecisiState extends State<HaritaGecisi> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.onceki == null ? 3600 : 4800),
  )
    ..addStatusListener((d) {
      if (d == AnimationStatus.completed) widget.bitti();
    })
    ..forward();

  @override
  void initState() {
    super.initState();
    widget.efekt?.call('parsomen');
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  void _gec() {
    if (_ac.isAnimating) _ac.stop();
    widget.bitti();
  }

  /// Zamana göre kamera: (önceki yer →) bütün harita → hedef.
  HaritaKamerasi _kamera(double t) {
    final hedef = HaritaKamerasi.yer(widget.hedef);
    double evre(double bas, double son) => Curves.easeInOut.transform(((t - bas) / (son - bas)).clamp(0.0, 1.0));
    if (widget.onceki == null) {
      return HaritaKamerasi.ara(HaritaKamerasi.tum, hedef, evre(0.25, 0.8));
    }
    final ilk = HaritaKamerasi.yer(widget.onceki!);
    final uzak = HaritaKamerasi.ara(ilk, HaritaKamerasi.tum, evre(0.1, 0.38));
    return HaritaKamerasi.ara(uzak, hedef, evre(0.46, 0.84));
  }

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final konumlar = {for (final y in widget.yerler) y.id: Offset(y.x, y.y)};
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _gec,
      child: AnimatedBuilder(
        animation: _ac,
        builder: (context, _) {
          final t = _ac.value;
          final gorunur = math.min((t / 0.06).clamp(0.0, 1.0), ((1 - t) / 0.08).clamp(0.0, 1.0));
          return Opacity(
            opacity: gorunur,
            child: LayoutBuilder(builder: (context, k) {
              final ekran = Size(k.maxWidth, k.maxHeight);
              final pencere = _kamera(t).pencere(ekran);
              return Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: ParsomenCizici(
                      pencere: pencere,
                      yerler: konumlar,
                      kuzey: m.pusulaKuzey,
                      kizildeniz: m.haritaKizildeniz,
                    ),
                  ),
                  CustomPaint(
                    painter: _IsaretCizici(
                      pencere: pencere,
                      yerler: widget.yerler,
                      hedef: widget.hedef,
                      onceki: widget.onceki,
                      t: t,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 12,
                    child: TextButton.icon(
                      onPressed: _gec,
                      style: TextButton.styleFrom(
                        foregroundColor: Palet.kagitAcik,
                        backgroundColor: Palet.murekkep.withValues(alpha: 0.72),
                      ),
                      icon: const Icon(Icons.skip_next),
                      label: Text(m.haritaGec),
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}

/// Yer noktaları; hedefin çevresinde nabız gibi atan halka ve adı.
class _IsaretCizici extends CustomPainter {
  const _IsaretCizici({
    required this.pencere,
    required this.yerler,
    required this.hedef,
    required this.onceki,
    required this.t,
  });

  final Rect pencere;
  final List<Yer> yerler;
  final Yer hedef;
  final Yer? onceki;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    Offset ekran(Yer y) => Offset(
          (y.x - pencere.left) / pencere.width * size.width,
          (y.y - pencere.top) / pencere.height * size.height,
        );
    final dolgu = Paint()..color = Palet.kina;
    final kenar = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = Palet.murekkep;
    for (final y in yerler) {
      final p = ekran(y);
      if (!(Offset.zero & size).inflate(20).contains(p)) continue;
      final r = y.id == hedef.id ? 7.0 : 4.5;
      canvas.drawCircle(p, r, dolgu);
      canvas.drawCircle(p, r, kenar);
    }
    // Önceki yerin adı, uzaklaşırken söner.
    if (onceki != null) {
      _ad(canvas, ekran(onceki!), onceki!.ad, (1 - t / 0.3).clamp(0.0, 1.0), 18);
    }
    // Hedef: yaklaşma sonunda halka ve ad.
    final belir = ((t - (onceki == null ? 0.6 : 0.68)) / 0.14).clamp(0.0, 1.0);
    if (belir > 0) {
      final p = ekran(hedef);
      final nabiz = (t * 3) % 1;
      canvas.drawCircle(
        p,
        10 + 22 * nabiz,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Palet.kina.withValues(alpha: belir * (1 - nabiz) * 0.8),
      );
      _ad(canvas, p, hedef.ad, belir, 24);
    }
  }

  /// Yerin adı, noktanın altında, parşömen bir şerit üstünde.
  void _ad(Canvas canvas, Offset p, String ad, double opaklik, double boy) {
    if (opaklik <= 0) return;
    final tp = TextPainter(
      text: TextSpan(
        text: ad,
        style: TextStyle(
          fontFamily: baslikYazisi,
          fontSize: boy,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Palet.murekkep.withValues(alpha: opaklik),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final kutu = Rect.fromCenter(
      center: p + Offset(0, boy + 8),
      width: tp.width + boy,
      height: tp.height + boy * 0.35,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(kutu, const Radius.circular(4)),
      Paint()..color = Palet.kagitAcik.withValues(alpha: 0.85 * opaklik),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(kutu, const Radius.circular(4)),
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Palet.murekkep.withValues(alpha: 0.5 * opaklik),
    );
    tp.paint(canvas, kutu.center - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_IsaretCizici eski) => eski.t != t || eski.pencere != pencere;
}
