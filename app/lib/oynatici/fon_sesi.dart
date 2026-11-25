import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

/// Anlatımın altında çalan fon müziği ve ortam sesi. Oynatıcı her karede
/// o anki sahnenin adlarını verir; ad değişince eski ses kısılarak biter,
/// yenisi açılarak başlar. Dosyası olmayan ad sessiz kalır.
abstract class FonSesi {
  /// [muzik], [ortam]: boş ya da null ise o kanal susar.
  void guncelle({required String? muzik, required String? ortam, required bool oynuyor});

  Future<void> kapat();
}

class SessizFon implements FonSesi {
  const SessizFon();

  @override
  void guncelle({required String? muzik, required String? ortam, required bool oynuyor}) {}

  @override
  Future<void> kapat() async {}
}

/// Kanalların ses düzeyi (anlatım 1). Anlatım rahat duyulsun diye kısık.
const muzikDuzeyi = 0.16;
const ortamDuzeyi = 0.32;

/// Uygulamaya gömülü fon dosyalarının yeri (`tools/icerik_esitle.dart`).
const fonKoku = 'assets/icerik/fon';

class JustAudioFon implements FonSesi {
  JustAudioFon() : _kanallar = [_Kanal('muzik', muzikDuzeyi), _Kanal('ortam', ortamDuzeyi)];

  final List<_Kanal> _kanallar;

  @override
  void guncelle({required String? muzik, required String? ortam, required bool oynuyor}) {
    _kanallar[0].guncelle(muzik, oynuyor);
    _kanallar[1].guncelle(ortam, oynuyor);
  }

  @override
  Future<void> kapat() async {
    for (final k in _kanallar) {
      await k.kapat();
    }
  }
}

/// Bir kanal: çalan ses ve (geçişteyse) sönen eski ses.
class _Kanal {
  _Kanal(this.klasor, this.duzey);

  final String klasor;
  final double duzey;

  _Calan? _calan;
  final _sonenler = <_Calan>[];
  bool _oynuyor = false;
  bool _kapandi = false;

  /// Yüklenemeyen adlar; her karede yeniden denenmesin.
  final _bozuk = <String>{};

  void guncelle(String? ad, bool oynuyor) {
    if (_kapandi) return;
    final hedef = (ad == null || ad.isEmpty || _bozuk.contains(ad)) ? null : ad;
    if (hedef != _calan?.ad) {
      final eski = _calan;
      if (eski != null) {
        _sonenler.add(eski);
        eski.son(() => _sonenler.remove(eski));
      }
      _calan = hedef == null ? null : _Calan(hedef, '$fonKoku/$klasor/$hedef.mp3', duzey, () => _bozuk.add(hedef));
      _calan?.baslat(oynuyor);
    } else if (oynuyor != _oynuyor) {
      _calan?.oynat(oynuyor);
    }
    if (oynuyor != _oynuyor) {
      for (final s in _sonenler) {
        s.oynat(oynuyor);
      }
    }
    _oynuyor = oynuyor;
  }

  Future<void> kapat() async {
    _kapandi = true;
    final hepsi = [?_calan, ..._sonenler];
    _calan = null;
    _sonenler.clear();
    for (final c in hepsi) {
      await c.kapat();
    }
  }
}

/// Döngüde çalan tek bir fon dosyası; açılış ve kapanışı yumuşak.
class _Calan {
  _Calan(this.ad, this.varlik, this.duzey, this.bozuk);

  final String ad;
  final String varlik;
  final double duzey;
  final VoidCallback bozuk;

  static const gecis = Duration(milliseconds: 1800);
  static const _adim = Duration(milliseconds: 60);

  // Kesinti ve kulaklık oynatıcıda ele alınır (medya_karti.dart).
  final _oynatici = AudioPlayer(handleInterruptions: false, handleAudioSessionActivation: false);
  Timer? _zamanlayici;
  double _ses = 0;
  bool _hazir = false;
  bool _istenen = false;
  bool _bitti = false;

  Future<void> baslat(bool oynuyor) async {
    _istenen = oynuyor;
    try {
      await _oynatici.setAsset(varlik);
      await _oynatici.setLoopMode(LoopMode.one);
      await _oynatici.setVolume(0);
    } catch (hata) {
      debugPrint('Fon sesi yüklenemedi: $varlik ($hata)');
      bozuk();
      return;
    }
    if (_bitti) return;
    _hazir = true;
    if (_istenen) _ac();
  }

  void oynat(bool oynuyor) {
    _istenen = oynuyor;
    if (!_hazir) return;
    if (_bitti) {
      // Sönerken duraklatıldı: beklemeden kapan.
      if (!oynuyor) unawaited(kapat());
      return;
    }
    if (oynuyor) {
      _ac();
    } else {
      // Duraklatmada hemen sus: kullanıcı sessizlik bekler.
      _zamanlayici?.cancel();
      unawaited(_oynatici.pause());
    }
  }

  void _ac() {
    unawaited(_oynatici.play());
    _sur(duzey);
  }

  /// Sesi [gecis] içinde açar ya da kısarak durdurur; [bitince] kapandıktan sonra.
  void son(VoidCallback bitince) {
    _bitti = true;
    if (!_hazir || !_oynatici.playing) {
      unawaited(kapat().whenComplete(bitince));
      return;
    }
    _sur(0, bitince: () => unawaited(kapat().whenComplete(bitince)));
  }

  void _sur(double hedef, {VoidCallback? bitince}) {
    _zamanlayici?.cancel();
    final bas = _ses;
    final adimSayisi = (gecis.inMilliseconds / _adim.inMilliseconds).ceil();
    var i = 0;
    _zamanlayici = Timer.periodic(_adim, (t) {
      i++;
      final oran = i / adimSayisi;
      _ses = bas + (hedef - bas) * (oran >= 1 ? 1 : oran);
      unawaited(_oynatici.setVolume(_ses));
      if (oran >= 1) {
        t.cancel();
        bitince?.call();
      }
    });
  }

  Future<void> kapat() async {
    _bitti = true;
    _zamanlayici?.cancel();
    try {
      await _oynatici.dispose();
    } catch (_) {}
  }
}

/// Testlerde sessiz fon vermek için ezilir.
final fonSesiFabrikasi = Provider<FonSesi Function()>((ref) => JustAudioFon.new);
