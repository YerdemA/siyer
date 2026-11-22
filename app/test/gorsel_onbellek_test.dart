import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/oynatici/gorsel_onbellek.dart';

/// 1×1 PNG. Codec biçimden bağımsız olduğundan WebP ile aynı yolu izler.
final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

class _SahtePaket extends CachingAssetBundle {
  final yuklenen = <String>[];

  @override
  Future<ByteData> load(String key) async {
    yuklenen.add(key);
    if (key.endsWith('var.webp') || key.endsWith('-a.webp') || key.endsWith('-b.webp')) return ByteData.sublistView(Uint8List.fromList(_png));
    throw FlutterError('yok: $key');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('görsel ilk istekte yüklenir, bitince haber verilir', () async {
    final paket = _SahtePaket();
    final onbellek = GorselOnbellek(paket: paket);
    var haber = 0;
    final hazir = Completer<void>();
    onbellek.addListener(() {
      haber++;
      if (!hazir.isCompleted) hazir.complete();
    });

    expect(onbellek.al('var.webp'), isNull, reason: 'henüz yüklenmedi');
    // Görsel çözme motorda gerçek zamanlı sürer; olay kuyruğunu boşaltmak
    // yük altında yetmiyordu (aralıklı düşen test). Bildirim beklenir.
    await hazir.future.timeout(const Duration(seconds: 10));
    expect(onbellek.al('var.webp'), isNotNull);
    expect(haber, 1);
    expect(paket.yuklenen, ['${GorselOnbellek.kok}/var.webp'], reason: 'bir kez yüklenir');
    onbellek.dispose();
  });

  test('bulunamayan görsel bir kez denenir, sonra yer tutucuya kalır', () async {
    final paket = _SahtePaket();
    final onbellek = GorselOnbellek(paket: paket);
    expect(onbellek.al('yok.webp'), isNull);
    await pumpEventQueue();
    expect(onbellek.al('yok.webp'), isNull);
    expect(onbellek.bulunamadi('yok.webp'), isTrue);
    expect(paket.yuklenen, hasLength(1));
    onbellek.dispose();
  });

  test('boş dosya adı hiç yüklenmez', () {
    final paket = _SahtePaket();
    final onbellek = GorselOnbellek(paket: paket);
    expect(onbellek.al(''), isNull);
    expect(paket.yuklenen, isEmpty);
    onbellek.dispose();
  });

  test('sinirla yakın sahnelerin dışındaki görselleri bellekten atar', () async {
    Sahne sahne(String dosya) => Sahne.fromJson({
          'id': dosya,
          'anlatim': [],
          'gorsel': {
            'tarif': '',
            'kamera': 'sabit',
            'katmanlar': [
              {'id': 'k', 'dosya': dosya, 'derinlik': 0},
            ],
          },
        });
    final a = sahne('s-a.webp');
    final b = sahne('s-b.webp');
    final onbellek = GorselOnbellek(paket: _SahtePaket());
    var bekleyen = 2;
    final hazir = Completer<void>();
    onbellek.addListener(() {
      if (--bekleyen == 0) hazir.complete();
    });
    onbellek
      ..onYukle(a)
      ..onYukle(b);
    await hazir.future.timeout(const Duration(seconds: 10));
    expect(onbellek.bellektekiler, unorderedEquals(['s-a.webp', 's-b.webp']));

    onbellek.sinirla([b]);
    expect(onbellek.bellektekiler, ['s-b.webp']);
    expect(onbellek.al('s-a.webp'), isNull, reason: 'yeniden istenince baştan yüklenir');
    onbellek.dispose();
  });

  test('okuyucu verilince baytlar ondan okunur', () async {
    final okunan = <String>[];
    final onbellek = GorselOnbellek(okuyucu: (d) async {
      okunan.add(d);
      return Uint8List.fromList(_png);
    });
    final hazir = Completer<void>();
    onbellek.addListener(() => hazir.complete());
    onbellek.al('paket.webp');
    await hazir.future.timeout(const Duration(seconds: 10));
    expect(okunan, ['paket.webp']);
    expect(onbellek.al('paket.webp'), isNotNull);
    onbellek.dispose();
  });
}
