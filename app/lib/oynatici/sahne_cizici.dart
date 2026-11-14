import 'package:flutter/rendering.dart';

import '../icerik/model.dart';
import 'gorsel_onbellek.dart';
import 'kamera.dart';
import 'yer_tutucu.dart';

/// Bir sahnenin bir çekimini, kamera hareketini katmanlara derinlikleriyle
/// orantılı uygulayarak çizer (parallax).
class SahneCizici extends CustomPainter {
  SahneCizici({
    required this.gorsel,
    required this.ilerleme,
    required this.zaman,
    this.gorseller,
  }) : super(repaint: gorseller);

  final Gorsel gorsel;
  final double ilerleme;
  final double zaman;

  /// Verilmezse bütün katmanlar yer tutucu olarak çizilir.
  final GorselOnbellek? gorseller;

  /// Katman görselleri kadrajdan her yöne bu oranda taşacak şekilde üretilir
  /// (docs/GORSEL_USLUP.md → Kadraj); kamera yaklaşınca kenar boş kalmaz.
  static const tasma = 0.1;

  /// Görselin çizileceği alan. `ayar.gorsel` yoksa kadraj + taşma payı;
  /// varsa görsel o merkeze ve genişliğe, kendi [oran]ıyla (en/boy) yerleşir.
  static Rect gorselAlani(Katman katman, Size size, double oran) {
    final y = katman.gorselYerlesim;
    if (y == null) {
      return Rect.fromLTRB(
        -tasma * size.width,
        -tasma * size.height,
        (1 + tasma) * size.width,
        (1 + tasma) * size.height,
      );
    }
    final gen = y.olcek * size.width;
    return Rect.fromCenter(
      center: Offset(y.x * size.width, y.y * size.height),
      width: gen,
      height: gen / oran,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final g = gorsel;
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
      final kadraj = katman.kadraj;
      if (kadraj != null) {
        // Kadraj noktasını ortaya getir ve büyüt; uzak katman az, yakın çok.
        final z = 1 + (kadraj.yakinlik - 1) * etki;
        canvas.scale(z);
        canvas.translate(
          -(0.5 + (kadraj.x - 0.5) * etki) * size.width,
          -(0.5 + (kadraj.y - 0.5) * etki) * size.height,
        );
      } else {
        canvas.translate(-size.width / 2, -size.height / 2);
      }
      final resim = gorseller?.al(katman.dosya);
      if (resim != null) {
        paintImage(
          canvas: canvas,
          rect: gorselAlani(
            katman,
            size,
            resim.width / resim.height,
          ),
          image: resim,
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
      eski.gorsel != gorsel ||
      eski.ilerleme != ilerleme ||
      eski.zaman != zaman ||
      eski.gorseller != gorseller;
}
