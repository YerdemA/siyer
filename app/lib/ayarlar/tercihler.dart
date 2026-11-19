import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Altyazı boyutu seçenekleri ve ölçekleri.
enum AltyaziBoyutu {
  kucuk(0.85),
  orta(1),
  buyuk(1.3);

  const AltyaziBoyutu(this.olcek);
  final double olcek;
}

/// Kullanıcı tercihleri; yalnız cihazda saklanır.
class Tercihler {
  const Tercihler({this.altyazi = AltyaziBoyutu.orta, this.efektSesleri = true, this.hareketiAzalt = false});

  final AltyaziBoyutu altyazi;
  final bool efektSesleri;

  /// Kart ve harita animasyonları kısalır (erişilebilirlik).
  final bool hareketiAzalt;

  Tercihler kopya({AltyaziBoyutu? altyazi, bool? efektSesleri, bool? hareketiAzalt}) => Tercihler(
        altyazi: altyazi ?? this.altyazi,
        efektSesleri: efektSesleri ?? this.efektSesleri,
        hareketiAzalt: hareketiAzalt ?? this.hareketiAzalt,
      );
}

class TercihDeposu extends AsyncNotifier<Tercihler> {
  static const _altyazi = 'tercih.altyazi';
  static const _efekt = 'tercih.efekt';
  static const _hareket = 'tercih.hareketiAzalt';

  @override
  Future<Tercihler> build() async {
    final p = await SharedPreferences.getInstance();
    return Tercihler(
      altyazi: AltyaziBoyutu.values.where((b) => b.name == p.getString(_altyazi)).firstOrNull ??
          AltyaziBoyutu.orta,
      efektSesleri: p.getBool(_efekt) ?? true,
      hareketiAzalt: p.getBool(_hareket) ?? false,
    );
  }

  Future<void> altyaziSec(AltyaziBoyutu b) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(altyazi: b));
    await (await SharedPreferences.getInstance()).setString(_altyazi, b.name);
  }

  Future<void> efektSesleriSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(efektSesleri: acik));
    await (await SharedPreferences.getInstance()).setBool(_efekt, acik);
  }

  Future<void> hareketiAzaltSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(hareketiAzalt: acik));
    await (await SharedPreferences.getInstance()).setBool(_hareket, acik);
  }
}

/// Hareket azaltılsın mı: Ayarlar'daki seçenek ya da telefonun
/// "animasyonları kaldır" erişilebilirlik ayarı.
bool hareketAz(BuildContext context, WidgetRef ref) =>
    (ref.watch(tercihlerProvider).value?.hareketiAzalt ?? false) || MediaQuery.disableAnimationsOf(context);

final tercihlerProvider = AsyncNotifierProvider<TercihDeposu, Tercihler>(TercihDeposu.new);

/// Arayüzün kısa efekt sesleri (`app/assets/sesler/`, tools/efekt_sesleri.py).
abstract class EfektSesi {
  /// [ad]: `kalem` (çarpı) ya da `parsomen` (harita).
  Future<void> cal(String ad);
  Future<void> kapat();
}

class JustAudioEfekt implements EfektSesi {
  AudioPlayer? _oynatici;

  @override
  Future<void> cal(String ad) async {
    try {
      final o = _oynatici ??= AudioPlayer();
      await o.setAsset('assets/sesler/$ad.wav');
      await o.play();
    } catch (_) {
      // Ses çalınamazsa (testte eklenti yok, cihazda sessiz) görünüm etkilenmez.
    }
  }

  @override
  Future<void> kapat() async {
    try {
      await _oynatici?.dispose();
    } catch (_) {}
  }
}

final efektSesiProvider = Provider<EfektSesi>((ref) {
  final s = JustAudioEfekt();
  ref.onDispose(s.kapat);
  return s;
});

/// Tercih açıksa efekt sesini çalar.
void efektCal(Ref ref, String ad) {
  if (ref.read(tercihlerProvider).value?.efektSesleri ?? true) {
    ref.read(efektSesiProvider).cal(ad);
  }
}

/// Bir sesin çalınıp çalınmayacağını ve neyin çalınacağını widget'tan bildirir.
final efektCalProvider = Provider<void Function(String ad)>((ref) => (ad) => efektCal(ref, ad));
