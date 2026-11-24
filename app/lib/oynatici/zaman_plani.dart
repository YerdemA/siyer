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
    this.bolumSonu = 4.0,
    this.gecis = 0.9,
    this.cekimGecisi = 0.8,
  });

  /// Saniyede okunan kelime (sakin belgesel anlatımı ≈ 140 kelime/dk).
  final double kelimeHizi;
  final double enAzParca;
  final double parcaArasi;

  /// Sahne açıldıktan sonra ilk cümleye kadar sessiz süre.
  final double sahneBasi;

  /// Son cümleden sonra görüntünün nefes alması için süre.
  final double sahneSonu;

  /// Son sahnede [sahneSonu] yerine: görüntü yavaşça kararır, izleyici
  /// bölümün bittiğini hisseder (Erdem, 2026-11-21).
  final double bolumSonu;

  /// Sahneler arası çapraz geçiş süresi (bir sonraki sahnenin içine taşar).
  final double gecis;

  /// Sahne içinde çekimler arası çapraz geçiş; çekimin başladığı parçadan
  /// hemen önce biter.
  final double cekimGecisi;
}

class ParcaZamani {
  const ParcaZamani(this.parca, this.bas, this.son);
  final AnlatimParcasi parca;
  final double bas;
  final double son;
}

/// Sahne içindeki bir çekim: [bas] anında tam görünür (kendi [gecis]i
/// [bas]'tan önce biter), [son]'da yerini sonrakine bırakır.
class CekimZamani {
  const CekimZamani(this.sira, this.gorsel, this.bas, this.son, {this.gecis = 0.8});
  final int sira;
  final Gorsel gorsel;
  final double bas;
  final double son;

  /// Bu çekime gelişteki çapraz geçişin süresi.
  final double gecis;
}

class SahneZamani {
  SahneZamani(this.sira, this.sahne, this.bas, this.son, this.parcalar,
      {this.sesBas = 0, this.sesSure, List<CekimZamani>? cekimler})
      : cekimler = cekimler ?? [CekimZamani(0, sahne.gorsel, bas, son)];
  final int sira;
  final Sahne sahne;
  final double bas;
  final double son;
  final List<ParcaZamani> parcalar;

  /// En az bir öğe: ana görsel. Çekim tanımlanmadıysa tek öğedir.
  final List<CekimZamani> cekimler;

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
    required this.cekim,
    this.cekimIlerleme = 0,
    this.gelenCekim,
    this.gelenCekimIlerleme = 0,
  });

  final SahneZamani sahne;

  /// Sahnenin kendi görsel süresi içinde 0–1.
  final double ilerleme;
  final SahneZamani? gelen;
  final double gelenIlerleme;

  /// 0 = yalnız [cekim], 1 = tamamen [gelenCekim] (sahne ya da çekim geçişi).
  final double gecisOrani;
  final ParcaZamani? parca;

  /// Ekranda çizilen çekim ve kendi süresi içindeki ilerlemesi (kamera).
  final CekimZamani cekim;
  final double cekimIlerleme;

  /// Geçişteyse gelen çekim: aynı sahnenin sonraki çekimi ya da sonraki
  /// sahnenin ilk çekimi.
  final CekimZamani? gelenCekim;
  final double gelenCekimIlerleme;
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
      t += i == bolum.sahneler.length - 1 ? ayar.bolumSonu : ayar.sahneSonu;
      sahneler.add(SahneZamani(i, sahne, bas, t, parcalar,
          sesBas: sesBas,
          sesSure: sesSure != null && sesSure > 0 ? sesSure : null,
          cekimler: _cekimler(sahne, bas, t, parcalar, ayar)));
    }
    return ZamanPlani._(sahneler, t, ayar);
  }

  /// Çekim başları: ana görsel sahne başında, diğerleri kendi parçalarının
  /// içinde `an` oranındaki yerde (varsayılan parça başı). Geçerli parçası
  /// olmayan ya da geçişi öncekinin geçişiyle üst üste binecek çekim atlanır.
  static List<CekimZamani> _cekimler(
      Sahne sahne, double bas, double son, List<ParcaZamani> parcalar, ZamanAyari ayar) {
    final baslar = <(Gorsel, double, double)>[(sahne.gorsel, bas, 0)];
    for (final c in sahne.gorsel.cekimler) {
      if (c.parca < 0 || c.parca >= parcalar.length) continue;
      if (c.an < 0 || c.an >= 1 || (c.parca == 0 && c.an == 0)) continue;
      final p = parcalar[c.parca];
      final b = p.bas + (p.son - p.bas) * c.an;
      final g = c.gecis ?? ayar.cekimGecisi;
      if (b - g < baslar.last.$2 + baslar.last.$3) continue;
      // Sahne sonu geçişine de yer kalsın.
      if (b > son - ayar.gecis - g) continue;
      baslar.add((c, b, g));
    }
    return [
      for (final (k, (g, b, gs)) in baslar.indexed)
        CekimZamani(k, g, b, k + 1 < baslar.length ? baslar[k + 1].$2 : son, gecis: gs),
    ];
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

  /// Çekimin kamera ilerlemesi: görünmeye başladığı andan (geçiş dahil)
  /// bittiği ana kadar 0–1. Tek çekimli sahnede sahne ilerlemesiyle aynıdır.
  double _cekimIlerleme(SahneZamani s, CekimZamani c, double an) {
    final bas = c.sira == 0 ? gorunurAralik(s).$1 : c.bas - c.gecis;
    if (c.son <= bas) return 1;
    return ((an - bas) / (c.son - bas)).clamp(0.0, 1.0);
  }

  /// Sahnenin [cekim]. çekiminin başladığı an (`?cekim=` ile atlamak için).
  double cekimBasi(int sahneSirasi, int cekim) {
    final s = sahneler[sahneSirasi.clamp(0, sahneler.length - 1)];
    return s.cekimler[cekim.clamp(0, s.cekimler.length - 1)].bas;
  }

  Konum konum(double an) {
    an = an.clamp(0.0, toplam);
    final asil = sahneler[sahneSirasi(an)];
    ParcaZamani? parca;
    for (final p in asil.parcalar) {
      if (an >= p.bas && an < p.son) parca = p;
    }
    var cekim = asil.cekimler.first;
    for (final c in asil.cekimler) {
      if (an >= c.bas) cekim = c;
    }
    final cekimIlerleme = _cekimIlerleme(asil, cekim, an);
    final sonraki = asil.sira + 1 < sahneler.length ? sahneler[asil.sira + 1] : null;
    final gecisBasi = asil.son - ayar.gecis;
    if (sonraki != null && an >= gecisBasi) {
      final gelenCekim = sonraki.cekimler.first;
      return Konum(
        sahne: asil,
        ilerleme: _ilerleme(asil, an),
        gelen: sonraki,
        gelenIlerleme: _ilerleme(sonraki, an),
        gecisOrani: ((an - gecisBasi) / ayar.gecis).clamp(0.0, 1.0),
        parca: parca,
        cekim: cekim,
        cekimIlerleme: cekimIlerleme,
        gelenCekim: gelenCekim,
        gelenCekimIlerleme: _cekimIlerleme(sonraki, gelenCekim, an),
      );
    }
    final ci = cekim.sira + 1;
    if (ci < asil.cekimler.length) {
      final gelenCekim = asil.cekimler[ci];
      final cekimGecisBasi = gelenCekim.bas - gelenCekim.gecis;
      if (an >= cekimGecisBasi) {
        return Konum(
          sahne: asil,
          ilerleme: _ilerleme(asil, an),
          gecisOrani: ((an - cekimGecisBasi) / gelenCekim.gecis).clamp(0.0, 1.0),
          parca: parca,
          cekim: cekim,
          cekimIlerleme: cekimIlerleme,
          gelenCekim: gelenCekim,
          gelenCekimIlerleme: _cekimIlerleme(asil, gelenCekim, an),
        );
      }
    }
    return Konum(
      sahne: asil,
      ilerleme: _ilerleme(asil, an),
      parca: parca,
      cekim: cekim,
      cekimIlerleme: cekimIlerleme,
    );
  }
}
