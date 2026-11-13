import 'package:siyer/icerik/model.dart';

/// Testler için iki sahnelik küçük bir bölüm.
Bolum ornekBolum() => Bolum.fromJson({
      'id': 'b99-deneme',
      'sira': 99,
      'baslik': 'Deneme',
      'ozet': '',
      'durum': 'taslak',
      'sahneler': [
        {
          'id': 'b99-s01',
          'anlatim': [
            {'metin': 'bir iki üç', 'iddialar': ['i-b99-001']},
            {'metin': List.filled(23, 'kelime').join(' '), 'iddialar': []},
          ],
          'gorsel': {
            'tarif': 'deneme',
            'saat': 'gece',
            'kamera': 'yavas-yaklasma',
            'katmanlar': [
              {'id': 'gok', 'yerTutucu': 'gok', 'derinlik': 0},
              {'id': 'nur', 'yerTutucu': 'nur', 'derinlik': 0.6},
            ],
          },
        },
        {
          'id': 'b99-s02',
          'anlatim': [
            {'metin': 'son cümle', 'iddialar': []},
          ],
          'gorsel': {'tarif': '', 'kamera': 'sabit', 'katmanlar': []},
        },
      ],
      'iddialar': [
        {
          'id': 'i-b99-001',
          'kaynaklar': [
            {'eser': 'eser-a', 'konum': 's. 1', 'dogrulama': 'bekliyor'},
            {'eser': 'eser-a', 'konum': 's. 1', 'dogrulama': 'bekliyor'},
          ],
        },
      ],
    });
