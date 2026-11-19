import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bir bölümde kalınan yer. Hesap ve sunucu yok; yalnız cihazda saklanır.
class BolumIlerlemesi {
  const BolumIlerlemesi({this.sonSahne = 1, this.bitti = false, this.zaman = 0});

  factory BolumIlerlemesi.fromJson(Map<String, dynamic> j) => BolumIlerlemesi(
        sonSahne: (j['sahne'] as num?)?.toInt() ?? 1,
        bitti: j['bitti'] == true,
        zaman: (j['zaman'] as num?)?.toInt() ?? 0,
      );

  /// 1'den başlar.
  final int sonSahne;

  /// Bölüm bir kez sonuna kadar izlendi mi. Yeniden izlemek bunu silmez.
  final bool bitti;

  /// Son kaydın zamanı (Unix ms); "kaldığın yerden devam" kartı en son
  /// izlenen yarım bölümü buna göre seçer. Eski kayıtlarda 0.
  final int zaman;

  /// Yarım bırakılmış: başlanmış, ilk sahneyi geçmiş, bitmemiş.
  bool get yarim => !bitti && sonSahne > 1;

  Map<String, dynamic> toJson() => {'sahne': sonSahne, 'bitti': bitti, 'zaman': zaman};

  BolumIlerlemesi kopya({int? sonSahne, bool? bitti, int? zaman}) => BolumIlerlemesi(
        sonSahne: sonSahne ?? this.sonSahne,
        bitti: bitti ?? this.bitti,
        zaman: zaman ?? this.zaman,
      );

  /// Bölüm açılınca başlanacak sahne: bitmemiş ve ilerlemiş bölüm kaldığı yerden.
  int get devamSahnesi => bitti ? 1 : sonSahne;

  @override
  bool operator ==(Object other) =>
      other is BolumIlerlemesi && other.sonSahne == sonSahne && other.bitti == bitti && other.zaman == zaman;

  @override
  int get hashCode => Object.hash(sonSahne, bitti, zaman);
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

  Future<void> sahneKaydet(String bolumId, int sahne) => _guncelle(
        bolumId,
        (e) => e.sonSahne == sahne ? e : e.kopya(sonSahne: sahne, zaman: DateTime.now().millisecondsSinceEpoch),
      );

  Future<void> bitir(String bolumId) => _guncelle(bolumId, (e) => e.kopya(bitti: true));

  /// Bütün bölümlerin ilerlemesini siler.
  Future<void> sifirla() async {
    final p = await SharedPreferences.getInstance();
    for (final a in p.getKeys().where((a) => a.startsWith(onek)).toList()) {
      await p.remove(a);
    }
    state = const AsyncData({});
  }

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

/// En son izlenen yarım bölümün kimliği; yoksa null.
String? sonYarimBolum(Map<String, BolumIlerlemesi> ilerleme) {
  String? secilen;
  var enGec = -1;
  for (final MapEntry(:key, :value) in ilerleme.entries) {
    if (value.yarim && value.zaman > enGec) {
      secilen = key;
      enGec = value.zaman;
    }
  }
  return secilen;
}
