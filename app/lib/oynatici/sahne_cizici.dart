import 'package:flutter/rendering.dart';

import '../icerik/model.dart';
import 'kamera.dart';
import 'yer_tutucu.dart';

/// Bir sahneyi, kamera hareketini katmanlara derinlikleriyle orantılı
/// uygulayarak çizer (parallax).
class SahneCizici extends CustomPainter {
  SahneCizici({required this.sahne, required this.ilerleme, required this.zaman});

  final Sahne sahne;
  final double ilerleme;
  final double zaman;

  @override
  void paint(Canvas canvas, Size size) {
    final g = sahne.gorsel;
    final kamera = kameraHesapla(g.kamera, ilerleme, zaman);
    canvas.clipRect(Offset.zero & size);
    for (final katman in g.katmanlar) {
      final d = katman.derinlik;
      // Uzak katmanlar da biraz hareket etsin; yalnız gökyüzü (0) sabit kalmasın.
      final etki = 0.3 + 0.7 * d;
      canvas.save();
      canvas.translate(
        size.width / 2 + kamera.kaydirma.dx * size.width * d,
        size.height / 2 + kamera.kaydirma.dy * size.height * d,
      );
      canvas.rotate(kamera.donus * etki);
      canvas.scale(1 + (kamera.yakinlik - 1) * etki);
      canvas.translate(-size.width / 2, -size.height / 2);
      // TODO(gorsel): katman.dosya doluysa WebP görselini çiz.
      YerTutucu(canvas, size, katman, g.saat, zaman, ilerleme).ciz();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SahneCizici eski) =>
      eski.sahne != sahne || eski.ilerleme != ilerleme || eski.zaman != zaman;
}
