import 'dart:math' as math;
import 'dart:ui';

import '../icerik/model.dart';

/// Gerçek görseller gelene kadar katmanların yerine çizilen geçici şekiller.
///
/// Amaç sanat değil; kamera, derinlik, ışık, geçiş ve temponun nasıl
/// hissettirdiğini görmek. Temsil kuralları (docs/GORSEL_USLUP.md) burada da
/// geçerli: Hz. Peygamber için hiçbir figür çizilmez, yalnız `nur`; kişilerin
/// yüzü yoktur; kan gösterilmez.
class YerTutucu {
  YerTutucu(this.c, this.s, this.k, this.saat, this.t, this.p);

  final Canvas c;
  final Size s;
  final Katman k;
  final String saat;

  /// Genel zaman (sn) — titreşim, toz, dalga gibi sürekli hareketler için.
  final double t;

  /// Sahne ilerlemesi (0–1).
  final double p;

  double get w => s.width;
  double get h => s.height;

  static const _gece = Color(0xFF141B30);
  static const _kum = Color(0xFFD9C4A0);
  static const _toprak = Color(0xFF8B6B4A);
  static const _kerpic = Color(0xFFB59873);
  static const _tas = Color(0xFF5E544A);
  static const _siluet = Color(0xFF2B241F);
  static const _nurAcik = Color(0xFFFFF4D8);
  static const _nurAltin = Color(0xFFF2C46B);

  static const _karanlik = {'safak': 0.28, 'gunduz': 0.0, 'aksam': 0.32, 'gece': 0.68};

  /// Rengi günün saatine göre karartır.
  Color r(Color renk, [double ek = 0]) => Color.lerp(
        renk,
        _gece,
        ((_karanlik[saat] ?? 0) + ek).clamp(0.0, 0.9),
      )!;

  math.Random get _rnd => math.Random(k.id.hashCode ^ k.yerTutucu.hashCode);

  Paint _boya(Color renk) => Paint()
    ..color = renk
    ..isAntiAlias = true;

  // Kamera kaydığında kenarlar boş görünmesin diye geniş çizilen alan.
  Rect get _tasma => Rect.fromLTRB(-0.4 * w, -0.4 * h, 1.4 * w, 1.4 * h);

  void ciz() {
    switch (k.yerTutucu) {
      case 'gok':
        _gok();
      case 'daglar':
        _daglar();
      case 'zemin':
        _zemin(0.66);
      case 'evler':
        _evler();
      case 'kabe-alcak':
        _kabe(0.07, yarim: false, kapi: false);
      case 'kabe-yarim':
        _kabe(0.1, yarim: true, kapi: false);
      case 'kabe-yuksek':
        _kabe(0.15, yarim: false, kapi: true);
      case 'kabe-yakin':
        _kabeYakin();
      case 'kalabalik':
        _kalabalik();
      case 'siluet-tek':
        _siluetTek();
      case 'tasiyan-arkadan':
        _tasiyanArkadan();
      case 'yokus':
        _yokus();
      case 'deniz':
        _deniz();
      case 'gemi-enkaz':
        _gemiEnkaz();
      case 'temel-taslari':
        _temelTaslari();
      case 'kumas-tas':
        _kumasTas();
      case 'kap':
        _kap();
      case 'mesale':
        _mesale();
      case 'kapi-araligi':
        _kapiAraligi();
      case 'kapi-cercevesi':
        _kapiCercevesi();
      case 'nur':
        _nur();
      case 'toz':
        _toz();
      default:
        _bilinmeyen();
    }
  }

  // ------------------------------------------------------------- manzara

  void _gok() {
    final renkler = switch (saat) {
      'safak' => const [Color(0xFF2A3350), Color(0xFF8E6F78), Color(0xFFE3A57A)],
      'aksam' => const [Color(0xFF332F4A), Color(0xFFA0655A), Color(0xFFDB9A6B)],
      'gece' => const [Color(0xFF070B18), Color(0xFF111A33), Color(0xFF1D2945)],
      _ => const [Color(0xFF8FA6BA), Color(0xFFC9CDC6), Color(0xFFE8DCC4)],
    };
    c.drawRect(
      _tasma,
      Paint()
        ..shader = Gradient.linear(
          Offset(0, -0.2 * h),
          Offset(0, 0.7 * h),
          renkler,
          const [0, 0.55, 1],
        ),
    );
    if (saat == 'safak' || saat == 'aksam') {
      final merkez = Offset(saat == 'safak' ? 0.74 * w : 0.24 * w, 0.58 * h);
      c.drawCircle(
        merkez,
        0.35 * w,
        Paint()
          ..shader = Gradient.radial(merkez, 0.35 * w, [
            const Color(0xFFF6C08A).withValues(alpha: 0.55),
            const Color(0x00F6C08A),
          ]),
      );
    }
    if (saat == 'gece') {
      final rnd = _rnd;
      final yildiz = _boya(const Color(0xFFE9E4D4));
      for (var i = 0; i < 80; i++) {
        final x = (rnd.nextDouble() * 1.6 - 0.3) * w;
        final y = (rnd.nextDouble() * 0.6 - 0.2) * h;
        final parilti = 0.5 + 0.5 * math.sin(t * (0.6 + rnd.nextDouble()) + i);
        yildiz.color = const Color(0xFFE9E4D4).withValues(alpha: 0.25 + 0.5 * parilti);
        c.drawCircle(Offset(x, y), 0.6 + rnd.nextDouble() * 0.9, yildiz);
      }
      c.drawCircle(Offset(0.8 * w, 0.16 * h), 0.022 * w, _boya(const Color(0xFFE8E1CC)));
    }
  }

  Path _sirt(double taban, double genlik, double adim, math.Random rnd) {
    final yol = Path()..moveTo(-0.4 * w, 1.4 * h);
    for (var x = -0.4; x <= 1.41; x += adim) {
      yol.lineTo(x * w, (taban - rnd.nextDouble() * genlik) * h);
    }
    return yol
      ..lineTo(1.4 * w, 1.4 * h)
      ..close();
  }

  void _daglar() {
    final rnd = _rnd;
    c.drawPath(_sirt(0.5, 0.14, 0.07, rnd), _boya(r(const Color(0xFF8A7466), 0.08)));
    c.drawPath(_sirt(0.6, 0.1, 0.05, rnd), _boya(r(const Color(0xFF6E5A4B), 0.12)));
  }

  void _zemin(double ufuk) {
    c.drawRect(
      Rect.fromLTRB(-0.4 * w, ufuk * h, 1.4 * w, 1.4 * h),
      Paint()
        ..shader = Gradient.linear(
          Offset(0, ufuk * h),
          Offset(0, h),
          [r(_toprak), r(_kum)],
        ),
    );
  }

  void _evler() {
    final rnd = _rnd;
    final govde = _boya(r(_kerpic, 0.05));
    final golge = _boya(r(const Color(0xFF7D6650), 0.1));
    final kapi = _boya(r(const Color(0xFF3B2F26), 0.1));
    for (var i = 0; i < 26; i++) {
      final x = -0.35 + rnd.nextDouble() * 1.7;
      if (x > 0.4 && x < 0.6) continue; // Kâbe'nin çevresi açık avlu.
      final gen = 0.04 + rnd.nextDouble() * 0.05;
      final yuk = 0.03 + rnd.nextDouble() * 0.04;
      final taban = 0.69 + rnd.nextDouble() * 0.04;
      final on = Rect.fromLTWH(x * w, (taban - yuk) * h, gen * w, yuk * h);
      c.drawRect(on, govde);
      c.drawRect(Rect.fromLTWH(on.right, on.top + 0.004 * h, 0.012 * w, on.height - 0.004 * h), golge);
      c.drawRect(
        Rect.fromLTWH(on.left + on.width * 0.35, on.bottom - on.height * 0.5, on.width * 0.18, on.height * 0.5),
        kapi,
      );
    }
  }

  /// Kâbe: [yukseklik] ekran yüksekliğine oranla. Ölçüler kaynakla
  /// netleşmeden yalnız göreli (alçak / yarım / 18 arşın) tutulur.
  void _kabe(double yukseklik, {required bool yarim, required bool kapi}) {
    final o = k.sayi('olcek', 1);
    final gen = 0.12 * o;
    final yuk = yukseklik * o;
    final taban = 0.74 + (o - 1) * 0.08;
    final sol = (0.5 - gen / 2) * w;
    final ust = (taban - yuk) * h;
    final rnd = _rnd;

    final on = Path()..moveTo(sol, taban * h);
    if (yarim) {
      // Düzensiz, yarım kalmış üst kenar.
      for (var i = 0; i <= 8; i++) {
        on.lineTo(sol + gen * w * i / 8, ust + rnd.nextDouble() * 0.035 * h * o);
      }
    } else {
      on
        ..lineTo(sol, ust)
        ..lineTo(sol + gen * w, ust);
    }
    on
      ..lineTo(sol + gen * w, taban * h)
      ..close();
    final yan = Path()
      ..moveTo(sol + gen * w, ust + (yarim ? 0.02 * h * o : 0))
      ..lineTo(sol + gen * w * 1.32, ust - 0.012 * h * o + (yarim ? 0.02 * h * o : 0))
      ..lineTo(sol + gen * w * 1.32, (taban - 0.012) * h)
      ..lineTo(sol + gen * w, taban * h)
      ..close();

    c.drawPath(yan, _boya(r(const Color(0xFF3E3630), 0.1)));
    c.drawPath(on, _boya(r(_tas)));
    // Harçsız taş sıraları.
    c.save();
    c.clipPath(on);
    final cizgi = Paint()
      ..color = r(const Color(0xFF2E2823)).withValues(alpha: 0.6)
      ..strokeWidth = math.max(0.6, 0.0015 * h);
    final sira = 0.012 * h * o;
    for (var y = taban * h; y > ust - sira; y -= sira) {
      c.drawLine(Offset(sol, y), Offset(sol + gen * w, y), cizgi);
      final kayma = rnd.nextDouble() * 0.02 * w * o;
      for (var x = sol + kayma; x < sol + gen * w; x += 0.022 * w * o) {
        c.drawLine(Offset(x, y), Offset(x, y - sira), cizgi);
      }
    }
    c.restore();
    if (kapi) {
      // Yerden yüksek, tek kanatlı kapı (TDV KÂBE s. 16-17).
      c.drawRect(
        Rect.fromLTWH(sol + gen * w * 0.62, (taban - yuk * 0.62) * h, gen * w * 0.16, yuk * 0.32 * h),
        _boya(r(const Color(0xFF4A3424), 0.05)),
      );
    }
  }

  void _kabeYakin() {
    final rnd = _rnd;
    c.drawRect(_tasma, _boya(r(const Color(0xFF4A423A))));
    final cizgi = Paint()
      ..color = r(const Color(0xFF221D19)).withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, 0.004 * h);
    for (var y = -0.4; y < 1.4; y += 0.11) {
      var x = -0.4 - rnd.nextDouble() * 0.1;
      while (x < 1.4) {
        final gen = 0.1 + rnd.nextDouble() * 0.1;
        final blok = Rect.fromLTWH(x * w, y * h, gen * w, 0.11 * h);
        final ton = (rnd.nextDouble() - 0.5) * 0.18;
        c.drawRect(blok, _boya(r(Color.lerp(_tas, const Color(0xFF7A6D5F), 0.5 + ton)!)));
        c.drawRect(blok, cizgi);
        x += gen;
      }
    }
    if (k.bayrak('isli')) {
      // Yangın isi ve duvar dibinde kurumuş sel izi.
      for (var i = 0; i < 5; i++) {
        final m = Offset((0.1 + rnd.nextDouble() * 0.8) * w, (0.1 + rnd.nextDouble() * 0.5) * h);
        c.drawCircle(
          m,
          0.18 * w,
          Paint()
            ..shader = Gradient.radial(m, 0.18 * w, [
              const Color(0xFF15110E).withValues(alpha: 0.55),
              const Color(0x0015110E),
            ]),
        );
      }
      c.drawRect(
        Rect.fromLTRB(-0.4 * w, 0.82 * h, 1.4 * w, 1.4 * h),
        Paint()
          ..shader = Gradient.linear(Offset(0, 0.8 * h), Offset(0, h), [
            const Color(0x00796246),
            r(const Color(0xFF796246)).withValues(alpha: 0.85),
          ]),
      );
    }
    if (k.bayrak('hacer')) {
      final m = Offset(0.5 * w, 0.5 * h);
      c.drawOval(Rect.fromCenter(center: m, width: 0.2 * w, height: 0.24 * h),
          _boya(r(const Color(0xFF2A241F))));
      c.drawOval(
        Rect.fromCenter(center: m, width: 0.15 * w, height: 0.18 * h),
        Paint()
          ..shader = Gradient.radial(m.translate(-0.02 * w, -0.03 * h), 0.1 * w, [
            const Color(0xFF3A3533),
            const Color(0xFF0E0C0B),
          ]),
      );
    }
  }

  // ------------------------------------------------------------- insanlar

  /// Yüzsüz siluet: baş + omuzdan genişleyen cüppe. [yukseklik] piksel.
  void _figur(Offset ayak, double yukseklik, Color renk, {double egim = 0}) {
    final hh = yukseklik;
    final bas = Offset(ayak.dx + egim * hh * 0.15, ayak.dy - hh * 0.9);
    final govde = Path()
      ..moveTo(ayak.dx - hh * 0.2, ayak.dy)
      ..quadraticBezierTo(ayak.dx - hh * 0.2, ayak.dy - hh * 0.5,
          bas.dx - hh * 0.17, ayak.dy - hh * 0.74)
      ..quadraticBezierTo(bas.dx, ayak.dy - hh * 0.8, bas.dx + hh * 0.17, ayak.dy - hh * 0.74)
      ..quadraticBezierTo(ayak.dx + hh * 0.2, ayak.dy - hh * 0.5, ayak.dx + hh * 0.2, ayak.dy)
      ..close();
    final boya = _boya(renk);
    c.drawPath(govde, boya);
    c.drawCircle(bas, hh * 0.075, boya);
  }

  void _kalabalik() {
    final rnd = _rnd;
    final sayi = k.sayi('sayi', 16).toInt();
    final y = k.sayi('y', 0.82);
    final olcek = k.sayi('olcek', 0.06);
    final x1 = k.sayi('x1', 0.08), x2 = k.sayi('x2', 0.92);
    final iki = k.yazi('grup', '') == 'iki';
    for (var i = 0; i < sayi; i++) {
      final double x;
      if (iki) {
        final merkez = i.isEven ? 0.28 : 0.72;
        x = merkez + (rnd.nextDouble() - 0.5) * 0.3;
      } else {
        x = x1 + rnd.nextDouble() * (x2 - x1);
      }
      final derin = rnd.nextDouble();
      final boy = olcek * h * (0.8 + derin * 0.35);
      final salinim = math.sin(t * 0.7 + i * 1.3) * 0.002 * w;
      _figur(
        Offset(x * w + salinim, (y + (derin - 0.5) * 0.04) * h),
        boy,
        r(Color.lerp(_siluet, const Color(0xFF4A3F36), 1 - derin)!, 0.05),
        egim: iki ? (i.isEven ? 1 : -1) : 0,
      );
    }
  }

  void _siluetTek() {
    final ayak = Offset(k.sayi('x', 0.7) * w, k.sayi('y', 0.9) * h);
    final boy = k.sayi('olcek', 0.3) * h;
    if (k.bayrak('kazma')) {
      // Kazma: yavaşça kalkar, inmeden kesilir (darbe gösterilmez).
      final aci = -1.2 - 0.9 * math.min(1, p * 1.4);
      final omuz = ayak.translate(boy * 0.05, -boy * 0.72);
      final uc = omuz + Offset(math.cos(aci), math.sin(aci)) * boy * 0.65;
      c.drawLine(omuz, uc, _boya(r(const Color(0xFF3A2E24)))..strokeWidth = boy * 0.035);
      c.drawLine(uc.translate(-boy * 0.1, boy * 0.03), uc.translate(boy * 0.1, -boy * 0.03),
          _boya(r(const Color(0xFF55504A)))..strokeWidth = boy * 0.05);
    }
    _figur(ayak, boy, r(_siluet));
  }

  void _tasiyanArkadan() {
    // Abbas, arkadan: omzunda taş, adım salınımıyla yürür. Yüz yok.
    final adim = math.sin(t * 3.4).abs();
    final ayak = Offset(0.62 * w, (1.08 - adim * 0.012) * h);
    final boy = 0.5 * h;
    _figur(ayak, boy, r(const Color(0xFF3A3029)));
    // Taş sağ omuzda, başın yanında; başı örtmez.
    final omuz = ayak.translate(boy * 0.2, -boy * 0.8);
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: omuz, width: boy * 0.17, height: boy * 0.11),
        Radius.circular(boy * 0.03),
      ),
      _boya(r(const Color(0xFF6B6157))),
    );
  }

  // ------------------------------------------------------------- mekânlar

  void _yokus() {
    final rnd = _rnd;
    final yol = Path()
      ..moveTo(-0.4 * w, 1.4 * h)
      ..lineTo(-0.4 * w, 0.82 * h)
      ..quadraticBezierTo(0.5 * w, 0.74 * h, 1.4 * w, 0.66 * h)
      ..lineTo(1.4 * w, 1.4 * h)
      ..close();
    c.drawPath(yol, _boya(r(Color.lerp(_kum, _toprak, 0.4)!)));
    final tas = _boya(r(const Color(0xFF7B6C5C)));
    for (var i = 0; i < 40; i++) {
      final x = rnd.nextDouble() * 1.4 - 0.2;
      final y = 0.8 + rnd.nextDouble() * 0.3 - x * 0.08;
      c.drawOval(
        Rect.fromCenter(center: Offset(x * w, y * h), width: (0.01 + rnd.nextDouble() * 0.02) * w,
            height: (0.006 + rnd.nextDouble() * 0.01) * h),
        tas,
      );
    }
  }

  void _deniz() {
    c.drawRect(Rect.fromLTRB(-0.4 * w, 0.52 * h, 1.4 * w, 0.76 * h), _boya(r(const Color(0xFF5B7480))));
    final dalga = Paint()
      ..color = r(const Color(0xFFB9C6C4)).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, 0.003 * h);
    for (var j = 0; j < 7; j++) {
      final y = (0.55 + j * 0.03) * h;
      final yol = Path()..moveTo(-0.4 * w, y);
      for (var x = -0.4; x <= 1.4; x += 0.02) {
        yol.lineTo(x * w, y + math.sin(x * 18 + t * (0.8 + j * 0.1) + j) * 0.004 * h);
      }
      c.drawPath(yol, dalga);
    }
    _zemin(0.74);
  }

  void _gemiEnkaz() {
    final rnd = _rnd;
    final ahsap = _boya(r(const Color(0xFF5B4330)));
    final koyu = _boya(r(const Color(0xFF3B2B1F)));
    c.save();
    c.translate(0.5 * w, 0.76 * h);
    c.rotate(-0.18);
    final govde = Path()
      ..moveTo(-0.2 * w, -0.03 * h)
      ..quadraticBezierTo(-0.05 * w, 0.06 * h, 0.17 * w, 0.0)
      ..lineTo(0.15 * w, -0.08 * h)
      ..lineTo(-0.16 * w, -0.09 * h)
      ..close();
    c.drawPath(govde, ahsap);
    for (var i = 0; i < 5; i++) {
      c.drawLine(Offset(-0.18 * w, (-0.08 + i * 0.018) * h), Offset(0.16 * w, (-0.07 + i * 0.016) * h),
          koyu..strokeWidth = math.max(1, 0.003 * h));
    }
    c.drawLine(Offset(-0.02 * w, -0.085 * h), Offset(0.02 * w, -0.25 * h), koyu..strokeWidth = 0.008 * h);
    c.restore();
    for (var i = 0; i < 12; i++) {
      c.save();
      c.translate((0.15 + rnd.nextDouble() * 0.7) * w, (0.8 + rnd.nextDouble() * 0.15) * h);
      c.rotate(rnd.nextDouble() * math.pi);
      c.drawRect(Rect.fromCenter(center: Offset.zero, width: 0.07 * w, height: 0.01 * h), ahsap);
      c.restore();
    }
  }

  void _temelTaslari() {
    c.drawRect(_tasma, _boya(r(const Color(0xFF7A6248))));
    // Deve hörgücüne benzeyen yeşilimsi taşlar (İbn Hişâm s. 124).
    final rnd = _rnd;
    for (var i = 0; i < 9; i++) {
      final m = Offset((0.12 + i * 0.1 + (rnd.nextDouble() - 0.5) * 0.03) * w,
          (0.5 + math.sin(i * 0.9) * 0.08) * h);
      final r0 = (0.07 + rnd.nextDouble() * 0.025) * w;
      c.drawOval(Rect.fromCenter(center: m.translate(0.01 * w, 0.02 * h), width: r0 * 2.1, height: r0 * 1.5),
          _boya(const Color(0x55000000)));
      c.drawOval(
        Rect.fromCenter(center: m, width: r0 * 2, height: r0 * 1.45),
        Paint()
          ..shader = Gradient.radial(m.translate(-r0 * 0.3, -r0 * 0.35), r0 * 1.4, [
            r(const Color(0xFF8C9A7E)),
            r(const Color(0xFF4C5A45)),
          ]),
      );
    }
    final sap = _boya(r(const Color(0xFF3A2E24)))..strokeWidth = 0.012 * h;
    c.drawLine(Offset(0.86 * w, 0.92 * h), Offset(1.02 * w, 0.72 * h), sap);
  }

  void _kumasTas() {
    c.drawRect(_tasma, _boya(r(const Color(0xFFB8A587))));
    final kalk = p; // Kumaş sahne boyunca yükselir.
    final m = Offset(0.5 * w, (0.56 - 0.05 * kalk) * h);
    final gen = 0.52 * w * (1 + 0.08 * kalk), yuk = 0.42 * h * (1 + 0.08 * kalk);
    // Gölge, kumaş kalktıkça uzaklaşır ve yumuşar.
    c.drawRect(
      Rect.fromCenter(center: m.translate(0.02 * w, (0.03 + 0.06 * kalk) * h), width: gen, height: yuk),
      Paint()
        ..color = const Color(0x44000000)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6 + 18 * kalk),
    );
    final kumas = Rect.fromCenter(center: m, width: gen, height: yuk);
    c.drawRect(kumas, _boya(r(const Color(0xFFD6CAB2))));
    final kivrim = Paint()
      ..color = r(const Color(0xFF9E917A)).withValues(alpha: 0.6)
      ..strokeWidth = math.max(1, 0.003 * h);
    for (var i = 1; i < 6; i++) {
      c.drawLine(Offset(kumas.left + gen * i / 6, kumas.top), Offset(kumas.left + gen * i / 6 + 0.01 * w, kumas.bottom), kivrim);
    }
    // Köşeleri tutan, kadraj dışından gelen kollar (Kureyş ileri gelenleri).
    // Resûlullah'a ait el ya da kol çizilmez.
    final kol = _boya(r(const Color(0xFF6E5442)))
      ..strokeWidth = 0.035 * w
      ..strokeCap = StrokeCap.round;
    final koseler = [kumas.topLeft, kumas.topRight, kumas.bottomLeft, kumas.bottomRight];
    final disari = [const Offset(-1, -0.6), const Offset(1, -0.6), const Offset(-1, 0.6), const Offset(1, 0.6)];
    for (var i = 0; i < 4; i++) {
      c.drawLine(koseler[i], koseler[i] + disari[i] * 0.3 * w, kol);
    }
    c.drawOval(
      Rect.fromCenter(center: m, width: 0.12 * w, height: 0.14 * h),
      Paint()
        ..shader = Gradient.radial(m.translate(-0.015 * w, -0.02 * h), 0.08 * w, [
          const Color(0xFF3B3633),
          const Color(0xFF0D0B0A),
        ]),
    );
  }

  void _kap() {
    // Koyu, içi görünmeyen bir kap; kan gösterilmez.
    // Alt %25 altyazıya ayrıldığı için kap ekranın ortasına yakın durur.
    final m = Offset(0.5 * w, 0.68 * h);
    final govde = Path()
      ..moveTo(m.dx - 0.09 * w, m.dy)
      ..quadraticBezierTo(m.dx, m.dy + 0.12 * h, m.dx + 0.09 * w, m.dy)
      ..close();
    c.drawPath(govde, _boya(const Color(0xFF1E1813)));
    c.drawOval(Rect.fromCenter(center: m, width: 0.18 * w, height: 0.035 * h), _boya(const Color(0xFF0B0907)));
    c.drawOval(
      Rect.fromCenter(center: m, width: 0.18 * w, height: 0.035 * h),
      Paint()
        ..color = const Color(0xFFB0703E).withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, 0.003 * h),
    );
  }

  void _mesale() {
    const yerler = [Offset(0.18, 0.62), Offset(0.84, 0.6), Offset(0.62, 0.7)];
    for (final (i, y) in yerler.indexed) {
      final titreme = 0.85 + 0.15 * math.sin(t * 9 + i * 2) * math.sin(t * 5.3 + i);
      final m = Offset(y.dx * w, y.dy * h);
      c.drawCircle(
        m,
        0.22 * w * titreme,
        Paint()
          ..blendMode = BlendMode.plus
          ..shader = Gradient.radial(m, 0.22 * w * titreme, [
            const Color(0xFFE08A3C).withValues(alpha: 0.35),
            const Color(0x00E08A3C),
          ]),
      );
      c.drawLine(m, m.translate(0, 0.1 * h), _boya(const Color(0xFF2A1F17))..strokeWidth = 0.006 * w);
      final alev = Path()
        ..moveTo(m.dx - 0.008 * w, m.dy)
        ..quadraticBezierTo(m.dx, m.dy - 0.05 * h * titreme, m.dx + 0.008 * w, m.dy)
        ..close();
      c.drawPath(alev, _boya(const Color(0xFFF2B35C)));
    }
  }

  void _kapiAraligi() {
    _zemin(0.7);
    // İki ev duvarı arasında sade bir giriş aralığı; anıtsal kapı yok.
    final duvar = _boya(r(_kerpic, 0.15));
    final golge = _boya(r(const Color(0xFF6D5843), 0.2));
    c.drawRect(Rect.fromLTRB(-0.4 * w, 0.05 * h, 0.41 * w, 0.78 * h), duvar);
    c.drawRect(Rect.fromLTRB(0.59 * w, 0.05 * h, 1.4 * w, 0.78 * h), duvar);
    c.drawRect(Rect.fromLTRB(0.38 * w, 0.05 * h, 0.41 * w, 0.78 * h), golge);
    final aralik = Rect.fromLTRB(0.41 * w, 0.05 * h, 0.59 * w, 0.78 * h);
    c.drawRect(
      aralik,
      Paint()
        ..shader = Gradient.linear(aralik.topCenter, aralik.bottomCenter, [
          const Color(0xFFF3E3C2),
          const Color(0xFFE2C79A),
        ]),
    );
  }

  void _kapiCercevesi() {
    // "Onun gözünden" girişte, eşikten avluya bakış: kenarlarda kapı aralığının
    // gölgeli duvarları, kamera ileri gittikçe kadrajdan çıkar. Beden yok.
    final aciklik = 0.18 + 0.5 * p;
    final duvar = _boya(r(const Color(0xFF5E4C3B), 0.25));
    c.drawRect(Rect.fromLTRB(-0.4 * w, -0.4 * h, (0.5 - aciklik) * w, 1.4 * h), duvar);
    c.drawRect(Rect.fromLTRB((0.5 + aciklik) * w, -0.4 * h, 1.4 * w, 1.4 * h), duvar);
  }

  // ------------------------------------------------------------- ışık

  void _nur() {
    // Sıcak beyaz-altın parıltı; başka hiçbir ışık bu tonu kullanmaz.
    final boy = k.sayi('boy', 0);
    if (boy > 0) {
      _nurBoylu(boy);
      return;
    }
    final m = Offset(k.sayi('x', 0.5) * w, k.sayi('y', 0.5) * h);
    final yaricap = k.sayi('r', 0.12) * w * (1 + 0.06 * math.sin(t * 1.4));
    // Sahne başında yavaşça belirir. `guc`: açık zeminde (gündüz kumu) `screen`
    // karışımı zayıf kalır; 1'den büyük değer parıltıyı ve çekirdeği güçlendirir.
    final guc = k.sayi('guc', 1).clamp(0.0, 4.0);
    final gorunurluk = math.min(1.0, p * 4) * guc;
    if (guc > 1) {
      // Açık zeminde de seçilsin diye sıcak, yumuşak bir çekirdek (normal karışım).
      c.drawCircle(
        m,
        yaricap * 1.3,
        Paint()
          ..shader = Gradient.radial(m, yaricap * 1.3, [
            _nurAcik.withValues(alpha: math.min(0.85, 0.22 * gorunurluk)),
            _nurAltin.withValues(alpha: math.min(0.5, 0.1 * gorunurluk)),
            _nurAltin.withValues(alpha: 0),
          ], const [0, 0.45, 1]),
      );
    }
    // `screen` karışımı aydınlatır ama altındaki nesnenin rengini silmez
    // (ör. Hacerülesved siyah kalır).
    c.drawCircle(
      m,
      yaricap * 2.4,
      Paint()
        ..blendMode = BlendMode.screen
        ..shader = Gradient.radial(m, yaricap * 2.4, [
          _nurAcik.withValues(alpha: math.min(1.0, 0.32 * gorunurluk)),
          _nurAltin.withValues(alpha: math.min(1.0, 0.14 * gorunurluk)),
          _nurAltin.withValues(alpha: 0),
        ], const [0, 0.4, 1]),
    );
  }

  /// Beden boyunda nur (diğer peygamberler, docs/GORSEL_USLUP.md §2): ayakta
  /// bir insan boyunda, yumuşak bir ışık. Kaba bir insan biçimi sezilir
  /// (yuvarlak baş, omuzlar, aşağı doğru hafifçe açılan giysi), ama kenarlar
  /// bulanıktır: yüz, kol, el, ayak ya da belirgin siluet yok.
  /// `x`, `y`: zemine bastığı alt uç; `boy`: yüksekliği (ekran yüksekliğine
  /// oranla); `r`: omuz yarı genişliği (ekran genişliğine oranla, verilmezse
  /// boyun %17'si).
  ///
  /// `kim: "efendimiz"`: Hz. Muhammed'in nurlu figürü (GORSEL_USLUP.md §1).
  /// Aynı biçim, ama baştan ayağa dolu, opak bir nur ve başında yeşil sarık;
  /// içinde yalnız boy ve sarık seçilir.
  void _nurBoylu(double boy) {
    final yk = boy * h * (1 + 0.02 * math.sin(t * 1.4));
    final omuz = k.sayi('r', 0) > 0 ? k.sayi('r', 0) * w : boy * h * 0.17;
    final x = k.sayi('x', 0.5) * w;
    final zemin = k.sayi('y', 0.7) * h;
    final ust = zemin - yk;
    final guc = k.sayi('guc', 1).clamp(0.0, 4.0);
    final gorunurluk = math.min(1.0, p * 4) * guc;

    // Gövde: omuzlardan (boyun %20'si) zemine; etek omuzdan biraz geniş.
    final omuzY = ust + yk * 0.2;
    final etek = omuz * 1.12;
    final govde = Path()
      ..moveTo(x - omuz * 0.55, omuzY - yk * 0.03)
      ..quadraticBezierTo(x - omuz, omuzY - yk * 0.01, x - omuz, omuzY + yk * 0.08)
      ..quadraticBezierTo(x - omuz * 0.95, zemin - yk * 0.35, x - etek, zemin)
      ..lineTo(x + etek, zemin)
      ..quadraticBezierTo(x + omuz * 0.95, zemin - yk * 0.35, x + omuz, omuzY + yk * 0.08)
      ..quadraticBezierTo(x + omuz, omuzY - yk * 0.01, x + omuz * 0.55, omuzY - yk * 0.03)
      ..close();
    // Baş: gövdeyle kaynaşan yumuşak bir yuvarlak; boyun ve yüz hattı yok.
    final bas = Rect.fromCenter(
      center: Offset(x, ust + yk * 0.1),
      width: omuz * 0.95,
      height: yk * 0.2,
    );
    final bicim = Path()
      ..addPath(govde, Offset.zero)
      ..addOval(bas);

    if (k.yazi('kim', '') == 'efendimiz') {
      _nurFigur(bicim, x, ust, yk, omuz, gorunurluk);
      return;
    }

    if (guc > 1) {
      // Açık zeminde de seçilsin diye sıcak, yumuşak çekirdek (normal karışım).
      c.drawPath(
        bicim,
        Paint()
          ..color = _nurAcik.withValues(alpha: math.min(0.5, 0.14 * gorunurluk))
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.045),
      );
    }
    // Dış hale (`screen`): biçimin çevresine geniş, sıcak bir ışık.
    c.drawPath(
      bicim,
      Paint()
        ..blendMode = BlendMode.screen
        ..color = _nurAltin.withValues(alpha: math.min(0.75, 0.22 * gorunurluk))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.12),
    );
    // İç parlaklık: biçimin kendisi, kenarları yumuşak.
    c.drawPath(
      bicim,
      Paint()
        ..blendMode = BlendMode.screen
        ..color = _nurAcik.withValues(alpha: math.min(0.72, 0.24 * gorunurluk))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.032),
    );
  }

  static const _sarik = Color(0xFF3F7D4E);

  void _nurFigur(Path bicim, double x, double ust, double yk, double omuz, double gorunurluk) {
    final g = math.min(1.0, gorunurluk / 2.5);
    // Dış hale: açık zeminde de figürün çevresi ışısın.
    c.drawPath(
      bicim,
      Paint()
        ..blendMode = BlendMode.screen
        ..color = _nurAltin.withValues(alpha: 0.7 * g)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.1),
    );
    // Gövde: dolu, opak sıcak nur; kenarı hafif yumuşak.
    c.drawPath(
      bicim,
      Paint()
        ..color = Color.lerp(_nurAcik, _nurAltin, 0.18)!.withValues(alpha: 0.95 * g)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.012),
    );
    // Sarık: başın üst yarısını saran yeşil bir sargı.
    final sarik = Rect.fromCenter(
      center: Offset(x, ust + yk * 0.065),
      width: omuz * 1.02,
      height: yk * 0.12,
    );
    c.drawOval(
      sarik,
      Paint()
        ..color = _sarik.withValues(alpha: 0.95 * g)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.005),
    );
    // İç parlaklık: nur sarığın ve gövdenin üstüne hafifçe taşar.
    c.drawPath(
      bicim,
      Paint()
        ..blendMode = BlendMode.screen
        ..color = _nurAcik.withValues(alpha: 0.35 * g)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, yk * 0.04),
    );
  }

  void _toz() {
    final rnd = _rnd;
    final boya = Paint();
    // Havada asılı ince toz: küçük, soluk, yavaş. Kar gibi görünmemeli.
    for (var i = 0; i < 40; i++) {
      final x0 = rnd.nextDouble(), y0 = 0.25 + rnd.nextDouble() * 0.75;
      final hiz = 0.003 + rnd.nextDouble() * 0.008;
      final x = ((x0 + t * hiz) % 1.3) - 0.15;
      final y = y0 + math.sin(t * 0.3 + i) * 0.008;
      boya.color = _kum.withValues(alpha: 0.06 + rnd.nextDouble() * 0.1);
      c.drawCircle(Offset(x * w, y * h), (0.4 + rnd.nextDouble() * 0.8) * (s.shortestSide / 360), boya);
    }
  }

  void _bilinmeyen() {
    final r0 = Rect.fromLTWH(0.05 * w, 0.05 * h, 0.9 * w, 0.9 * h);
    c.drawRect(
      r0,
      Paint()
        ..color = const Color(0xFFFF00FF).withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }
}
