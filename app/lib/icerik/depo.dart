import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';

/// Şimdilik içerik uygulamayla paketlenir; bölüm indirme geldiğinde yalnız
/// bu dosya değişir.
const _kok = 'assets/icerik/tr';

Future<Map<String, dynamic>> _json(String yol) async =>
    jsonDecode(await rootBundle.loadString(yol)) as Map<String, dynamic>;

final bolumProvider = FutureProvider.family<Bolum, String>(
  (ref, id) async => Bolum.fromJson(await _json('$_kok/bolumler/$id.json')),
);

/// Sıraya dizilmiş bölümler (adı `_` ile başlayan şablonlar hariç).
final bolumListesiProvider = FutureProvider<List<Bolum>>((ref) async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final yollar = manifest
      .listAssets()
      .where((y) => y.startsWith('$_kok/bolumler/') && y.endsWith('.json'))
      .where((y) => !y.split('/').last.startsWith('_'));
  final bolumler = [for (final y in yollar) Bolum.fromJson(await _json(y))]
    ..sort((a, b) => a.sira.compareTo(b.sira));
  return bolumler;
});

final kaynakcaProvider = FutureProvider<Map<String, Eser>>((ref) async {
  final liste = jsonDecode(await rootBundle.loadString('$_kok/kaynakca.json'))
      as List<dynamic>;
  return {
    for (final j in liste.whereType<Map<String, dynamic>>())
      (j['id'] as String? ?? ''): Eser.fromJson(j),
  };
});
