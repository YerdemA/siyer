import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';

/// Şimdilik içerik uygulamayla paketlenir; bölüm indirme geldiğinde yalnız
/// bu dosya değişir.
/// Dil şimdilik sabit; İngilizce gelince bu seçilebilir olur.
const icerikKoku = 'assets/icerik/tr';
const _kok = icerikKoku;

Future<Map<String, dynamic>> _json(String yol) async =>
    jsonDecode(await rootBundle.loadString(yol)) as Map<String, dynamic>;

final bolumProvider = FutureProvider.family<Bolum, String>(
  (ref, id) async => Bolum.fromJson(await _json('$_kok/bolumler/$id.json')),
);

/// Uygulamaya paketlenmiş bütün dosya yolları.
final varliklarProvider = FutureProvider<Set<String>>((ref) async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  return manifest.listAssets().toSet();
});

/// Sıraya dizilmiş bölümler (adı `_` ile başlayan şablonlar hariç).
final bolumListesiProvider = FutureProvider<List<Bolum>>((ref) async {
  final yollar = (await ref.watch(varliklarProvider.future))
      .where((y) => y.startsWith('$_kok/bolumler/') && y.endsWith('.json'))
      .where((y) => !y.split('/').last.startsWith('_'));
  final bolumler = [for (final y in yollar) Bolum.fromJson(await _json(y))]
    ..sort((a, b) => a.sira.compareTo(b.sira));
  return bolumler;
});

Future<List<Map<String, dynamic>>> _liste(String yol) async =>
    (jsonDecode(await rootBundle.loadString(yol)) as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .toList();

final kaynakcaProvider = FutureProvider<Map<String, Eser>>((ref) async {
  return {
    for (final j in await _liste('$_kok/kaynakca.json')) (j['id'] as String? ?? ''): Eser.fromJson(j),
  };
});

final sahislarProvider = FutureProvider<List<Sahis>>(
  (ref) async => (await _liste('$_kok/sahislar.json')).map(Sahis.fromJson).toList(),
);

final yerlerProvider = FutureProvider<List<Yer>>(
  (ref) async => (await _liste('$_kok/yerler.json')).map(Yer.fromJson).toList(),
);

/// Yıla göre sıralı.
final zamanCizelgesiProvider = FutureProvider<List<ZamanOlayi>>((ref) async {
  final l = (await _liste('$_kok/zaman-cizelgesi.json')).map(ZamanOlayi.fromJson).toList()
    ..sort((a, b) => a.yil.compareTo(b.yil));
  return l;
});

/// Bütün bölümlerdeki iddialar, kimliğe göre. Sözlük ve zaman çizelgesi
/// kayıtlarının atıfları buradan okunur.
final iddiaDiziniProvider = FutureProvider<Map<String, Iddia>>((ref) async {
  final bolumler = await ref.watch(bolumListesiProvider.future);
  return {for (final b in bolumler) for (final i in b.iddialar) i.id: i};
});
