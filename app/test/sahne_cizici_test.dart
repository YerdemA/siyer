import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/oynatici/sahne_cizici.dart';

Katman _katman(Map<String, dynamic> ayar) => Katman.fromJson({
      'id': 'kabe-alcak',
      'dosya': 'kabe-alcak.webp',
      'yerTutucu': 'kabe-alcak',
      'derinlik': 0.5,
      'ayar': ayar,
    });

void main() {
  const ekran = Size(1600, 900);

  test('ayar.gorsel yoksa görsel kadraj ve taşma payını kaplar', () {
    final alan = SahneCizici.gorselAlani(_katman({}), ekran, 16 / 9);
    expect(alan.left, closeTo(-160, 0.001));
    expect(alan.top, closeTo(-90, 0.001));
    expect(alan.right, closeTo(1760, 0.001));
    expect(alan.bottom, closeTo(990, 0.001));
  });

  test('yer tutucu ayarları görsel yerleşimini etkilemez', () {
    // `olcek` yer tutucunun ayarıdır; görsel için `gorsel.olcek` okunur.
    final alan = SahneCizici.gorselAlani(_katman({'olcek': 1.6}), ekran, 16 / 9);
    expect(alan.width, closeTo(1920, 0.001));
  });

  test('ayar.gorsel merkez, genişlik ve görsel oranıyla yerleşir', () {
    final k = _katman({
      'gorsel': {'x': 0.5, 'y': 0.6, 'olcek': 0.25},
    });
    final alan = SahneCizici.gorselAlani(k, ekran, 16 / 9);
    expect(alan.center.dx, closeTo(800, 0.001));
    expect(alan.center.dy, closeTo(540, 0.001));
    expect(alan.width, closeTo(400, 0.001));
    expect(alan.height, closeTo(225, 0.001));
  });
}
