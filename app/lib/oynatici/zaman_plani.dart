import 'dart:math' as math;

import '../icerik/model.dart';

/// Bir bölümün zaman çizelgesi.
///
/// Anlatım sesi olan sahnede süre sesten gelir: sahne başı sessizliği, ses,
/// sahne sonu sessizliği. Parçaların (altyazı) süresi ses süresine kelime
/// sayısıyla orantılı paylaştırılır; aradaki duraklar kaydın içindedir. Sesi
/// olmayan sahnede her parçanın süresi kelime sayısından tahmin edilir.
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
  const SahneZamani(this.sira, this.sahne, this.bas, this.son, this.parcalar,
      {this.sesBas = 0, this.sesSure});
  final int sira;
  final Sahne sahne;
  final double bas;
  final double son;
  final List<ParcaZamani> parcalar;

  /// Anlatım sesinin bölüm zamanındaki başlangıcı; [sesSure] null ise ses yok.
  final double sesBas;
  final double? sesSure;

  bool get sesli => sesSure != null;
  double get sure => son - bas;

  /// [an] anında sesin içindeki konum (saniye); ses dışındaysa null.
  double? sesKonumu(double an) {
    final s = sesSure;
    if (s == null || an < sesBas || an >= sesBas + s) return null;
    return an - sesBas;
  }
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

  /// [sesSureleri]: sahne kimliğinden anlatım sesinin süresine (saniye).
  factory ZamanPlani.olustur(
    Bolum bolum, {
    ZamanAyari ayar = const ZamanAyari(),
    Map<String, double> sesSureleri = const {},
  }) {
    final sahneler = <SahneZamani>[];
    var t = 0.0;
    for (final (i, sahne) in bolum.sahneler.indexed) {
      final bas = t;
      t += ayar.sahneBasi;
      final sesBas = t;
      final sesSure = sesSureleri[sahne.id];
      final parcalar = <ParcaZamani>[];
      if (sesSure != null && sesSure > 0) {
        final agirliklar = [for (final p in sahne.anlatim) math.max(1, kelimeSayisi(p.metin))];
        final toplamAgirlik = agirliklar.fold(0, (a, b) => a + b);
        for (final (j, p) in sahne.anlatim.indexed) {
          final sure = sesSure * agirliklar[j] / toplamAgirlik;
          parcalar.add(ParcaZamani(p, t, t + sure));
          t += sure;
        }
        // Parça yoksa da ses tam çalınsın.
        t = sesBas + sesSure;
      } else {
        for (final (j, p) in sahne.anlatim.indexed) {
          if (j > 0) t += ayar.parcaArasi;
          final sure = parcaSuresi(p.metin, ayar);
          parcalar.add(ParcaZamani(p, t, t + sure));
          t += sure;
        }
      }
      t += ayar.sahneSonu;
      sahneler.add(SahneZamani(i, sahne, bas, t, parcalar,
          sesBas: sesBas, sesSure: sesSure != null && sesSure > 0 ? sesSure : null));
    }
    return ZamanPlani._(sahneler, t, ayar);
  }

  static int kelimeSayisi(String metin) =>
      metin.trim().split(RegExp(r'\s+')).where((k) => k.isNotEmpty).length;

  static double parcaSuresi(String metin, ZamanAyari ayar) =>
      math.max(ayar.enAzParca, kelimeSayisi(metin) / ayar.kelimeHizi);

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
