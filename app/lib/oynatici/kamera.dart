import 'dart:math' as math;
import 'dart:ui';

/// Bir andaki kamera durumu. [kaydirma] ekran boyutuna oranla (−1…1);
/// katmanlara derinlikleriyle orantılı uygulanır (parallax).
class KameraDurumu {
  const KameraDurumu({this.yakinlik = 1, this.kaydirma = Offset.zero, this.donus = 0});

  /// 1 = normal kadraj; 1.2 = %20 yakın.
  final double yakinlik;
  final Offset kaydirma;

  /// Radyan.
  final double donus;
}

double _yumusak(double p) => p * p * (3 - 2 * p);

/// İçerikteki `kamera` adlarının tanımı (docs/ICERIK_SEMASI.md).
/// [p] sahnenin görsel ilerlemesi (0–1), [t] saniye cinsinden genel zaman.
KameraDurumu kameraHesapla(String ad, double p, double t) {
  final e = _yumusak(p);
  double ara(double a, double b) => a + (b - a) * e;
  switch (ad) {
    case 'yavas-yaklasma':
      return KameraDurumu(yakinlik: ara(1.0, 1.15));
    case 'yavas-uzaklasma':
      return KameraDurumu(yakinlik: ara(1.18, 1.0));
    case 'yatay-kayma':
      return KameraDurumu(yakinlik: 1.12, kaydirma: Offset(ara(0.06, -0.06), 0));
    case 'donus-kapiya':
      return KameraDurumu(yakinlik: ara(1.08, 1.2), kaydirma: Offset(ara(0.08, -0.04), 0));
    case 'yukaridan-yavas-donus':
      return KameraDurumu(yakinlik: 1.15, donus: ara(-0.025, 0.025));
    case 'yukaridan-yukselis':
      return KameraDurumu(yakinlik: ara(1.0, 1.22));
    case 'bakis-acisi-yuruyus':
      // Yürüyen birinin gözü: ileri doğru yaklaşma ve hafif adım salınımı.
      return KameraDurumu(
        yakinlik: ara(1.02, 1.2),
        kaydirma: Offset(math.sin(t * 1.7) * 0.004, math.sin(t * 3.4).abs() * -0.008),
      );
    case 'bakis-acisi-giris':
      return KameraDurumu(yakinlik: ara(1.0, 1.28));
    case 'sabit':
    case 'sabit-gecis':
    default:
      // Tam durağan görüntü ölü görünür; çok hafif bir nefes.
      return KameraDurumu(yakinlik: 1.04 + math.sin(t * 0.5) * 0.006);
  }
}
