import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bir bölümde kalınan yer. Hesap ve sunucu yok; yalnız cihazda saklanır.
class BolumIlerlemesi {
  const BolumIlerlemesi({this.sonSahne = 1, this.bitti = false});

  factory BolumIlerlemesi.fromJson(Map<String, dynamic> j) => BolumIlerlemesi(
        sonSahne: (j['sahne'] as num?)?.toInt() ?? 1,
        bitti: j['bitti'] == true,
      );

  /// 1'den başlar.
  final int sonSahne;

  /// Bölüm bir kez sonuna kadar izlendi mi. Yeniden izlemek bunu silmez.
  final bool bitti;

  Map<String, dynamic> toJson() => {'sahne': sonSahne, 'bitti': bitti};

  BolumIlerlemesi kopya({int? sonSahne, bool? bitti}) =>
      BolumIlerlemesi(sonSahne: sonSahne ?? this.sonSahne, bitti: bitti ?? this.bitti);

  /// Bölüm açılınca başlanacak sahne: bitmemiş ve ilerlemiş bölüm kaldığı yerden.
  int get devamSahnesi => bitti ? 1 : sonSahne;

  @override
  bool operator ==(Object other) =>
      other is BolumIlerlemesi && other.sonSahne == sonSahne && other.bitti == bitti;

  @override
  int get hashCode => Object.hash(sonSahne, bitti);
}

/// Bölüm kimliğinden ilerlemeye. Anahtarlar `ilerleme.<bölüm id>`.
class IlerlemeDeposu extends AsyncNotifier<Map<String, BolumIlerlemesi>> {
  static const onek = 'ilerleme.';

  @override
  Future<Map<String, BolumIlerlemesi>> build() async {
    final p = await SharedPreferences.getInstance();
    final sonuc = <String, BolumIlerlemesi>{};
    for (final anahtar in p.getKeys().where((a) => a.startsWith(onek))) {
      final ham = p.getString(anahtar);
      if (ham == null) continue;
      try {
        sonuc[anahtar.substring(onek.length)] =
            BolumIlerlemesi.fromJson(jsonDecode(ham) as Map<String, dynamic>);
      } on FormatException {
        // Bozuk kayıt ilerlemeyi engellemesin; yok sayılır, ilk yazımda düzelir.
      }
    }
    return sonuc;
  }

  Future<void> sahneKaydet(String bolumId, int sahne) =>
      _guncelle(bolumId, (e) => e.kopya(sonSahne: sahne));

  Future<void> bitir(String bolumId) => _guncelle(bolumId, (e) => e.kopya(bitti: true));

  Future<void> _guncelle(String bolumId, BolumIlerlemesi Function(BolumIlerlemesi) f) async {
    final mevcut = state.value ?? await future;
    final eski = mevcut[bolumId] ?? const BolumIlerlemesi();
    final yeni = f(eski);
    if (yeni == eski && mevcut.containsKey(bolumId)) return;
    state = AsyncData({...mevcut, bolumId: yeni});
    final p = await SharedPreferences.getInstance();
    await p.setString('$onek$bolumId', jsonEncode(yeni.toJson()));
  }
}

final ilerlemeProvider =
    AsyncNotifierProvider<IlerlemeDeposu, Map<String, BolumIlerlemesi>>(IlerlemeDeposu.new);
