import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Oynatıcının ekranla ilgili platform istekleri (Android: MainActivity).
/// Platform yoksa (testler, web) sessizce hiçbir şey yapmaz.
class Ekran {
  const Ekran();

  static const _kanal = MethodChannel('siyer/ekran');

  /// Ekran açık mı? Uygulama gizlenince "ekran mı kapandı, başka uygulamaya
  /// mı geçildi" ayrımı için. Bilinemezse true (oynatma durur).
  Future<bool> acikMi() async {
    try {
      return await _kanal.invokeMethod<bool>('ekranAcik') ?? true;
    } on MissingPluginException {
      return true;
    } catch (hata) {
      debugPrint('Ekran durumu okunamadı: $hata');
      return true;
    }
  }

  /// Bölüm oynarken ekran kendiliğinden kararmasın.
  Future<void> acikTut(bool acik) => _cagir('acikTut', acik);

  /// Ekran kapalıyken bölüm sürerken işlemci uyumasın.
  Future<void> uyanikTut(bool acik) => _cagir('uyanikTut', acik);

  Future<void> _cagir(String yontem, bool deger) async {
    try {
      await _kanal.invokeMethod<void>(yontem, deger);
    } on MissingPluginException {
      // Platform karşılığı yok.
    } catch (hata) {
      debugPrint('Ekran isteği başarısız ($yontem): $hata');
    }
  }
}
