import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/oynatici/zaman_plani.dart';

import 'ornek_bolum.dart';

/// Üç cümlelik tek sahne; sessiz, süreler metinden:
/// p0 0.8–3.3, p1 3.9–13.9, p2 14.5–17.0, sahne sonu 18.2.
Bolum _bolum(List<Map<String, dynamic>> cekimler) => Bolum.fromJson({
      'id': 'b98-cekim',
      'sira': 98,
      'baslik': '',
      'ozet': '',
      'durum': 'taslak',
      'sahneler': [
        {
          'id': 'b98-s01',
          'anlatim': [
            {'metin': 'bir iki üç', 'iddialar': []},
            {'metin': List.filled(23, 'kelime').join(' '), 'iddialar': []},
            {'metin': 'son cümle', 'iddialar': []},
          ],
          'gorsel': {
            'tarif': 'ana',
            'saat': 'gece',
            'kamera': 'sabit',
            'katmanlar': [],
            'cekimler': cekimler,
          },
        },
      ],
      'iddialar': [],
    });

void main() {
  test('çekimsiz sahne tek çekimdir; çekim ilerlemesi sahneninkiyle aynı', () {
    final plan = ZamanPlani.olustur(ornekBolum());
    for (final an in [0.5, 7.0, 14.0, 20.0]) {
      final k = plan.konum(an);
      expect(k.cekimIlerleme, closeTo(k.ilerleme, 1e-9));
      expect(k.cekim.gorsel, same(k.sahne.sahne.gorsel));
    }
  });

  test('sahne geçişinde gelen çekim sonraki sahnenin ilk çekimidir', () {
    final plan = ZamanPlani.olustur(ornekBolum());
    final k = plan.konum(plan.sahneler[0].son - 0.45);
    expect(k.gelenCekim!.gorsel, same(plan.sahneler[1].sahne.gorsel));
    expect(k.gecisOrani, closeTo(0.5, 1e-9));
  });

  test('çekim saati verilmezse sahnenin saatini alır', () {
    final b = _bolum([
      {'parca': 1, 'tarif': 'yakın', 'kamera': 'yavas-yaklasma', 'katmanlar': []},
    ]);
    expect(b.sahneler[0].cekimler[1].saat, 'gece');
  });

  test('çekimler kendi parçalarının başında başlar', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 1, 'tarif': 'b', 'katmanlar': []},
      {'parca': 2, 'tarif': 'c', 'katmanlar': []},
    ]));
    final c = plan.sahneler[0].cekimler;
    expect(c.map((e) => e.gorsel.tarif), ['ana', 'b', 'c']);
    expect(c[1].bas, closeTo(3.9, 1e-9));
    expect(c[0].son, c[1].bas);
    expect(c[2].bas, closeTo(14.5, 1e-9));
    // Tek sahne = son sahne: kapanışta 1,2 yerine 4 sn bölüm sonu (18,2 + 2,8).
    expect(c[2].son, closeTo(21.0, 1e-9));
  });

  test('çekim geçişi parçadan önce biter, kamera her çekimde baştan başlar', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 1, 'tarif': 'b', 'katmanlar': []},
    ]));
    final once = plan.konum(2.0);
    expect(once.cekim.sira, 0);
    expect(once.gelenCekim, isNull);

    final gecis = plan.konum(3.5); // 3.1–3.9 geçiş
    expect(gecis.cekim.sira, 0);
    expect(gecis.gelenCekim!.sira, 1);
    expect(gecis.gecisOrani, closeTo(0.5, 1e-9));
    expect(gecis.gelenCekimIlerleme, closeTo(0.4 / (21.0 - 3.1), 1e-9));

    final sonra = plan.konum(5.0);
    expect(sonra.cekim.sira, 1);
    expect(sonra.gelenCekim, isNull);
    expect(sonra.cekimIlerleme, closeTo((5.0 - 3.1) / (21.0 - 3.1), 1e-9));
  });

  test('geçersiz ya da çok yakın çekimler atlanır', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 0, 'tarif': 'sıfır', 'katmanlar': []},
      {'parca': 9, 'tarif': 'yok', 'katmanlar': []},
      {'parca': 1, 'tarif': 'b', 'katmanlar': []},
      {'parca': 1, 'tarif': 'yine b', 'katmanlar': []},
    ]));
    expect(plan.sahneler[0].cekimler.map((e) => e.gorsel.tarif), ['ana', 'b']);
  });

  test('kadrajlı çekim ana katmanları devralır, gizleneni atlar, kendininkini üste koyar', () {
    final g = Gorsel.fromJson({
      'tarif': 'ana',
      'katmanlar': [
        {'id': 'gok', 'dosya': 'gok.webp', 'derinlik': 0},
        {'id': 'evler', 'dosya': 'evler.webp', 'derinlik': 0.4},
        {'id': 'kalabalik', 'dosya': 'uzak.webp', 'derinlik': 0.6},
      ],
      'cekimler': [
        {
          'parca': 1,
          'kadraj': {'x': 0.7, 'y': 0.6, 'yakinlik': 2},
          'gizle': ['kalabalik'],
          'katmanlar': [
            {'id': 'yakin', 'dosya': 'yakin.webp', 'derinlik': 0.8},
          ],
        },
        {'parca': 2, 'katmanlar': []},
      ],
    });
    final c = g.cekimler[0];
    expect(c.katmanlar.map((k) => k.id), ['gok', 'evler', 'yakin']);
    expect(c.katmanlar[1].kadraj!.yakinlik, 2);
    expect(c.katmanlar[1].kadraj!.x, 0.7);
    expect(c.katmanlar[2].kadraj, isNull);
    expect(g.katmanlar.every((k) => k.kadraj == null), isTrue);
    expect(g.cekimler[1].katmanlar, isEmpty, reason: 'kadrajsız çekim devralmaz');
  });

  test('cekimBasi istenen çekimin başını verir, sınır dışını kırpar', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 1, 'tarif': 'b', 'katmanlar': []},
    ]));
    expect(plan.cekimBasi(0, 1), closeTo(3.9, 1e-9));
    expect(plan.cekimBasi(0, 5), closeTo(3.9, 1e-9));
    expect(plan.cekimBasi(0, 0), 0);
  });

  test('an: çekim parçanın içinde, oranla verilen yerde başlar; parça 0 da olur', () {
    // p0 0.8–3.3, p1 3.9–13.9.
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 0, 'an': 0.4, 'tarif': 'b', 'katmanlar': []},
      {'parca': 1, 'an': 0.5, 'tarif': 'c', 'katmanlar': []},
    ]));
    final c = plan.sahneler[0].cekimler;
    expect(c.map((e) => e.gorsel.tarif), ['ana', 'b', 'c']);
    expect(c[1].bas, closeTo(1.8, 1e-9));
    expect(c[2].bas, closeTo(8.9, 1e-9));
  });

  test('parça 0 ve an 0 olan çekim ana görselle çakışır, atlanır', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 0, 'tarif': 'b', 'katmanlar': []},
    ]));
    expect(plan.sahneler[0].cekimler, hasLength(1));
  });

  test('gecis: çekime özgü geçiş süresi oranı ve kamera başlangıcını belirler', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 1, 'an': 0.5, 'gecis': 2.0, 'tarif': 'b', 'katmanlar': []},
    ]));
    final c = plan.sahneler[0].cekimler[1];
    expect(c.gecis, 2.0);
    final k = plan.konum(c.bas - 1.0);
    expect(k.gelenCekim!.sira, 1);
    expect(k.gecisOrani, closeTo(0.5, 1e-9));
    expect(k.gelenCekimIlerleme, greaterThan(0));
    expect(plan.konum(c.bas - 2.1).gelenCekim, isNull);
  });

  test('geçişi öncekinin geçişiyle üst üste binecek çekim atlanır', () {
    final plan = ZamanPlani.olustur(_bolum([
      {'parca': 1, 'an': 0.1, 'gecis': 1.5, 'tarif': 'b', 'katmanlar': []},
      // b 4.9'da başlar; c'nin geçişi (8.9 - 4) b bitmeden başlıyor.
      {'parca': 1, 'an': 0.5, 'gecis': 4.0, 'tarif': 'c', 'katmanlar': []},
    ]));
    expect(plan.sahneler[0].cekimler.map((e) => e.gorsel.tarif), ['ana', 'b']);
  });

  test('kamera yolu başta bas, sonda son kadrajını verir; düz eğri doğrusaldır', () {
    final g = Gorsel.fromJson({
      'tarif': 'gözler',
      'kamera': 'sabit',
      'katmanlar': [],
      'yol': {
        'bas': {'x': 0.25, 'y': 0.5, 'yakinlik': 2},
        'son': {'x': 0.75, 'y': 0.5, 'yakinlik': 2},
        'egri': 'duz',
      },
    });
    final y = g.yol!;
    expect(y.an(0).x, closeTo(0.25, 1e-9));
    expect(y.an(1).x, closeTo(0.75, 1e-9));
    expect(y.an(0.25).x, closeTo(0.375, 1e-9));
    expect(y.an(0.5).yakinlik, closeTo(2, 1e-9));
  });

  test('kamera yolunda yakınlık oranla artar; yumuşak eğri ortada simetriktir', () {
    final y = KameraYolu.fromJson({
      'bas': {'x': 0.2, 'y': 0.4, 'yakinlik': 1},
      'son': {'x': 0.2, 'y': 0.4, 'yakinlik': 4},
    })!;
    expect(y.duz, isFalse);
    expect(y.an(0.5).yakinlik, closeTo(2, 1e-9));
    expect(KameraYolu.fromJson({'son': {'x': 1}}), isNull);
  });
}
