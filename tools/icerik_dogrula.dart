// İçerik doğrulama betiği: şema + kaynak denetimi.
//
// Kullanım (depo kökünden):
//   dart run tools/icerik_dogrula.dart            geliştirme denetimi
//   dart run tools/icerik_dogrula.dart --yayin    yayın denetimi
//   dart run tools/icerik_dogrula.dart --kapali-test
//                                                 kapalı test denetimi
//   dart run tools/icerik_dogrula.dart --kok <klasör>
//
// Kurallar docs/ICERIK_SEMASI.md ve docs/KAYNAK_POLITIKASI.md belgelerinden gelir.
// Yayın denetiminde `dogrulama` değeri `dogrulandi` olmayan tek bir atıf bile
// hatadır. Adı `_` ile başlayan dosyalar şablondur: geliştirme denetiminde
// denetlenir, yayın denetiminde atlanır.
//
// Kapalı test denetimi yayın denetimidir; tek farkı `bekliyor` atıfların uyarı
// sayılmasıdır (Erdem, 2026-11-21). Uygulama bu atıfları zaten "doğrulama
// bekliyor" diye gösterir. Herkese açık yayın yalnız --yayin ile derlenir.
//
// Çıkış kodu: 0 hata yok, 1 hata var, 2 yanlış kullanım.

import 'dart:convert';
import 'dart:io';

const durumlar = ['taslak', 'kaynak-dogrulandi', 'uzman-okudu', 'yayinda'];

/// Görsel üretilmeyen, oynatıcının çizdiği katmanlar.
const efektKatmanlari = {'toz', 'nur'};
const gucler = ['kesin', 'guclu', 'ihtilafli', 'zayif'];
const katmanlar = ['A', 'B', 'C', 'D', 'E'];

final bolumIdDeseni = RegExp(r'^b(\d{2})-[a-z0-9]+(-[a-z0-9]+)*$');
final tarihDeseni = RegExp(r'^\d{4}-\d{2}-\d{2}$');
final maddeDeseni = RegExp(r'"([^"]+)"');

class Rapor {
  Rapor(this.yayin, {this.kapaliTest = false});

  final bool yayin;

  /// Yalnız Play kapalı testi için: doğrulama bekleyen atıf hata değil uyarı.
  final bool kapaliTest;
  final hatalar = <String>[];
  final uyarilar = <String>[];

  void hata(String yer, String mesaj) => hatalar.add('$yer: $mesaj');
  void uyari(String yer, String mesaj) => uyarilar.add('$yer: $mesaj');

  /// Geliştirirken uyarı, yayın denetiminde hata.
  void yayinHatasi(String yer, String mesaj) =>
      yayin ? hata(yer, mesaj) : uyari(yer, mesaj);
}

class BolumOzeti {
  final sahneler = <String>{};
  final iddialar = <String>{};
}

class DilIcerigi {
  DilIcerigi(this.dil);

  final String dil;

  /// Kaynakça kimliği -> katman. Dosya yoksa null.
  Map<String, String>? kaynakca;
  Set<String>? sahislar;
  Set<String>? yerler;
  final bolumler = <String, BolumOzeti>{};
}

void main(List<String> args) {
  var kok = 'content';
  var yayin = false;
  var kapaliTest = false;
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--yayin':
        yayin = true;
      case '--kapali-test':
        yayin = true;
        kapaliTest = true;
      case '--kok' when i + 1 < args.length:
        kok = args[++i];
      default:
        stderr.writeln('Bilinmeyen seçenek: ${args[i]}');
        stderr.writeln(
          'Kullanım: dart run tools/icerik_dogrula.dart [--yayin | --kapali-test] [--kok <klasör>]',
        );
        exit(2);
    }
  }

  final kokKlasor = Directory(kok);
  if (!kokKlasor.existsSync()) {
    stderr.writeln('İçerik klasörü bulunamadı: $kok');
    exit(2);
  }

  final rapor = Rapor(yayin, kapaliTest: kapaliTest);
  final diller =
      kokKlasor
          .listSync()
          .whereType<Directory>()
          .map((d) => d.uri.pathSegments.lastWhere((s) => s.isNotEmpty))
          // `gorseller/` dilden bağımsız görsellerdir, dil klasörü değil.
          .where((ad) => ad != 'gorseller')
          .toList()
        ..sort();
  if (diller.isEmpty) rapor.hata(kok, 'dil klasörü yok (ör. content/tr)');

  final icerikler = [
    for (final dil in diller) diliDenetle(Directory('$kok/$dil'), dil, rapor),
  ];
  dilleriKarsilastir(icerikler, rapor);
  final bolumSayisi = icerikler.fold(0, (t, i) => t + i.bolumler.length);
  if (yayin && bolumSayisi == 0) rapor.hata(kok, 'yayımlanacak bölüm yok');

  for (final u in rapor.uyarilar) {
    stdout.writeln('UYARI  $u');
  }
  for (final h in rapor.hatalar) {
    stdout.writeln('HATA   $h');
  }
  stdout.writeln(
    '\n${kapaliTest ? "Kapalı test denetimi" : yayin ? "Yayın denetimi" : "Geliştirme denetimi"}: ${diller.length} dil, '
    '$bolumSayisi bölüm, ${rapor.hatalar.length} hata, ${rapor.uyarilar.length} uyarı.',
  );
  exit(rapor.hatalar.isEmpty ? 0 : 1);
}

// ---------------------------------------------------------------- yardımcılar

dynamic jsonOku(File dosya, Rapor rapor) {
  try {
    return jsonDecode(dosya.readAsStringSync());
  } on FormatException catch (e) {
    rapor.hata(dosya.path, 'JSON okunamadı: ${e.message}');
  } on FileSystemException catch (e) {
    rapor.hata(dosya.path, 'dosya okunamadı: ${e.message}');
  }
  return null;
}

/// Dolu bir metin alanını döndürür; yoksa ya da metin değilse boş döner.
String metin(Map<String, dynamic> nesne, String alan) {
  final v = nesne[alan];
  return v is String ? v.trim() : '';
}

/// [alan] bir liste olmalı. Değilse hata yazar ve boş liste döndürür.
List<dynamic> liste(
  Map<String, dynamic> nesne,
  String alan,
  String yer,
  Rapor rapor, {
  bool zorunlu = true,
}) {
  final v = nesne[alan];
  if (v is List) return v;
  if (v != null || zorunlu) rapor.hata(yer, '`$alan` bir liste olmalı');
  return const [];
}

/// Listedeki nesneleri sırayla verir; nesne olmayan öğeyi hata olarak yazar.
Iterable<(int, Map<String, dynamic>)> nesneler(
  List<dynamic> l,
  String yer,
  Rapor rapor,
) sync* {
  for (var i = 0; i < l.length; i++) {
    final o = l[i];
    if (o is Map<String, dynamic>) {
      yield (i, o);
    } else {
      rapor.hata('$yer[$i]', 'nesne olmalı');
    }
  }
}

/// Üst düzeyi liste olan bir veri dosyasını okur. Dosya yoksa null döner.
List<dynamic>? veriDosyasi(String yol, Rapor rapor) {
  final dosya = File(yol);
  if (!dosya.existsSync()) {
    rapor.yayinHatasi(
      yol,
      'dosya yok; bu dosyaya bağlı kimlik denetimleri yapılamadı',
    );
    return null;
  }
  final veri = jsonOku(dosya, rapor);
  if (veri == null) return null;
  if (veri is! List) {
    rapor.hata(yol, 'üst düzey bir liste olmalı');
    return null;
  }
  return veri;
}

/// Kimlikleri toplar; eksik ya da yinelenen kimliği hata olarak yazar.
Set<String> kimlikler(List<dynamic> l, String yol, Rapor rapor) {
  final ids = <String>{};
  for (final (i, o) in nesneler(l, yol, rapor)) {
    final id = metin(o, 'id');
    if (id.isEmpty) {
      rapor.hata('$yol[$i]', '`id` boş');
    } else if (!ids.add(id)) {
      rapor.hata('$yol[$i]', 'yinelenen kimlik: $id');
    }
  }
  return ids;
}

// ------------------------------------------------------------------- bir dil

DilIcerigi diliDenetle(Directory klasor, String dil, Rapor rapor) {
  final icerik = DilIcerigi(dil);
  final kok = klasor.path;

  // Kaynakça
  final kaynakcaYolu = '$kok/kaynakca.json';
  final kaynakca = veriDosyasi(kaynakcaYolu, rapor);
  if (kaynakca != null) {
    kimlikler(kaynakca, kaynakcaYolu, rapor);
    icerik.kaynakca = {};
    for (final (i, k) in nesneler(kaynakca, kaynakcaYolu, rapor)) {
      final id = metin(k, 'id');
      final yer = '$kaynakcaYolu[${id.isEmpty ? i : id}]';
      for (final alan in ['yazar', 'eser', 'baski', 'dil', 'erisim']) {
        if (metin(k, alan).isEmpty) rapor.yayinHatasi(yer, '`$alan` boş');
      }
      final katman = metin(k, 'katman');
      if (!katmanlar.contains(katman)) {
        rapor.hata(yer, '`katman` A–E olmalı (bulunan: "$katman")');
      }
      if (id.isNotEmpty) icerik.kaynakca![id] = katman;
    }
  }

  // Şahıslar ve yerler (kimlikler bölümlerden önce gerekir)
  final sahislarYolu = '$kok/sahislar.json';
  final sahislar = veriDosyasi(sahislarYolu, rapor);
  if (sahislar != null) {
    icerik.sahislar = kimlikler(sahislar, sahislarYolu, rapor);
  }
  final yerlerYolu = '$kok/yerler.json';
  final yerler = veriDosyasi(yerlerYolu, rapor);
  if (yerler != null) icerik.yerler = kimlikler(yerler, yerlerYolu, rapor);

  // Bölümler
  final siralar = <int, String>{};
  final bolumKlasoru = Directory('$kok/bolumler');
  final dosyalar = bolumKlasoru.existsSync()
      ? (bolumKlasoru
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.json'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path)))
      : <File>[];
  if (!bolumKlasoru.existsSync()) rapor.hata(kok, '`bolumler` klasörü yok');

  for (final dosya in dosyalar) {
    final ad = dosya.uri.pathSegments.last;
    final sablon = ad.startsWith('_');
    if (sablon && rapor.yayin) continue;
    final veri = jsonOku(dosya, rapor);
    if (veri == null) continue;
    if (veri is! Map<String, dynamic>) {
      rapor.hata(dosya.path, 'üst düzey bir nesne olmalı');
      continue;
    }
    final ozet = bolumuDenetle(
      veri,
      '$kok/bolumler/$ad',
      ad,
      sablon,
      icerik,
      rapor,
    );
    if (sablon) continue;
    final id = metin(veri, 'id');
    if (id.isEmpty) continue;
    if (icerik.bolumler.containsKey(id)) {
      rapor.hata(dosya.path, 'yinelenen bölüm kimliği: $id');
    }
    icerik.bolumler[id] = ozet;
    final sira = veri['sira'];
    if (sira is int) {
      final onceki = siralar[sira];
      if (onceki != null) {
        rapor.hata(dosya.path, '`sira` $sira, $onceki ile aynı');
      }
      siralar[sira] = id;
    }
  }

  // Şahıs, yer ve zaman çizelgesi kayıtlarının bölüm/iddia bağlantıları
  final tumIddialar = {for (final b in icerik.bolumler.values) ...b.iddialar};
  void bagDenetle(Map<String, dynamic> k, String yer) {
    for (final b in liste(k, 'bolumler', yer, rapor, zorunlu: false)) {
      if (!icerik.bolumler.containsKey(b)) {
        rapor.hata(yer, 'tanımsız bölüm: $b');
      }
    }
    for (final i in liste(k, 'iddialar', yer, rapor, zorunlu: false)) {
      if (!tumIddialar.contains(i)) rapor.hata(yer, 'tanımsız iddia: $i');
    }
  }

  for (final (i, s) in nesneler(sahislar ?? const [], sahislarYolu, rapor)) {
    final yer = '$sahislarYolu[${metin(s, 'id').isEmpty ? i : metin(s, 'id')}]';
    if (metin(s, 'ad').isEmpty) rapor.hata(yer, '`ad` boş');
    // Madalyon (docs/ICERIK_SEMASI.md → sahislar.json; CLAUDE.md kural 5).
    final temsil = metin(s, 'temsil');
    final portre = metin(s, 'portre');
    if (temsil.isNotEmpty && temsil != 'nur' && temsil != 'yuzsuz') {
      rapor.hata(yer, '`temsil` "nur" ya da "yuzsuz" olmalı (bulunan: "$temsil")');
    }
    if (temsil.isNotEmpty && portre.isNotEmpty) {
      rapor.hata(yer, '`temsil: $temsil` olan şahsa portre konmaz (kural 5)');
    }
    if (portre.isNotEmpty) {
      // Görseller dilden bağımsızdır: content/<dil>/sahislar.json → content/gorseller/
      final gorseller = File(sahislarYolu).parent.parent.path;
      if (!portre.toLowerCase().endsWith('.webp')) {
        rapor.hata(yer, '`portre` .webp olmalı: $portre');
      } else if (!File('$gorseller/gorseller/$portre').existsSync()) {
        rapor.hata(yer, 'portre görseli bulunamadı: gorseller/$portre');
      }
    }
    bagDenetle(s, yer);
  }
  for (final (i, y) in nesneler(yerler ?? const [], yerlerYolu, rapor)) {
    final yer = '$yerlerYolu[${metin(y, 'id').isEmpty ? i : metin(y, 'id')}]';
    if (metin(y, 'ad').isEmpty) rapor.hata(yer, '`ad` boş');
    // Harita gerçek harita değil, parşömen illüstrasyonu: konum, parşömen
    // üzerinde 0–1 aralığında göreli ve yaklaşıktır.
    final harita = y['harita'];
    if (harita is! Map<String, dynamic>) {
      rapor.hata(yer, '`harita` {x, y} nesnesi olmalı');
    } else {
      for (final eksen in ['x', 'y']) {
        final v = harita[eksen];
        if (v is! num || v < 0 || v > 1) {
          rapor.hata(yer, '`harita.$eksen` 0 ile 1 arasında sayı olmalı');
        }
      }
    }
    bagDenetle(y, yer);
  }

  final zamanYolu = '$kok/zaman-cizelgesi.json';
  final zaman = veriDosyasi(zamanYolu, rapor);
  if (zaman != null) {
    kimlikler(zaman, zamanYolu, rapor);
    for (final (i, z) in nesneler(zaman, zamanYolu, rapor)) {
      final yer = '$zamanYolu[${metin(z, 'id').isEmpty ? i : metin(z, 'id')}]';
      if (z['yil'] is! int) rapor.hata(yer, '`yil` tam sayı olmalı');
      if (metin(z, 'olay').isEmpty) rapor.hata(yer, '`olay` boş');
      final bolum = metin(z, 'bolum'), iddia = metin(z, 'iddia');
      if (!icerik.bolumler.containsKey(bolum)) {
        rapor.hata(yer, 'tanımsız bölüm: "$bolum"');
      }
      if (iddia.isEmpty) {
        rapor.hata(yer, '`iddia` boş; her tarih bir iddiaya bağlanmalı');
      } else if (!tumIddialar.contains(iddia)) {
        rapor.hata(yer, 'tanımsız iddia: $iddia');
      }
    }
  }

  return icerik;
}

// ----------------------------------------------------------------- bir bölüm

BolumOzeti bolumuDenetle(
  Map<String, dynamic> b,
  String yol,
  String dosyaAdi,
  bool sablon,
  DilIcerigi icerik,
  Rapor rapor,
) {
  final ozet = BolumOzeti();

  // Kimlik, sıra, başlık
  final id = metin(b, 'id');
  final eslesme = bolumIdDeseni.firstMatch(id);
  final onEk = eslesme == null ? null : 'b${eslesme.group(1)}';
  if (eslesme == null) {
    rapor.hata(yol, '`id` "b03-dogum" biçiminde olmalı (bulunan: "$id")');
  } else {
    if (!sablon && dosyaAdi != '$id.json') {
      rapor.hata(yol, 'dosya adı kimlikle aynı olmalı: $id.json');
    }
    if (b['sira'] != int.parse(eslesme.group(1)!)) {
      rapor.hata(
        yol,
        '`sira` (${b['sira']}) kimlikteki numarayla ($onEk) uyuşmuyor',
      );
    }
  }
  for (final alan in ['baslik', 'ozet']) {
    if (metin(b, alan).isEmpty) rapor.hata(yol, '`$alan` boş');
  }
  final durum = metin(b, 'durum');
  if (!durumlar.contains(durum)) {
    rapor.hata(yol, '`durum` şunlardan biri olmalı: ${durumlar.join(', ')}');
  }

  // İddialar
  final gucu = <String, String>{};
  var bekleyen = 0;
  for (final (i, iddia) in nesneler(
    liste(b, 'iddialar', yol, rapor),
    '$yol iddialar',
    rapor,
  )) {
    final iid = metin(iddia, 'id');
    final yer = '$yol ${iid.isEmpty ? 'iddialar[$i]' : iid}';
    if (onEk != null && !RegExp('^i-$onEk-\\d{3}\$').hasMatch(iid)) {
      rapor.hata(yer, 'iddia kimliği "i-$onEk-001" biçiminde olmalı');
    }
    if (iid.isNotEmpty && !ozet.iddialar.add(iid)) {
      rapor.hata(yer, 'yinelenen iddia kimliği');
    }
    if (metin(iddia, 'ifade').isEmpty) rapor.hata(yer, '`ifade` boş');
    final guc = metin(iddia, 'guc');
    if (!gucler.contains(guc)) {
      rapor.hata(yer, '`guc` şunlardan biri olmalı: ${gucler.join(', ')}');
    }
    gucu[iid] = guc;
    final gerekce = metin(iddia, 'gerekce');
    if (gerekce.isEmpty) {
      rapor.hata(yer, '`gerekce` boş');
    } else if (gerekce.startsWith('DOLDURULACAK')) {
      rapor.yayinHatasi(yer, '`gerekce` henüz doldurulmamış');
    }
    bekleyen += kaynaklariDenetle(iddia, yer, icerik, rapor, dayanak: true);
    for (final (j, alt) in nesneler(
      liste(iddia, 'alternatifRivayetler', yer, rapor, zorunlu: false),
      '$yer alternatifRivayetler',
      rapor,
    )) {
      final altYer = '$yer alternatifRivayetler[$j]';
      if (metin(alt, 'ifade').isEmpty) rapor.hata(altYer, '`ifade` boş');
      bekleyen += kaynaklariDenetle(alt, altYer, icerik, rapor, dayanak: false);
    }
  }

  // Sahneler
  final kullanilan = <String>{};
  var yerTutucuKatman = 0;
  var sesYok = 0;
  final sahneler = liste(b, 'sahneler', yol, rapor);
  if (sahneler.isEmpty && b['sahneler'] is List) {
    rapor.yayinHatasi(yol, 'bölümde sahne yok');
  }
  for (final (i, s) in nesneler(sahneler, '$yol sahneler', rapor)) {
    final sid = metin(s, 'id');
    final yer = '$yol ${sid.isEmpty ? 'sahneler[$i]' : sid}';
    if (onEk != null && !RegExp('^$onEk-s\\d{2}\$').hasMatch(sid)) {
      rapor.hata(yer, 'sahne kimliği "$onEk-s01" biçiminde olmalı');
    }
    if (sid.isNotEmpty && !ozet.sahneler.add(sid)) {
      rapor.hata(yer, 'yinelenen sahne kimliği');
    }

    final anlatim = liste(s, 'anlatim', yer, rapor);
    if (anlatim.isEmpty && s['anlatim'] is List) {
      rapor.hata(yer, '`anlatim` boş');
    }
    for (final (j, a) in nesneler(anlatim, '$yer anlatim', rapor)) {
      final aYer = '$yer anlatim[$j]';
      if (metin(a, 'metin').isEmpty) rapor.hata(aYer, '`metin` boş');
      for (final ref in liste(a, 'iddialar', aYer, rapor)) {
        if (!ozet.iddialar.contains(ref)) {
          rapor.hata(aYer, 'tanımsız iddia: $ref');
        } else if (gucu[ref] == 'zayif') {
          rapor.hata(aYer, 'zayıf iddia ana metne bağlanamaz: $ref');
        }
        if (ref is String) kullanilan.add(ref);
      }
    }

    final gorsel = s['gorsel'];
    if (gorsel is! Map<String, dynamic> || metin(gorsel, 'tarif').isEmpty) {
      rapor.yayinHatasi(yer, '`gorsel.tarif` boş');
    }
    if (gorsel is Map<String, dynamic>) {
      // Görseller dilden bağımsızdır: content/<dil>/bolumler/x.json → content/gorseller/
      final gorselKlasoru = File(yol).parent.parent.parent.path;
      // Ana görsel ve çekimleri (docs/ICERIK_SEMASI.md → Çekimler).
      final cekimler = <(String, Map<String, dynamic>)>[(yer, gorsel)];
      final parcaSayisi = anlatim.length;
      var oncekiParca = 0;
      for (final (j, c) in nesneler(liste(gorsel, 'cekimler', yer, rapor, zorunlu: false), '$yer cekimler', rapor)) {
        final cYer = '$yer cekimler[$j]';
        final parca = c['parca'];
        if (parca is! int || parca < 1 || parca >= parcaSayisi) {
          rapor.hata(cYer, '`parca` 1 ile ${parcaSayisi - 1} arasında bir sayı olmalı: $parca');
        } else if (parca <= oncekiParca) {
          rapor.hata(cYer, '`parca` öncekinden büyük olmalı: $parca');
        } else {
          oncekiParca = parca;
        }
        if (metin(c, 'tarif').isEmpty) rapor.yayinHatasi(cYer, '`tarif` boş');
        final kadraj = c['kadraj'];
        if (kadraj != null &&
            (kadraj is! Map<String, dynamic> ||
                ['x', 'y', 'yakinlik'].any((a) => kadraj[a] != null && kadraj[a] is! num))) {
          rapor.hata(cYer, '`kadraj` { x, y, yakinlik } sayılarından oluşmalı');
        }
        final anaIdler = {
          for (final k in liste(gorsel, 'katmanlar', yer, rapor, zorunlu: false))
            if (k is Map<String, dynamic>) metin(k, 'id'),
        };
        for (final g in liste(c, 'gizle', cYer, rapor, zorunlu: false)) {
          if (kadraj == null) {
            rapor.hata(cYer, '`gizle` yalnız `kadraj`lı çekimde anlamlı');
          } else if (!anaIdler.contains(g)) {
            rapor.hata(cYer, '`gizle`: ana görselde böyle katman yok: $g');
          }
        }
        cekimler.add((cYer, c));
      }
      for (final (gYer, g) in cekimler) {
        for (final k in liste(g, 'katmanlar', gYer, rapor, zorunlu: false)) {
          if (k is! Map<String, dynamic>) continue;
          final dosya = metin(k, 'dosya');
          if (dosya.isEmpty) {
            // Efekt katmanlarını oynatıcı kendisi çizer; görsel beklenmez
            // (app/lib/icerik/model.dart → Gorsel.efektler ile aynı liste).
            if (efektKatmanlari.contains(metin(k, 'yerTutucu'))) continue;
            yerTutucuKatman++;
          } else if (!File('$gorselKlasoru/gorseller/$dosya').existsSync()) {
            rapor.yayinHatasi(gYer, 'katman görseli bulunamadı: gorseller/$dosya');
          }
        }
      }
    }
    final ses = s['ses'];
    if (ses is! Map<String, dynamic> || metin(ses, 'anlatim').isEmpty) {
      rapor.yayinHatasi(yer, '`ses.anlatim` boş');
    } else if (!File('${File(yol).parent.parent.path}/ses/${metin(ses, 'anlatim')}').existsSync()) {
      // Anlatım sesi dil başınadır: content/<dil>/ses/<dosya>.
      sesYok++;
    }

    // Şablon, henüz kaydı olmayan örnek kimliklere gönderme yapabilir.
    final tanimsiz = sablon ? rapor.uyari : rapor.hata;
    for (final sahis in liste(s, 'sahislar', yer, rapor, zorunlu: false)) {
      if (icerik.sahislar != null && !icerik.sahislar!.contains(sahis)) {
        tanimsiz(yer, 'tanımsız şahıs: $sahis');
      }
    }
    final yerId = s['yer'];
    if (yerId != null && yerId != '') {
      if (yerId is! String) {
        rapor.hata(yer, '`yer` bir kimlik (metin) olmalı');
      } else if (icerik.yerler != null && !icerik.yerler!.contains(yerId)) {
        tanimsiz(yer, 'tanımsız yer: $yerId');
      }
    }
  }

  if (sesYok > 0) {
    rapor.yayinHatasi(yol, '$sesYok sahnenin anlatım sesi bulunamadı (süre metinden tahmin edilir)');
  }
  if (yerTutucuKatman > 0) {
    rapor.yayinHatasi(yol, '$yerTutucuKatman katmanın görseli yok (yer tutucu çizilir)');
  }

  for (final iid in ozet.iddialar.difference(kullanilan)) {
    if (gucu[iid] != 'zayif') {
      rapor.uyari('$yol $iid', 'hiçbir anlatım parçasına bağlı değil');
    }
  }

  // Durum ile doğrulama ve uzman okuması tutarlılığı
  if (bekleyen > 0) {
    if (durum != 'taslak' && durumlar.contains(durum)) {
      rapor.hata(
        yol,
        'durum "$durum" ama $bekleyen atıf doğrulanmamış; bölüm taslak kalmalı',
      );
    } else if (rapor.yayin && !rapor.kapaliTest) {
      rapor.hata(yol, '$bekleyen atıf doğrulanmamış (`dogrulandi` değil)');
    } else if (rapor.kapaliTest) {
      rapor.uyari(yol, '$bekleyen atıf doğrulanmamış (kapalı testte izinli, herkese açık yayında hata)');
    } else {
      rapor.uyari(yol, '$bekleyen atıf doğrulama bekliyor');
    }
  }
  if (durum == 'uzman-okudu' || durum == 'yayinda') {
    final uzman = b['uzmanOkumasi'];
    if (uzman is! Map<String, dynamic> ||
        metin(uzman, 'okuyan').isEmpty ||
        !tarihDeseni.hasMatch(metin(uzman, 'tarih'))) {
      rapor.hata(
        yol,
        'durum "$durum" ama `uzmanOkumasi` eksik (okuyan + YYYY-AA-GG tarih)',
      );
    }
  }

  return ozet;
}

/// Bir iddianın ya da alternatif rivayetin `kaynaklar` listesini denetler.
/// Doğrulanmamış atıf sayısını döndürür. [dayanak] doğruysa kaynak politikası
/// madde 2.1 de aranır: en az bir A/B/C kaynağı ya da en az iki D kaynağı.
/// Politikanın tek kaynak istisnası `"istisna": "tek-kaynak"` ile açıkça
/// işaretlenir; gerekçe boş olamaz ve her denetimde uyarı olarak listelenir.
int kaynaklariDenetle(
  Map<String, dynamic> sahip,
  String yer,
  DilIcerigi icerik,
  Rapor rapor, {
  required bool dayanak,
}) {
  final kaynaklar = liste(sahip, 'kaynaklar', yer, rapor);
  if (kaynaklar.isEmpty) {
    if (sahip['kaynaklar'] is List) rapor.hata(yer, 'kaynağı yok');
    return 0;
  }
  var bekleyen = 0;
  var katmanBilinir = icerik.kaynakca != null;
  final katmanaGore = <String, Set<String>>{};
  for (final (i, k) in nesneler(kaynaklar, '$yer kaynaklar', rapor)) {
    final kYer = '$yer kaynaklar[$i]';
    final eser = metin(k, 'eser');
    if (eser.isEmpty) {
      rapor.hata(kYer, '`eser` boş');
      katmanBilinir = false;
    } else if (icerik.kaynakca != null) {
      final katman = icerik.kaynakca![eser];
      if (katman == null) {
        rapor.hata(kYer, 'eser kaynakçada yok: $eser');
        katmanBilinir = false;
      } else {
        // Ansiklopedi gibi çok maddeli eserlerde her madde ayrı kaynak sayılır;
        // madde adı konumda tırnak içinde yazılır: Müellif, "MADDE", c., s.
        final madde = maddeDeseni.firstMatch(metin(k, 'konum'))?.group(1);
        katmanaGore
            .putIfAbsent(katman, () => {})
            .add(madde == null ? eser : '$eser|$madde');
      }
    }
    final dogrulama = metin(k, 'dogrulama');
    if (dogrulama == 'dogrulandi') {
      if (metin(k, 'konum').isEmpty) {
        rapor.hata(kYer, 'doğrulanmış atıfta `konum` boş olamaz');
      }
      if (metin(k, 'dogrulayan').isEmpty) {
        rapor.hata(kYer, 'doğrulanmış atıfta `dogrulayan` boş olamaz');
      }
      if (!tarihDeseni.hasMatch(metin(k, 'tarih'))) {
        rapor.hata(kYer, 'doğrulanmış atıfta `tarih` YYYY-AA-GG olmalı');
      }
    } else if (dogrulama == 'bekliyor') {
      bekleyen++;
    } else {
      rapor.hata(kYer, '`dogrulama` "bekliyor" ya da "dogrulandi" olmalı');
      bekleyen++;
    }
  }
  if (dayanak && katmanBilinir) {
    final abc = ['A', 'B', 'C'].any(katmanaGore.containsKey);
    final dSayisi = katmanaGore['D']?.length ?? 0;
    final istisna = metin(sahip, 'istisna');
    if (istisna.isNotEmpty && istisna != 'tek-kaynak') {
      rapor.hata(yer, '`istisna` yalnız "tek-kaynak" olabilir');
    }
    if (!abc && dSayisi < 2 && istisna == 'tek-kaynak') {
      if (metin(sahip, 'gerekce').isEmpty) {
        rapor.hata(yer, 'tek kaynak istisnasında `gerekce` boş olamaz (KAYNAK_POLITIKASI 2.1)');
      } else {
        rapor.uyari(yer, 'tek kaynak istisnası (KAYNAK_POLITIKASI 2.1); Erdem gerekçeyi onaylamalı');
      }
    } else if (!abc && dSayisi < 2) {
      rapor.yayinHatasi(
        yer,
        'dayanak yetersiz: en az bir A/B/C kaynağı ya da iki ayrı D kaynağı '
        'gerekir (KAYNAK_POLITIKASI 2.1)',
      );
    }
  }
  return bekleyen;
}

// ------------------------------------------------------------ diller arası

/// İlk dil (varsa `tr`) esas alınır; diğer dillerdeki bölüm, sahne ve iddia
/// kimlikleri onunla eşleşmelidir. Henüz çevrilmemiş bölüm uyarıdır.
void dilleriKarsilastir(List<DilIcerigi> icerikler, Rapor rapor) {
  if (icerikler.length < 2) return;
  final esas = icerikler.firstWhere(
    (i) => i.dil == 'tr',
    orElse: () => icerikler.first,
  );
  for (final diger in icerikler) {
    if (identical(diger, esas)) continue;
    final yer = 'diller ${esas.dil}↔${diger.dil}';
    for (final id in diger.bolumler.keys) {
      if (!esas.bolumler.containsKey(id)) {
        rapor.hata(
          yer,
          'bölüm ${diger.dil} içinde var, ${esas.dil} içinde yok: $id',
        );
      }
    }
    for (final MapEntry(key: id, value: esasOzet) in esas.bolumler.entries) {
      final digerOzet = diger.bolumler[id];
      if (digerOzet == null) {
        rapor.yayinHatasi(yer, 'bölüm ${diger.dil} içinde yok: $id');
        continue;
      }
      void fark(String tur, Set<String> a, Set<String> b) {
        final eksik = a.difference(b), fazla = b.difference(a);
        if (eksik.isNotEmpty) {
          rapor.hata(
            yer,
            '$id: ${diger.dil} içinde eksik $tur: ${eksik.join(', ')}',
          );
        }
        if (fazla.isNotEmpty) {
          rapor.hata(
            yer,
            '$id: ${diger.dil} içinde fazla $tur: ${fazla.join(', ')}',
          );
        }
      }

      fark('sahne', esasOzet.sahneler, digerOzet.sahneler);
      fark('iddia', esasOzet.iddialar, digerOzet.iddialar);
    }
  }
}
