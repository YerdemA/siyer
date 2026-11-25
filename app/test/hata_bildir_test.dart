import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/hata_bildir.dart';

void main() {
  test('uygulamaSurumu pubspec sürümüyle aynı', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final surum = RegExp(r'^version:\s*(\S+)', multiLine: true).firstMatch(pubspec)!.group(1);
    expect(uygulamaSurumu, surum);
  });

  test('hata bilgisi nerede görüldüğünü yazar', () {
    final b = hataBilgisi(dil: 'tr', bolum: 'b04-sut-anne', sahne: 'b04-s07', saniye: 125.7);
    expect(b, contains('Sürüm: $uygulamaSurumu'));
    expect(b, contains('Sahne: b04-s07'));
    expect(b, contains('Bölüm zamanı: 2:05'));
    expect(hataBilgisi(dil: 'en'), isNot(contains('Sahne')));
  });
}
