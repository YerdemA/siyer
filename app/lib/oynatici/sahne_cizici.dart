import 'package:flutter/rendering.dart';

import '../icerik/model.dart';
import 'gorsel_onbellek.dart';
import 'kamera.dart';
import 'yer_tutucu.dart';

/// Bir sahneyi, kamera hareketini katmanlara derinlikleriyle orantılı
/// uygulayarak çizer (parallax).
class SahneCizici extends CustomPainter {
  SahneCizici({
    required this.sahne,
    required this.ilerleme,
    required this.zaman,
    this.gorseller,
  }) : super(repaint: gorseller);

  final Sahne sahne;
  final double ilerleme;
  final double zaman;

  /// Verilmezse bütün katmanlar yer tutucu olarak çizilir.
  final GorselOnbellek? gorseller;

  /// Katman görselleri kadrajdan her yöne bu oranda taşacak şekilde üretilir
  /// (docs/GORSEL_USLUP.md → Kadraj); kamera yaklaşınca kenar boş kalmaz.
  static const tasma = 0.1;

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
      final gorsel = gorseller?.al(katman.dosya);
      if (gorsel != null) {
        paintImage(
          canvas: canvas,
          rect: Rect.fromLTRB(
            -tasma * size.width,
            -tasma * size.height,
            (1 + tasma) * size.width,
            (1 + tasma) * size.height,
          ),
          image: gorsel,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
        );
      } else {
        YerTutucu(canvas, size, katman, g.saat, zaman, ilerleme).ciz();
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SahneCizici eski) =>
      eski.sahne != sahne ||
      eski.ilerleme != ilerleme ||
      eski.zaman != zaman ||
      eski.gorseller != gorseller;
}
