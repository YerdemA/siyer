/// İçerik JSON'unun uygulamadaki karşılığı. Şema: docs/ICERIK_SEMASI.md.
library;

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
  });

  factory Gorsel.fromJson(Map<String, dynamic> j) => Gorsel(
        tarif: _metin(j, 'tarif'),
        saat: _metin(j, 'saat').isEmpty ? 'gunduz' : _metin(j, 'saat'),
        katmanlar: _nesneler(j, 'katmanlar').map(Katman.fromJson).toList(),
        kamera: _metin(j, 'kamera'),
      );

  final String tarif;
  final String saat;
  final List<Katman> katmanlar;
  final String kamera;
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

class Sahne {
  const Sahne({
    required this.id,
    required this.anlatim,
    required this.gorsel,
    required this.sesAnlatim,
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
    );
  }

  final String id;
  final List<AnlatimParcasi> anlatim;
  final Gorsel gorsel;
  final String sesAnlatim;
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
  });

  factory Sahis.fromJson(Map<String, dynamic> j) => Sahis(
        id: _metin(j, 'id'),
        ad: _metin(j, 'ad'),
        lakap: _metin(j, 'lakap'),
        yakinlik: _metin(j, 'yakinlik'),
        ozet: _metin(j, 'ozet'),
        bolumler: _metinler(j, 'bolumler'),
        iddialar: _metinler(j, 'iddialar'),
      );

  final String id;
  final String ad;
  final String lakap;
  final String yakinlik;

  /// Tarihî bilgi içerir; [iddialar] boşsa kaynaksız sayılır.
  final String ozet;
  final List<String> bolumler;
  final List<String> iddialar;
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

List<String> _metinler(Map<String, dynamic> j, String alan) =>
    (j[alan] as List<dynamic>? ?? const []).whereType<String>().toList();
