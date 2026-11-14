import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../icerik/model.dart';

/// Katman görsellerini (WebP) arka planda yükler ve saklar.
///
/// [al] görsel hazır değilse `null` döner ve yüklemeyi başlatır; yükleme
/// bitince dinleyicilere haber verilir, sahne yeniden çizilir. O arada (ya da
/// dosya bulunamazsa) oynatıcı yer tutucuyu çizer.
class GorselOnbellek extends ChangeNotifier {
  GorselOnbellek({AssetBundle? paket}) : _paket = paket ?? rootBundle;

  /// Görseller dilden bağımsızdır: `content/gorseller/` → bu klasör.
  static const kok = 'assets/icerik/gorseller';

  final AssetBundle _paket;
  final _hazir = <String, ui.Image>{};
  final _yukleniyor = <String>{};
  final _bulunamadi = <String>{};
  bool _kapandi = false;

  ui.Image? al(String dosya) {
    if (dosya.isEmpty) return null;
    final gorsel = _hazir[dosya];
    if (gorsel == null && !_yukleniyor.contains(dosya) && !_bulunamadi.contains(dosya)) {
      _yukle(dosya);
    }
    return gorsel;
  }

  bool bulunamadi(String dosya) => _bulunamadi.contains(dosya);

  /// Sahneye girmeden önce bütün çekimlerinin görsellerini yüklemeye başlar;
  /// çekim değişince yer tutucu görünmesin.
  void onYukle(Sahne sahne) {
    for (final c in sahne.cekimler) {
      for (final k in c.katmanlar) {
        al(k.dosya);
      }
    }
  }

  Future<void> _yukle(String dosya) async {
    _yukleniyor.add(dosya);
    try {
      final veri = await _paket.load('$kok/$dosya');
      final codec = await ui.instantiateImageCodec(veri.buffer.asUint8List());
      final kare = await codec.getNextFrame();
      if (_kapandi) {
        kare.image.dispose();
        return;
      }
      _hazir[dosya] = kare.image;
      notifyListeners();
    } catch (hata) {
      _bulunamadi.add(dosya);
      debugPrint('Katman görseli yüklenemedi, yer tutucu çizilecek: $dosya ($hata)');
    } finally {
      _yukleniyor.remove(dosya);
    }
  }

  @override
  void dispose() {
    _kapandi = true;
    for (final g in _hazir.values) {
      g.dispose();
    }
    _hazir.clear();
    super.dispose();
  }
}
