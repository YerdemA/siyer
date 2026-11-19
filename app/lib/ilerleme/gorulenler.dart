import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import 'ilerleme.dart';

/// Hz. Muhammed'in (s.a.v.) sözlük kimliği; hiç bölüm izlenmemişken de görünür.
const efendimizId = 'hz-muhammed';

/// İzleyicinin şimdiye kadar gördüğü sahnelerde geçen şahıslar: bitirilen
/// bölümlerin bütün sahneleri, yarım kalanların kalınan sahneye kadarki
/// sahneleri. Böylece şahıslar sözlüğü bölümlerden önce bir şey açık etmez.
Set<String> gorulenSahislar(List<Bolum> bolumler, Map<String, BolumIlerlemesi> ilerleme) {
  final sonuc = {efendimizId};
  for (final b in bolumler) {
    final il = ilerleme[b.id];
    if (il == null) continue;
    final kac = il.bitti ? b.sahneler.length : il.sonSahne.clamp(0, b.sahneler.length);
    for (final s in b.sahneler.take(kac)) {
      sonuc.addAll(s.sahislar);
    }
  }
  return sonuc;
}

final gorulenSahislarProvider = Provider<Set<String>>((ref) {
  final bolumler = ref.watch(bolumListesiProvider).value ?? const <Bolum>[];
  final ilerleme = ref.watch(ilerlemeProvider).value ?? const {};
  return gorulenSahislar(bolumler, ilerleme);
});
