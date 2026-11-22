import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'depo.dart';

/// Bölüm paketleri: ilk bölüm dışındaki bölümlerin ses ve görselleri
/// uygulamayla gelmez, Google Play'den (Play Asset Delivery) isteğe bağlı
/// indirilir. Paketleri `tools/icerik_esitle.dart` hazırlar; Android tarafı
/// `android/app/src/main/kotlin/.../BolumPaketleri.kt`.

/// Uygulamayla gelen bölümler (paket adıyla); `tools/icerik_esitle.dart` ile aynı.
const gomuluPaketler = {'b01'};

/// Bölüm kimliğinden paket adı: `b02-fil-vakasi` → `b02`.
String paketAdi(String bolumId) => bolumId.split('-').first;

/// Bayt → "4,3" gibi MB metni.
String mbMetni(int bayt, String dilKodu) {
  final mb = (bayt / (1024 * 1024)).toStringAsFixed(1);
  return dilKodu == 'tr' ? mb.replaceAll('.', ',') : mb;
}

sealed class PaketDurumu {
  const PaketDurumu();
}

/// Durum henüz sorulmadı.
class PaketBilinmiyor extends PaketDurumu {
  const PaketBilinmiyor();
}

class PaketYok extends PaketDurumu {
  const PaketYok();
}

class PaketIniyor extends PaketDurumu {
  const PaketIniyor({this.inen = 0, this.toplam = 0});
  final int inen;
  final int toplam;

  /// 0–1; toplam bilinmiyorsa null.
  double? get oran => toplam > 0 ? (inen / toplam).clamp(0.0, 1.0) : null;
}

/// Wi-Fi bekleniyor ya da kullanıcı onayı isteniyor (büyük paketlerde).
class PaketBekliyor extends PaketDurumu {
  const PaketBekliyor();
}

class PaketHazir extends PaketDurumu {
  /// [yol] paket klasörü; uygulamaya gömülü bölümde null.
  const PaketHazir([this.yol]);
  final String? yol;
}

class PaketHatasi extends PaketDurumu {
  const PaketHatasi(this.mesaj);
  final String mesaj;
}

/// Yerel paket yöneticisiyle konuşan arayüz; testlerde sahtesi kullanılır.
abstract class PaketKanali {
  Future<PaketDurumu> durum(String ad);
  Future<PaketDurumu> indir(String ad);
  Future<PaketDurumu> sil(String ad);

  /// İndirme ilerlemesi: (paket adı, durum).
  Stream<(String, PaketDurumu)> get olaylar;
}

class PlatformPaketKanali implements PaketKanali {
  static const _kanal = MethodChannel('siyer/paketler');
  static const _olay = EventChannel('siyer/paketler/olay');

  Future<PaketDurumu> _cagir(String yontem, String ad) async {
    if (!Platform.isAndroid) return const PaketHatasi('Bu platformda bölüm indirme henüz yok.');
    try {
      final c = await _kanal.invokeMapMethod<String, Object?>(yontem, {'ad': ad});
      return c == null ? const PaketHatasi('boş yanıt') : _coz(c);
    } on PlatformException catch (e) {
      return PaketHatasi(e.message ?? e.code);
    } on MissingPluginException {
      return const PaketHatasi('Paket yöneticisi bulunamadı.');
    }
  }

  static PaketDurumu _coz(Map<Object?, Object?> c) => switch (c['durum']) {
        'hazir' => PaketHazir(c['yol'] as String?),
        'iniyor' => PaketIniyor(inen: (c['inen'] as num?)?.toInt() ?? 0, toplam: (c['toplam'] as num?)?.toInt() ?? 0),
        'bekliyor' || 'onay' => const PaketBekliyor(),
        'hata' => PaketHatasi((c['hata'] as String?) ?? 'bilinmeyen hata'),
        _ => const PaketYok(),
      };

  @override
  Future<PaketDurumu> durum(String ad) => _cagir('durum', ad);

  @override
  Future<PaketDurumu> indir(String ad) => _cagir('indir', ad);

  @override
  Future<PaketDurumu> sil(String ad) => _cagir('sil', ad);

  @override
  Stream<(String, PaketDurumu)> get olaylar => Platform.isAndroid
      ? _olay.receiveBroadcastStream().map((e) {
          final c = e as Map<Object?, Object?>;
          return ((c['ad'] as String?) ?? '', _coz(c));
        })
      : const Stream.empty();
}

final paketKanaliProvider = Provider<PaketKanali>((ref) => PlatformPaketKanali());

/// Paket adı → durum. Gömülü bölümler burada tutulmaz.
class PaketDurumlari extends Notifier<Map<String, PaketDurumu>> {
  StreamSubscription<(String, PaketDurumu)>? _abone;

  @override
  Map<String, PaketDurumu> build() {
    final kanal = ref.watch(paketKanaliProvider);
    _abone = kanal.olaylar.listen((o) {
      final (ad, d) = o;
      if (ad.isNotEmpty) _yaz(ad, d);
    });
    ref.onDispose(() => _abone?.cancel());
    return const {};
  }

  void _yaz(String ad, PaketDurumu d) => state = {...state, ad: d};

  /// Durumu henüz bilinmeyen paketi sorar.
  Future<void> sor(String ad) async {
    if (gomuluPaketler.contains(ad) || state.containsKey(ad)) return;
    _yaz(ad, const PaketBilinmiyor());
    _yaz(ad, await ref.read(paketKanaliProvider).durum(ad));
  }

  Future<void> indir(String ad) async {
    if (gomuluPaketler.contains(ad)) return;
    if (state[ad] case PaketHazir() || PaketIniyor()) return;
    _yaz(ad, const PaketIniyor());
    final d = await ref.read(paketKanaliProvider).indir(ad);
    // İlerleme olayları bu arada daha yeni bir durum yazmış olabilir.
    if (d is! PaketIniyor || state[ad] is! PaketHazir) _yaz(ad, d);
  }

  Future<void> sil(String ad) async {
    if (gomuluPaketler.contains(ad)) return;
    _yaz(ad, await ref.read(paketKanaliProvider).sil(ad));
  }
}

final paketDurumlariProvider =
    NotifierProvider<PaketDurumlari, Map<String, PaketDurumu>>(PaketDurumlari.new);

/// Bölümün paket durumu; bilinmiyorsa sorar.
final paketDurumuProvider = Provider.family<PaketDurumu, String>((ref, bolumId) {
  final ad = paketAdi(bolumId);
  if (gomuluPaketler.contains(ad)) return const PaketHazir();
  final d = ref.watch(paketDurumlariProvider)[ad];
  if (d == null) {
    Future.microtask(() {
      if (ref.mounted) ref.read(paketDurumlariProvider.notifier).sor(ad);
    });
    return const PaketBilinmiyor();
  }
  return d;
});

/// Paket adı → bayt (indirme boyutu), `tools/icerik_esitle.dart` yazar.
final paketBoyutlariProvider = FutureProvider<Map<String, int>>((ref) async {
  try {
    final j = jsonDecode(await rootBundle.loadString('assets/icerik/paketler.json')) as Map<String, dynamic>;
    return {for (final e in j.entries) e.key: (e.value as num).toInt()};
  } catch (_) {
    return const {};
  }
});

/// Bir bölümün ses ve görsellerinin nerede olduğunu bilir: önce uygulamaya
/// gömülü varlıklara, yoksa indirilmiş paket klasörüne bakar. Yollar
/// `assets/icerik/`e göredir (`gorseller/x.webp`, `tr/ses/x.m4a`).
class BolumDosyalari {
  const BolumDosyalari({required this.varliklar, this.paketYolu, this.paketDosyalari = const {}});

  /// Uygulamaya gömülü bütün varlık yolları.
  final Set<String> varliklar;
  final String? paketYolu;

  /// Paketteki dosyalar, paket köküne göre.
  final Set<String> paketDosyalari;

  static const _kok = 'assets/icerik';

  bool gomulu(String goreli) => varliklar.contains('$_kok/$goreli');
  bool bulunur(String goreli) => gomulu(goreli) || paketDosyalari.contains(goreli);

  String varlikYolu(String goreli) => '$_kok/$goreli';
  String? dosyaYolu(String goreli) =>
      paketYolu != null && paketDosyalari.contains(goreli) ? '$paketYolu/$goreli' : null;

  Future<Uint8List> oku(String goreli) async {
    if (gomulu(goreli)) {
      final v = await rootBundle.load(varlikYolu(goreli));
      return v.buffer.asUint8List(v.offsetInBytes, v.lengthInBytes);
    }
    final yol = dosyaYolu(goreli);
    if (yol == null) throw FlutterError('Dosya ne uygulamada ne pakette: $goreli');
    return File(yol).readAsBytes();
  }
}

/// Bölüm açılırken bir kez kurulur; paket hazır değilse yalnız gömülü dosyaları görür.
final bolumDosyalariProvider = FutureProvider.autoDispose.family<BolumDosyalari, String>((ref, bolumId) async {
  final varliklar = await ref.watch(varliklarProvider.future);
  final paket = ref.watch(paketDurumuProvider(bolumId));
  final yol = paket is PaketHazir ? paket.yol : null;
  if (yol == null) return BolumDosyalari(varliklar: varliklar);
  final kok = Directory(yol);
  final dosyalar = await kok.exists()
      ? {
          await for (final f in kok.list(recursive: true))
            if (f is File) f.path.substring(kok.path.length + 1).replaceAll(r'\', '/'),
        }
      : <String>{};
  return BolumDosyalari(varliklar: varliklar, paketYolu: yol, paketDosyalari: dosyalar);
});
