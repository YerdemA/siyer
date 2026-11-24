/// İçerik JSON'unun uygulamadaki karşılığı. Şema: docs/ICERIK_SEMASI.md.
library;

import 'dart:math' as math;

String _metin(Map<String, dynamic> j, String alan) =>
    j[alan] is String ? j[alan] as String : '';

List<Map<String, dynamic>> _nesneler(Map<String, dynamic> j, String alan) =>
    (j[alan] as List? ?? const []).whereType<Map<String, dynamic>>().toList();

class Katman {
  const Katman({
    required this.id,
    required this.dosya,
    required this.yerTutucu,
    required this.derinlik,
    this.ayar = const {},
    this.kadraj,
  });

  factory Katman.fromJson(Map<String, dynamic> j) => Katman(
        id: _metin(j, 'id'),
        dosya: _metin(j, 'dosya'),
        yerTutucu: _metin(j, 'yerTutucu'),
        derinlik: (j['derinlik'] as num? ?? 0.5).toDouble().clamp(0.0, 1.0),
        ayar: j['ayar'] is Map<String, dynamic>
            ? j['ayar'] as Map<String, dynamic>
            : const {},
      );

  final String id;

  /// WebP görseli; boşsa [yerTutucu] çizilir.
  final String dosya;
  final String yerTutucu;

  /// 0 en uzak, 1 en yakın.
  final double derinlik;
  final Map<String, dynamic> ayar;

  /// Çekimin kadrajı; ana görselden devralınan katmanlarda dolu.
  final Kadraj? kadraj;

  Katman kadrajla(Kadraj k) =>
      Katman(id: id, dosya: dosya, yerTutucu: yerTutucu, derinlik: derinlik, ayar: ayar, kadraj: k);

  double sayi(String ad, double varsayilan) =>
      (ayar[ad] as num?)?.toDouble() ?? varsayilan;
  bool bayrak(String ad) => ayar[ad] == true;
  String yazi(String ad, String varsayilan) =>
      ayar[ad] is String ? ayar[ad] as String : varsayilan;

  /// `ayar.gorsel`: tek nesne görselinin (ör. Kâbe) kadrajdaki yeri. Yoksa
  /// görsel tam kadraja (taşma payıyla) yayılır.
  GorselYerlesim? get gorselYerlesim {
    final g = ayar['gorsel'];
    if (g is! Map<String, dynamic>) return null;
    double s(String ad, double v) => (g[ad] as num?)?.toDouble() ?? v;
    return GorselYerlesim(x: s('x', 0.5), y: s('y', 0.5), olcek: s('olcek', 1));
  }
}

/// [x], [y]: görselin merkezinin kadrajdaki yeri (0–1). [olcek]: görselin
/// genişliği, kadraj genişliğine oranla; yükseklik görselin oranından gelir.
/// Çekimin sahnedeki bakış noktası: kadrajın ortasına gelecek nokta ([x],
/// [y], ana görsele göre 0–1) ve yakınlık (1 = ana görselle aynı). Ana
/// görselin katmanları buna göre, derinlikleriyle orantılı büyütülür; uzak
/// katmanlar az, yakınlar çok (kamera gibi). Böylece yakın çekimde arka
/// plan uzak çekimdekiyle tutarlı kalır.
class Kadraj {
  const Kadraj({this.x = 0.5, this.y = 0.5, this.yakinlik = 1});

  static Kadraj? fromJson(Object? j) {
    if (j is! Map<String, dynamic>) return null;
    double s(String ad, double v) => (j[ad] as num?)?.toDouble() ?? v;
    return Kadraj(x: s('x', 0.5), y: s('y', 0.5), yakinlik: s('yakinlik', 1));
  }

  final double x;
  final double y;
  final double yakinlik;
}

/// Çekimin kendi kamera yolu: çekim boyunca kadraj [bas]'tan [son]'a gider.
/// Kadraj noktaları çekimin görseline göredir (0–1) ve bütün katmanlara aynı
/// uygulanır (parallax yok), böylece "sol gözden sağ göze" gibi kesin
/// hareketler yazılabilir. [duz]: doğrusal hız (çekimden çekime kesintisiz
/// kayma için); değilse başta ve sonda yavaşlar.
class KameraYolu {
  const KameraYolu({required this.bas, required this.son, this.duz = false});

  static KameraYolu? fromJson(Object? j) {
    if (j is! Map<String, dynamic>) return null;
    final bas = Kadraj.fromJson(j['bas']);
    final son = Kadraj.fromJson(j['son']) ?? bas;
    if (bas == null || son == null) return null;
    return KameraYolu(bas: bas, son: son, duz: j['egri'] == 'duz');
  }

  final Kadraj bas;
  final Kadraj son;
  final bool duz;

  /// [p] çekimin ilerlemesi (0–1).
  Kadraj an(double p) {
    final e = duz ? p : p * p * (3 - 2 * p);
    double ara(double a, double b) => a + (b - a) * e;
    // Yakınlık oranla değişir; böylece yaklaşma hızı göze sabit görünür.
    final z = bas.yakinlik * math.pow(son.yakinlik / bas.yakinlik, e).toDouble();
    return Kadraj(x: ara(bas.x, son.x), y: ara(bas.y, son.y), yakinlik: z);
  }
}

class GorselYerlesim {
  const GorselYerlesim({required this.x, required this.y, required this.olcek});

  final double x;
  final double y;
  final double olcek;
}

class Gorsel {
  const Gorsel({
    required this.tarif,
    required this.saat,
    required this.katmanlar,
    required this.kamera,
    this.parca = 0,
    this.an = 0,
    this.gecis,
    this.yol,
    this.cekimler = const [],
  });

  /// [ustSaat]: çekimde `saat` verilmezse sahnenin saati kullanılır.
  /// [ustKatmanlar]: çekimde `kadraj` varsa devralınan ana görsel katmanları.
  factory Gorsel.fromJson(
    Map<String, dynamic> j, {
    String ustSaat = 'gunduz',
    List<Katman> ustKatmanlar = const [],
  }) {
    final saat = _metin(j, 'saat').isEmpty ? ustSaat : _metin(j, 'saat');
    final kendi = _nesneler(j, 'katmanlar').map(Katman.fromJson).toList();
    final kadraj = Kadraj.fromJson(j['kadraj']);
    final gizle = _metinler(j, 'gizle').toSet();
    return Gorsel(
      tarif: _metin(j, 'tarif'),
      saat: saat,
      // Kadrajlı çekim: ana görselin katmanları (gizlenenler hariç) kadrajla,
      // üstüne çekimin kendi katmanları olduğu gibi.
      katmanlar: kadraj == null
          ? kendi
          : [
              for (final k in ustKatmanlar)
                if (!gizle.contains(k.id)) k.kadrajla(kadraj),
              ...kendi,
            ],
      kamera: _metin(j, 'kamera'),
      parca: (j['parca'] as num?)?.toInt() ?? 0,
      an: (j['an'] as num?)?.toDouble() ?? 0,
      gecis: (j['gecis'] as num?)?.toDouble(),
      yol: KameraYolu.fromJson(j['yol']),
      cekimler: [
        for (final c in _nesneler(j, 'cekimler'))
          Gorsel.fromJson(c, ustSaat: saat, ustKatmanlar: kendi),
      ],
    );
  }

  final String tarif;
  final String saat;
  final List<Katman> katmanlar;
  final String kamera;

  /// Çekimin başladığı anlatım parçasının sırası (0'dan). Sahnenin ana
  /// görselinde 0'dır.
  final int parca;

  /// Çekimin parçanın içinde başladığı yer (0 = parça başı, 0.5 = ortası).
  /// Parça süresi sesten geldiği için saniye yerine oran verilir.
  final double an;

  /// Bu çekime geçişin süresi (saniye); null ise varsayılan çapraz geçiş.
  final double? gecis;

  /// Verilirse `kamera` yerine bu yol kullanılır.
  final KameraYolu? yol;

  /// Sahnenin ana görselinden sonra gelen çekimler (docs/ICERIK_SEMASI.md).
  /// Her biri kendi `parca`sında başlar, kendi kamera hareketini yapar.
  final List<Gorsel> cekimler;

  /// Görsel üretilmeyen, oynatıcının kendisi çizdiği efekt katmanları.
  static const efektler = {'toz', 'nur'};

  /// Görseli henüz gelmemiş (efekt olmayan) katman var mı.
  bool get yerTutucuVar =>
      katmanlar.any((k) => k.dosya.isEmpty && !efektler.contains(k.yerTutucu));
}

class AnlatimParcasi {
  const AnlatimParcasi({required this.metin, required this.iddialar});

  factory AnlatimParcasi.fromJson(Map<String, dynamic> j) => AnlatimParcasi(
        metin: _metin(j, 'metin'),
        iddialar: (j['iddialar'] as List? ?? const []).whereType<String>().toList(),
      );

  final String metin;
  final List<String> iddialar;
}

/// Anlatım sesinde bir durak: ses [an] saniyesinde (dosyanın içinde, bir
/// sessizliğin ortası) [sure] saniye bekletilir, görüntü akmaya devam eder.
/// Ses dosyası değişmez.
class SesDuragi {
  const SesDuragi(this.an, this.sure);
  final double an;
  final double sure;
}

class Sahne {
  const Sahne({
    required this.id,
    required this.anlatim,
    required this.gorsel,
    required this.sesAnlatim,
    this.sesDuraklar = const [],
    this.sahislar = const [],
    this.yer = '',
  });

  factory Sahne.fromJson(Map<String, dynamic> j) {
    final ses = j['ses'] is Map<String, dynamic>
        ? j['ses'] as Map<String, dynamic>
        : const <String, dynamic>{};
    return Sahne(
      id: _metin(j, 'id'),
      anlatim: _nesneler(j, 'anlatim').map(AnlatimParcasi.fromJson).toList(),
      gorsel: j['gorsel'] is Map<String, dynamic>
          ? Gorsel.fromJson(j['gorsel'] as Map<String, dynamic>)
          : const Gorsel(tarif: '', saat: 'gunduz', katmanlar: [], kamera: ''),
      sesAnlatim: _metin(ses, 'anlatim'),
      sesDuraklar: [
        for (final d in _nesneler(ses, 'duraklar'))
          if (d['an'] is num && d['sure'] is num)
            SesDuragi((d['an'] as num).toDouble(), (d['sure'] as num).toDouble()),
      ]..sort((a, b) => a.an.compareTo(b.an)),
      sahislar: _metinler(j, 'sahislar'),
      yer: _metin(j, 'yer'),
    );
  }

  final String id;
  final List<AnlatimParcasi> anlatim;
  final Gorsel gorsel;
  final String sesAnlatim;

  /// Anlatım sesindeki duraklar, sırayla (docs/ICERIK_SEMASI.md → ses).
  final List<SesDuragi> sesDuraklar;

  /// Sahnede geçen şahısların `sahislar.json` kimlikleri.
  final List<String> sahislar;

  /// Olayın geçtiği yerin `yerler.json` kimliği; boşsa belirsiz (harita
  /// geçişinde önceki yer korunur).
  final String yer;

  /// Ana görsel ve ardından gelen çekimler, oynatılma sırasıyla.
  List<Gorsel> get cekimler => [gorsel, ...gorsel.cekimler];
}

class Atif {
  const Atif({required this.eser, required this.konum, required this.dogrulandi});

  factory Atif.fromJson(Map<String, dynamic> j) => Atif(
        eser: _metin(j, 'eser'),
        konum: _metin(j, 'konum'),
        dogrulandi: _metin(j, 'dogrulama') == 'dogrulandi',
      );

  final String eser;
  final String konum;
  final bool dogrulandi;
}

class Iddia {
  const Iddia({required this.id, required this.kaynaklar});

  factory Iddia.fromJson(Map<String, dynamic> j) => Iddia(
        id: _metin(j, 'id'),
        kaynaklar: _nesneler(j, 'kaynaklar').map(Atif.fromJson).toList(),
      );

  final String id;
  final List<Atif> kaynaklar;
}

class Bolum {
  const Bolum({
    required this.id,
    required this.sira,
    required this.baslik,
    required this.ozet,
    required this.durum,
    required this.sahneler,
    required this.iddialar,
  });

  factory Bolum.fromJson(Map<String, dynamic> j) => Bolum(
        id: _metin(j, 'id'),
        sira: (j['sira'] as num? ?? 0).toInt(),
        baslik: _metin(j, 'baslik'),
        ozet: _metin(j, 'ozet'),
        durum: _metin(j, 'durum'),
        sahneler: _nesneler(j, 'sahneler').map(Sahne.fromJson).toList(),
        iddialar: _nesneler(j, 'iddialar').map(Iddia.fromJson).toList(),
      );

  final String id;
  final int sira;
  final String baslik;
  final String ozet;
  final String durum;
  final List<Sahne> sahneler;
  final List<Iddia> iddialar;

  /// Bölüm sonunda gösterilecek tekil atıflar, ilk geçiş sırasıyla.
  List<Atif> get tumAtiflar {
    final gorulen = <String>{};
    return [
      for (final i in iddialar)
        for (final a in i.kaynaklar)
          if (gorulen.add('${a.eser}|${a.konum}')) a,
    ];
  }
}

/// kaynakca.json kaydı.
class Eser {
  const Eser({
    required this.id,
    required this.yazar,
    required this.ad,
    this.baski = '',
    this.katman = '',
    this.dil = '',
    this.erisim = '',
  });

  factory Eser.fromJson(Map<String, dynamic> j) => Eser(
        id: _metin(j, 'id'),
        yazar: _metin(j, 'yazar'),
        ad: _metin(j, 'eser'),
        baski: _metin(j, 'baski'),
        katman: _metin(j, 'katman'),
        dil: _metin(j, 'dil'),
        erisim: _metin(j, 'erisim'),
      );

  final String id;
  final String yazar;
  final String ad;
  final String baski;

  /// Kaynak katmanı (A–E), docs/KAYNAKLAR.md.
  final String katman;
  final String dil;

  /// Erişim notu; yerel kopya yolu gibi geliştirici bilgisi de içerebilir.
  final String erisim;

  String get kunye => yazar.isEmpty ? ad : '$yazar, $ad';

  /// Erişim notundaki ilk web adresi; kullanıcıya yalnız bu gösterilir.
  String get webAdresi => RegExp(r'https?://\S+').firstMatch(erisim)?.group(0) ?? '';
}

class Sahis {
  const Sahis({
    required this.id,
    required this.ad,
    this.lakap = '',
    this.yakinlik = '',
    this.ozet = '',
    this.bolumler = const [],
    this.iddialar = const [],
    this.portre = '',
    this.temsil = '',
  });

  factory Sahis.fromJson(Map<String, dynamic> j) => Sahis(
        id: _metin(j, 'id'),
        ad: _metin(j, 'ad'),
        lakap: _metin(j, 'lakap'),
        yakinlik: _metin(j, 'yakinlik'),
        ozet: _metin(j, 'ozet'),
        bolumler: _metinler(j, 'bolumler'),
        iddialar: _metinler(j, 'iddialar'),
        portre: _metin(j, 'portre'),
        temsil: _metin(j, 'temsil'),
      );

  final String id;
  final String ad;
  final String lakap;
  final String yakinlik;

  /// Tarihî bilgi içerir; [iddialar] boşsa kaynaksız sayılır.
  final String ozet;
  final List<String> bolumler;
  final List<String> iddialar;

  /// Portre görseli (`gorseller/` altında yol); boşsa baş harf madalyonu.
  final String portre;

  /// CLAUDE.md kural 5: `nur` (Efendimiz, peygamberler, melek) ya da
  /// `yuzsuz` (anne-babası, eşleri, çocukları, süt anneleri). Bunlara
  /// portre konmaz.
  final String temsil;
}

class ZamanOlayi {
  const ZamanOlayi({
    required this.id,
    required this.yil,
    required this.olay,
    this.yaklasik = false,
    this.bolum = '',
    this.iddia = '',
  });

  factory ZamanOlayi.fromJson(Map<String, dynamic> j) => ZamanOlayi(
        id: _metin(j, 'id'),
        yil: (j['yil'] as num?)?.toInt() ?? 0,
        yaklasik: j['yaklasik'] == true,
        olay: _metin(j, 'olay'),
        bolum: _metin(j, 'bolum'),
        iddia: _metin(j, 'iddia'),
      );

  final String id;

  /// Milâdî.
  final int yil;
  final bool yaklasik;
  final String olay;
  final String bolum;
  final String iddia;
}

class Yer {
  const Yer({
    required this.id,
    required this.ad,
    required this.x,
    required this.y,
    this.ozet = '',
    this.bolumler = const [],
    this.iddialar = const [],
  });

  factory Yer.fromJson(Map<String, dynamic> j) {
    final h = j['harita'] is Map<String, dynamic> ? j['harita'] as Map<String, dynamic> : const {};
    double eksen(String a) => ((h[a] as num?)?.toDouble() ?? 0.5).clamp(0.0, 1.0);
    return Yer(
      id: _metin(j, 'id'),
      ad: _metin(j, 'ad'),
      x: eksen('x'),
      y: eksen('y'),
      ozet: _metin(j, 'ozet'),
      bolumler: _metinler(j, 'bolumler'),
      iddialar: _metinler(j, 'iddialar'),
    );
  }

  final String id;
  final String ad;

  /// Parşömen üzerinde yaklaşık konum (0–1, sol üst 0,0).
  final double x;
  final double y;
  final String ozet;
  final List<String> bolumler;
  final List<String> iddialar;
}

List<String> _metinler(Map<String, dynamic> j, String alan) =>
    (j[alan] as List<dynamic>? ?? const []).whereType<String>().toList();
