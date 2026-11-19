import 'package:flutter/material.dart';

import '../icerik/model.dart';
import '../oynatici/gorsel_onbellek.dart';
import '../tema.dart';

/// Şahsın yuvarlak madalyonu. CLAUDE.md kural 5'e göre:
/// - `temsil: nur` (Efendimiz, diğer peygamberler, melek): yalnız ışık, figür yok.
/// - `temsil: yuzsuz` (anne-babası, eşleri, çocukları, süt anneleri): yüzsüz
///   bir siluet.
/// - `portre` dolu: karakter kartından kırpılmış portre.
/// - Hiçbiri: adın baş harfi.
class SahisMadalyonu extends StatelessWidget {
  const SahisMadalyonu({super.key, required this.sahis, this.boyut = 48});

  final Sahis sahis;
  final double boyut;

  @override
  Widget build(BuildContext context) {
    final ic = switch (sahis.temsil) {
      'nur' => const CustomPaint(painter: _NurCizici()),
      'yuzsuz' => const CustomPaint(painter: _SiluetCizici()),
      _ when sahis.portre.isNotEmpty => Image.asset(
          '${GorselOnbellek.kok}/${sahis.portre}',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _BasHarf(ad: sahis.ad, boyut: boyut),
        ),
      _ => _BasHarf(ad: sahis.ad, boyut: boyut),
    };
    return Semantics(
      excludeSemantics: true,
      child: Container(
        width: boyut,
        height: boyut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Palet.kagitAcik,
          border: Border.all(color: Palet.murekkep.withValues(alpha: 0.7), width: boyut > 80 ? 2 : 1.4),
        ),
        clipBehavior: Clip.antiAlias,
        child: ic,
      ),
    );
  }
}

class _BasHarf extends StatelessWidget {
  const _BasHarf({required this.ad, required this.boyut});

  final String ad;
  final double boyut;

  @override
  Widget build(BuildContext context) {
    final temiz = ad.replaceFirst(RegExp(r'^Hz\.\s*'), '').trim();
    return ColoredBox(
      color: Palet.kagitKoyu,
      child: Center(
        child: Text(
          temiz.isEmpty ? '?' : temiz.characters.first,
          style: TextStyle(
            fontFamily: baslikYazisi,
            fontSize: boyut * 0.44,
            fontWeight: FontWeight.w700,
            color: Palet.murekkepSoluk,
          ),
        ),
      ),
    );
  }
}

class _NurCizici extends CustomPainter {
  const _NurCizici();

  @override
  void paint(Canvas canvas, Size size) {
    final m = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    canvas.drawCircle(m, r, Paint()..color = const Color(0xFFE9DCC0));
    canvas.drawCircle(
      m,
      r,
      Paint()
        ..shader = RadialGradient(colors: const [
          Color(0xFFFFFBEF),
          Color(0xFFFFF0C8),
          Color(0x00F2C46B),
        ], stops: const [0, 0.45, 1]).createShader(Rect.fromCircle(center: m, radius: r)),
    );
  }

  @override
  bool shouldRepaint(_NurCizici eski) => false;
}

/// Yüzsüz siluet: yuvarlak baş ve omuzlar, tek renk; yüz çizgisi yok.
class _SiluetCizici extends CustomPainter {
  const _SiluetCizici();

  @override
  void paint(Canvas canvas, Size s) {
    canvas.drawRect(Offset.zero & s, Paint()..color = Palet.kagitKoyu);
    final boya = Paint()..color = Palet.murekkepSoluk.withValues(alpha: 0.75);
    final w = s.width, h = s.height;
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.4), width: w * 0.34, height: h * 0.38), boya);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.12, h * 1.02)
        ..quadraticBezierTo(w * 0.14, h * 0.62, w * 0.5, h * 0.6)
        ..quadraticBezierTo(w * 0.86, h * 0.62, w * 0.88, h * 1.02)
        ..close(),
      boya,
    );
  }

  @override
  bool shouldRepaint(_SiluetCizici eski) => false;
}
