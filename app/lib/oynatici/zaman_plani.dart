import 'dart:math' as math;

import '../icerik/model.dart';

/// Bir bölümün zaman çizelgesi.
///
/// Anlatım sesi henüz olmadığından her parçanın süresi kelime sayısından
/// tahmin edilir. Ses dosyaları gelince süreler sesten okunacak; geri kalan
/// her şey (sahne sınırları, geçişler, altyazı) aynı kalır.
class ZamanAyari {
  const ZamanAyari({
    this.kelimeHizi = 2.3,
    this.enAzParca = 2.5,
    this.parcaArasi = 0.6,
    this.sahneBasi = 0.8,
    this.sahneSonu = 1.2,
    this.gecis = 0.9,
  });

  /// Saniyede okunan kelime (sakin belgesel anlatımı ≈ 140 kelime/dk).
  final double kelimeHizi;
  final double enAzParca;
  final double parcaArasi;

  /// Sahne açıldıktan sonra ilk cümleye kadar sessiz süre.
  final double sahneBasi;

  /// Son cümleden sonra görüntünün nefes alması için süre.
  final double sahneSonu;

  /// Sahneler arası çapraz geçiş süresi (bir sonraki sahnenin içine taşar).
  final double gecis;
}

class ParcaZamani {
  const ParcaZamani(this.parca, this.bas, this.son);
  final AnlatimParcasi parca;
  final double bas;
  final double son;
}

class SahneZamani {
  const SahneZamani(this.sira, this.sahne, this.bas, this.son, this.parcalar);
  final int sira;
  final Sahne sahne;
  final double bas;
  final double son;
  final List<ParcaZamani> parcalar;
  double get sure => son - bas;
}

/// [an] anında ekranda olan: asıl sahne, (geçişteyse) gelen sahne ve altyazı.
class Konum {
  const Konum({
    required this.sahne,
    required this.ilerleme,
    this.gelen,
    this.gelenIlerleme = 0,
    this.gecisOrani = 0,
    this.parca,
  });

  final SahneZamani sahne;

  /// Sahnenin kendi görsel süresi içinde 0–1.
  final double ilerleme;
  final SahneZamani? gelen;
  final double gelenIlerleme;

  /// 0 = yalnız [sahne], 1 = tamamen [gelen].
  final double gecisOrani;
  final ParcaZamani? parca;
}

class ZamanPlani {
  ZamanPlani._(this.sahneler, this.toplam, this.ayar);

  factory ZamanPlani.olustur(Bolum bolum, {ZamanAyari ayar = const ZamanAyari()}) {
    final sahneler = <SahneZamani>[];
    var t = 0.0;
    for (final (i, sahne) in bolum.sahneler.indexed) {
      final bas = t;
      t += ayar.sahneBasi;
      final parcalar = <ParcaZamani>[];
      for (final (j, p) in sahne.anlatim.indexed) {
        if (j > 0) t += ayar.parcaArasi;
        final sure = parcaSuresi(p.metin, ayar);
        parcalar.add(ParcaZamani(p, t, t + sure));
        t += sure;
      }
      t += ayar.sahneSonu;
      sahneler.add(SahneZamani(i, sahne, bas, t, parcalar));
    }
    return ZamanPlani._(sahneler, t, ayar);
  }

  static double parcaSuresi(String metin, ZamanAyari ayar) {
    final kelime = metin.trim().split(RegExp(r'\s+')).where((k) => k.isNotEmpty).length;
    return math.max(ayar.enAzParca, kelime / ayar.kelimeHizi);
  }

  final List<SahneZamani> sahneler;
  final double toplam;
  final ZamanAyari ayar;

  int sahneSirasi(double an) {
    for (final s in sahneler) {
      if (an < s.son) return s.sira;
    }
    return sahneler.length - 1;
  }

  /// Bir sahnenin görsel olarak göründüğü aralık: kendi süresi artı, ilk
  /// sahne değilse, öncekinin sonuna taşan geçiş süresi.
  (double, double) gorunurAralik(SahneZamani s) =>
      (s.sira == 0 ? s.bas : s.bas - ayar.gecis, s.son);

  double _ilerleme(SahneZamani s, double an) {
    final (bas, son) = gorunurAralik(s);
    return ((an - bas) / (son - bas)).clamp(0.0, 1.0);
  }

  Konum konum(double an) {
    an = an.clamp(0.0, toplam);
    final asil = sahneler[sahneSirasi(an)];
    ParcaZamani? parca;
    for (final p in asil.parcalar) {
      if (an >= p.bas && an < p.son) parca = p;
    }
    final sonraki = asil.sira + 1 < sahneler.length ? sahneler[asil.sira + 1] : null;
    final gecisBasi = asil.son - ayar.gecis;
    if (sonraki != null && an >= gecisBasi) {
      return Konum(
        sahne: asil,
        ilerleme: _ilerleme(asil, an),
        gelen: sonraki,
        gelenIlerleme: _ilerleme(sonraki, an),
        gecisOrani: ((an - gecisBasi) / ayar.gecis).clamp(0.0, 1.0),
        parca: parca,
      );
    }
    return Konum(sahne: asil, ilerleme: _ilerleme(asil, an), parca: parca);
  }
}
