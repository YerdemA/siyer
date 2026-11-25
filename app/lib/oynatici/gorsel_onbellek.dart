import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../icerik/model.dart';

/// Katman görsellerini (WebP) arka planda yükler ve saklar.
///
/// [al] görsel hazır değilse `null` döner ve yüklemeyi başlatır; yükleme
/// bitince dinleyicilere haber verilir, sahne yeniden çizilir. O arada (ya da
/// dosya bulunamazsa) oynatıcı yer tutucuyu çizer.
///
/// Çözülmüş bir katman yaklaşık 5 MB tutar (1536×864×4); bütün bölümü
/// bellekte tutmamak için [sinirla] yalnız yakın sahnelerin görsellerini bırakır.
///
/// [okuyucu] verilirse dosya baytları ondan okunur (indirilen bölüm paketleri);
/// verilmezse uygulamaya gömülü varlıklardan.
class GorselOnbellek extends ChangeNotifier {
  GorselOnbellek({AssetBundle? paket, this.okuyucu}) : _paket = paket ?? rootBundle;

  /// Görseller dilden bağımsızdır: `content/gorseller/` → bu klasör.
  static const kok = 'assets/icerik/gorseller';

  final AssetBundle _paket;
  final Future<Uint8List> Function(String dosya)? okuyucu;

  /// Tutulacak dosyalar; null ise hepsi tutulur.
  Set<String>? _tut;
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

  /// [sahneler]in görselleri dışındakileri bellekten atar; sonradan yine
  /// istenirse yeniden yüklenir.
  void sinirla(Iterable<Sahne> sahneler) {
    final tut = {
      for (final s in sahneler)
        for (final c in s.cekimler)
          for (final k in c.katmanlar) k.dosya,
    };
    _tut = tut;
    final atilacak = _hazir.keys.where((d) => !tut.contains(d)).toList();
    for (final d in atilacak) {
      _hazir.remove(d)!.dispose();
    }
  }

  /// Bellekte çözülmüş duran görseller (testler için).
  @visibleForTesting
  Iterable<String> get bellektekiler => _hazir.keys;

  Future<Uint8List> _oku(String dosya) async {
    final oku = okuyucu;
    if (oku != null) return oku(dosya);
    final veri = await _paket.load('$kok/$dosya');
    return veri.buffer.asUint8List(veri.offsetInBytes, veri.lengthInBytes);
  }

  Future<void> _yukle(String dosya) async {
    _yukleniyor.add(dosya);
    try {
      final codec = await ui.instantiateImageCodec(await _oku(dosya));
      final kare = await codec.getNextFrame();
      // Yüklenirken kapandıysa ya da sahne uzaklaştıysa tutulmaz.
      if (_kapandi || !(_tut?.contains(dosya) ?? true)) {
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
