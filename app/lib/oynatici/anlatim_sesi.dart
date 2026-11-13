import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../icerik/depo.dart';

/// Sahne başına bir anlatım sesi dosyası. Oynatıcının saati asıl saattir;
/// ses ona uyar (bkz. `_OynaticiState._sesiEsitle`). Testlerde sahtesi kullanılır.
abstract class AnlatimSesi {
  /// Dosyanın süresi; bulunamaz ya da okunamazsa null.
  Future<Duration?> sure(String dosya);

  /// [dosya]yı (gerekirse yükleyip) [konum]dan çalmaya başlar.
  Future<void> cal(String dosya, Duration konum);

  /// Çalan dosyada konum değiştirir.
  Future<void> ara(Duration konum);

  Future<void> duraklat();

  String? get etkinDosya;
  bool get caliyor;
  Duration get konum;

  Future<void> kapat();
}

class JustAudioSesi implements AnlatimSesi {
  JustAudioSesi({this.kok = '$icerikKoku/ses'});

  final String kok;
  final _oynatici = AudioPlayer();
  String? _etkin;

  @override
  Future<Duration?> sure(String dosya) async {
    try {
      // Yükleme süresi okur; dosya bir sonraki çalışta yeniden yüklenir.
      final d = await _oynatici.setAsset('$kok/$dosya').timeout(const Duration(seconds: 5));
      _etkin = dosya;
      return d;
    } catch (hata) {
      debugPrint('Anlatım sesi okunamadı, süre metinden tahmin edilecek: $dosya ($hata)');
      _etkin = null;
      return null;
    }
  }

  @override
  Future<void> cal(String dosya, Duration konum) async {
    if (_etkin != dosya) {
      await _oynatici.setAsset('$kok/$dosya');
      _etkin = dosya;
    }
    await _oynatici.seek(konum);
    // play() çalma bitene kadar tamamlanmaz; beklenmez.
    unawaited(_oynatici.play());
  }

  @override
  Future<void> ara(Duration konum) => _oynatici.seek(konum);

  @override
  Future<void> duraklat() => _oynatici.pause();

  @override
  String? get etkinDosya => _etkin;

  @override
  bool get caliyor => _oynatici.playing;

  @override
  Duration get konum => _oynatici.position;

  @override
  Future<void> kapat() => _oynatici.dispose();
}

/// Testlerde sahte ses vermek için ezilir.
final anlatimSesiFabrikasi = Provider<AnlatimSesi Function()>((ref) => JustAudioSesi.new);

/// Bölümdeki anlatım seslerinin süreleri (sahne kimliği → saniye). Bölüm
/// açılınca bir kez okunur; zaman planı bu sürelerle kurulur.
final sesSureleriProvider =
    FutureProvider.autoDispose.family<Map<String, double>, String>((ref, bolumId) async {
  final bolum = await ref.watch(bolumProvider(bolumId).future);
  final ses = ref.read(anlatimSesiFabrikasi)();
  final sonuc = <String, double>{};
  try {
    for (final s in bolum.sahneler) {
      if (s.sesAnlatim.isEmpty) continue;
      final d = await ses.sure(s.sesAnlatim);
      if (d != null && d > Duration.zero) sonuc[s.id] = d.inMicroseconds / 1e6;
    }
  } finally {
    await ses.kapat();
  }
  return sonuc;
});

/// Bir karede sese ne yapılacağı.
sealed class SesKarari {
  const SesKarari();
}

class SesBekle extends SesKarari {
  const SesBekle();
}

class SesDuraklat extends SesKarari {
  const SesDuraklat();
}

class SesCal extends SesKarari {
  const SesCal(this.dosya, this.konum);
  final String dosya;
  final Duration konum;
}

class SesAra extends SesKarari {
  const SesAra(this.konum);
  final Duration konum;
}

/// Saat asıl, ses ona uyar. [sesKonumu]: sahnenin sesi içindeki konum (saniye),
/// ses dışındaysa (sahne başı/sonu sessizliği, sessiz sahne) null.
SesKarari sesKarari({
  required bool oynuyor,
  required String dosya,
  required double? sesKonumu,
  required String? etkinDosya,
  required bool caliyor,
  required Duration konum,
  int kaymaSiniriMs = 200,
}) {
  if (!oynuyor || sesKonumu == null) return caliyor ? const SesDuraklat() : const SesBekle();
  final hedef = Duration(microseconds: (sesKonumu * 1e6).round());
  if (etkinDosya != dosya || !caliyor) return SesCal(dosya, hedef);
  if ((konum - hedef).inMilliseconds.abs() > kaymaSiniriMs) return SesAra(hedef);
  return const SesBekle();
}
