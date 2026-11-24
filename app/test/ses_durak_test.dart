import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/oynatici/zaman_plani.dart';

/// Tek sahne, iki eşit cümle, 10 sn ses; sesin 5. saniyesinde 3 sn durak.
/// Sahne başı 0.8: p0 0.8–5.8, durak 5.8–8.8, p1 8.8–13.8, ses sonu 13.8,
/// sahne sonu (bölüm sonu 4) 17.8.
ZamanPlani _plan({List<Map<String, dynamic>> duraklar = const [{'an': 5.0, 'sure': 3.0}]}) =>
    ZamanPlani.olustur(
      Bolum.fromJson({
        'id': 'b97-durak',
        'sira': 97,
        'baslik': '',
        'ozet': '',
        'durum': 'taslak',
        'sahneler': [
          {
            'id': 'b97-s01',
            'anlatim': [
              {'metin': 'bir iki üç dört', 'iddialar': []},
              {'metin': 'beş altı yedi sekiz', 'iddialar': []},
            ],
            'gorsel': {'tarif': 'ana', 'kamera': 'sabit', 'katmanlar': []},
            'ses': {'anlatim': 'b97-s01.mp3', 'duraklar': duraklar},
          },
        ],
        'iddialar': [],
      }),
      sesSureleri: {'b97-s01': 10},
    );

void main() {
  test('durak parçaları ve sahne sonunu öteler', () {
    final s = _plan().sahneler[0];
    expect(s.parcalar[0].bas, closeTo(0.8, 1e-9));
    expect(s.parcalar[0].son, closeTo(5.8, 1e-9), reason: 'durak tam parça sınırında: parça durmadan biter');
    expect(s.parcalar[1].bas, closeTo(8.8, 1e-9));
    expect(s.parcalar[1].son, closeTo(13.8, 1e-9));
    expect(s.son, closeTo(17.8, 1e-9));
  });

  test('parçanın ortasındaki durak parçayı uzatır', () {
    final s = _plan(duraklar: [{'an': 2.0, 'sure': 1.5}]).sahneler[0];
    expect(s.parcalar[0].bas, closeTo(0.8, 1e-9));
    expect(s.parcalar[0].son, closeTo(7.3, 1e-9));
    expect(s.parcalar[1].bas, closeTo(7.3, 1e-9));
  });

  test('durakta ses yoktur, sonra kaldığı yerden sürer', () {
    final s = _plan().sahneler[0];
    expect(s.sesKonumu(0.5), isNull);
    expect(s.sesKonumu(3.8), closeTo(3.0, 1e-9));
    expect(s.sesKonumu(5.79), closeTo(4.99, 1e-9));
    expect(s.sesKonumu(7.0), isNull, reason: 'durak');
    expect(s.sesKonumu(8.8), closeTo(5.0, 1e-9));
    expect(s.sesKonumu(10.0), closeTo(6.2, 1e-9));
    expect(s.sesKonumu(13.9), isNull, reason: 'ses bitti');
  });

  test('sesAni sesKonumunun tersidir; durak kenarında yakın olan seçilir', () {
    final s = _plan().sahneler[0];
    for (final an in [1.0, 4.0, 9.0, 13.0]) {
      expect(s.sesAni(s.sesKonumu(an)!), closeTo(an, 1e-9));
    }
    // Ses 5.0'da bekliyor: durağın başı da sonu da 5.0. Saat durağın
    // sonundaysa sonu, başındaysa başı seçilir.
    expect(s.sesAni(5.0, yakin: 8.7), closeTo(8.8, 1e-9));
    expect(s.sesAni(4.98, yakin: 8.75), closeTo(8.78, 1e-9));
    expect(s.sesAni(4.98, yakin: 5.7), closeTo(5.78, 1e-9));
    expect(s.sesAni(5.1, yakin: 5.85), closeTo(5.9, 1e-9));
  });

  test('durak verilmeyen sesli sahne eskisi gibi', () {
    final s = _plan(duraklar: []).sahneler[0];
    expect(s.son, closeTo(14.8, 1e-9));
    expect(s.sesKonumu(5.8), closeTo(5.0, 1e-9));
  });
}
