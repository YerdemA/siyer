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

  /// Deneme (Erdem, 2026-11-15): katman görselleri nötr gün ışığında
  /// üretilir, sahnenin saatine göre tonu oynatıcı verir. Kapatmak için false.
  static const saatTonuAcik = true;

  /// Saatin renk süzgeci; gündüz ve gök katmanı tonlanmaz (gök görselleri
  /// zaten saatine göre üretildi). Kendi ışığıyla üretilmiş bir katman
  /// (ör. kandil ışıklı iç mekân) `ayar.ton: false` ile hariç tutulur.
  ///
  /// Gece yalnız `ayar.ton: "gece"` olan katman tonlanır (ay ışığı: koyu,
  /// soğuk, az doygun). Ortak gündüz katmanları (dağ, zemin, ev) gece
  /// sahnesinde böyle işaretlenir; meşale ya da ateş ışıklı katmanlar
  /// kendi ışığıyla üretildiği için işaretlenmez.
  static ColorFilter? saatTonu(String saat, Katman katman) {
    final ton = katman.ayar['ton'];
    if (!saatTonuAcik || katman.yerTutucu == 'gok' || ton == false) {
      return null;
    }
    // Satırlar: R, G, B, A çıkışı = katsayılar · (R, G, B, A) + sabit (0–255).
    final m = switch (saat) {
      'safak' => const <double>[1.0, 0, 0, 0, 8, 0, 0.88, 0, 0, 2, 0, 0, 0.80, 0, 6, 0, 0, 0, 1, 0],
      'aksam' => const <double>[0.92, 0, 0, 0, 6, 0, 0.78, 0, 0, 2, 0, 0, 0.72, 0, 8, 0, 0, 0, 1, 0],
      'gece' when ton == 'gece' => const <double>[
        0.26, 0.117, 0.023, 0, 4, //
        0.07, 0.373, 0.027, 0, 6, //
        0.099, 0.194, 0.368, 0, 16, //
        0, 0, 0, 1, 0,
      ],
      _ => null,
    };
    return m == null ? null : ColorFilter.matrix(m);
  }

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
    // Kamera yolu olan çekimde hazır kamera hareketi yerine yol izlenir.
    final yol = g.yol?.an(ilerleme);
    final kamera = yol != null ? const KameraDurumu() : kameraHesapla(g.kamera, ilerleme, zaman);
    canvas.clipRect(Offset.zero & size);
    for (final katman in g.katmanlar) {
      final d = katman.derinlik;
      // Uzak katmanlar da biraz hareket etsin; yalnız gökyüzü (0) sabit kalmasın.
      final etki = 0.3 + 0.7 * d;
      canvas.save();
      if (yol != null) {
        // Yol noktası ekranın ortasına gelir; bütün katmanlara aynı (parallax yok).
        canvas.translate(size.width / 2, size.height / 2);
        canvas.scale(yol.yakinlik);
        canvas.translate(-yol.x * size.width, -yol.y * size.height);
      }
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
      // `ayar.daire` {x, y, r}: katman bu dairenin içine kırpılır (kadraj
      // birimi; r genişliğe oranla). Ör. göz bebeğindeki yansımaya çizilen nur.
      final daire = katman.ayar['daire'];
      if (daire is Map<String, dynamic>) {
        double s(String ad) => (daire[ad] as num?)?.toDouble() ?? 0;
        canvas.clipPath(Path()
          ..addOval(Rect.fromCircle(
            center: Offset(s('x') * size.width, s('y') * size.height),
            radius: s('r') * size.width,
          )));
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
          colorFilter: saatTonu(g.saat, katman),
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
