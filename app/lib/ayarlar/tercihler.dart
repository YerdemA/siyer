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

/// Seçilebilen altyazı dilleri.
const altyaziDilleri = ['tr', 'en'];

/// Oynatıcıdaki hız düğmesinin sırayla geçtiği hızlar.
const oynatmaHizlari = [1.0, 1.5, 2.0];

/// Kullanıcı tercihleri; yalnız cihazda saklanır.
class Tercihler {
  const Tercihler({
    this.altyazi = AltyaziBoyutu.orta,
    this.altyaziAcik = false,
    this.altyaziDili = 'tr',
    this.efektSesleri = true,
    this.fonSesi = true,
    this.hareketiAzalt = false,
    this.hiz = 1,
  });

  final AltyaziBoyutu altyazi;

  /// Sesli sahnelerde altyazı. Varsayılan kapalı: animasyonu örtmesin
  /// (Erdem, 2026-11-21). Sesi olmayan sahnede metin her zaman görünür.
  final bool altyaziAcik;

  /// Altyazının dili (`tr`, `en`); anlatım sesi her zaman Türkçe.
  final String altyaziDili;
  final bool efektSesleri;

  /// Bölümlerde fon müziği ve ortam sesi.
  final bool fonSesi;

  /// Kart ve harita animasyonları kısalır (erişilebilirlik).
  final bool hareketiAzalt;

  /// Oynatma hızı; [oynatmaHizlari]'ndan biri.
  final double hiz;

  Tercihler kopya({
    AltyaziBoyutu? altyazi,
    bool? altyaziAcik,
    String? altyaziDili,
    bool? efektSesleri,
    bool? fonSesi,
    bool? hareketiAzalt,
    double? hiz,
  }) =>
      Tercihler(
        altyazi: altyazi ?? this.altyazi,
        altyaziAcik: altyaziAcik ?? this.altyaziAcik,
        altyaziDili: altyaziDili ?? this.altyaziDili,
        efektSesleri: efektSesleri ?? this.efektSesleri,
        fonSesi: fonSesi ?? this.fonSesi,
        hareketiAzalt: hareketiAzalt ?? this.hareketiAzalt,
        hiz: hiz ?? this.hiz,
      );
}

class TercihDeposu extends AsyncNotifier<Tercihler> {
  static const _altyazi = 'tercih.altyazi';
  static const _altyaziAcik = 'tercih.altyaziAcik';
  static const _altyaziDili = 'tercih.altyaziDili';
  static const _efekt = 'tercih.efekt';
  static const _fon = 'tercih.fonSesi';
  static const _hareket = 'tercih.hareketiAzalt';
  static const _hiz = 'tercih.hiz';

  @override
  Future<Tercihler> build() async {
    final p = await SharedPreferences.getInstance();
    return Tercihler(
      altyazi: AltyaziBoyutu.values.where((b) => b.name == p.getString(_altyazi)).firstOrNull ?? AltyaziBoyutu.orta,
      altyaziAcik: p.getBool(_altyaziAcik) ?? false,
      altyaziDili: altyaziDilleri.contains(p.getString(_altyaziDili)) ? p.getString(_altyaziDili)! : 'tr',
      efektSesleri: p.getBool(_efekt) ?? true,
      fonSesi: p.getBool(_fon) ?? true,
      hareketiAzalt: p.getBool(_hareket) ?? false,
      hiz: oynatmaHizlari.contains(p.getDouble(_hiz)) ? p.getDouble(_hiz)! : 1,
    );
  }

  Future<void> altyaziSec(AltyaziBoyutu b) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(altyazi: b));
    await (await SharedPreferences.getInstance()).setString(_altyazi, b.name);
  }

  Future<void> altyaziAcikSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(altyaziAcik: acik));
    await (await SharedPreferences.getInstance()).setBool(_altyaziAcik, acik);
  }

  Future<void> altyaziDiliSec(String dil) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(altyaziDili: dil));
    await (await SharedPreferences.getInstance()).setString(_altyaziDili, dil);
  }

  Future<void> efektSesleriSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(efektSesleri: acik));
    await (await SharedPreferences.getInstance()).setBool(_efekt, acik);
  }

  Future<void> fonSesiSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(fonSesi: acik));
    await (await SharedPreferences.getInstance()).setBool(_fon, acik);
  }

  Future<void> hareketiAzaltSec(bool acik) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(hareketiAzalt: acik));
    await (await SharedPreferences.getInstance()).setBool(_hareket, acik);
  }

  Future<void> hizSec(double hiz) async {
    state = AsyncData((state.value ?? const Tercihler()).kopya(hiz: hiz));
    await (await SharedPreferences.getInstance()).setDouble(_hiz, hiz);
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
final efektCalProvider = Provider<void Function(String ad)>(
  (ref) =>
      (ad) => efektCal(ref, ad),
);
