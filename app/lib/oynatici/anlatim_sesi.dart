import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../icerik/depo.dart';

/// Sahne başına bir anlatım sesi dosyası. Ses çalarken saat sese uyar,
/// sessizlikte kendi işler (bkz. `_OynaticiState._tik`). Testlerde sahtesi kullanılır.
abstract class AnlatimSesi {
  /// Dosyanın süresi; bulunamaz ya da okunamazsa null.
  Future<Duration?> sure(String dosya);

  /// [dosya]yı (gerekirse yükleyip) [konum]dan çalmaya başlar.
  Future<void> cal(String dosya, Duration konum);

  /// Çalan dosyada konum değiştirir.
  Future<void> ara(Duration konum);

  /// [dosya]yı çalmadan yükler; sıradaki ses başlarken bekleme olmasın diye.
  Future<void> hazirla(String dosya);

  Future<void> duraklat();

  String? get etkinDosya;

  /// Çalma istendi mi (yükleniyor olsa da).
  bool get caliyor;

  /// Ses gerçekten akıyor mu (yükleme/tamponlama bitti). Değilse saat bekler.
  bool get hazir;

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

  /// Yüklenemeyen dosyalar; her karede yeniden denenmesin.
  final _bozuk = <String>{};

  Future<bool> _yukle(String dosya) async {
    if (_etkin == dosya) return true;
    if (_bozuk.contains(dosya)) return false;
    try {
      await _oynatici.setAsset('$kok/$dosya');
      _etkin = dosya;
      return true;
    } catch (hata) {
      _bozuk.add(dosya);
      _etkin = null;
      debugPrint('Anlatım sesi yüklenemedi: $dosya ($hata)');
      return false;
    }
  }

  @override
  Future<void> cal(String dosya, Duration konum) async {
    if (!await _yukle(dosya)) return;
    // Hazırlanmış dosya zaten baştadır; gereksiz arama sesi kesik başlatır.
    if ((_oynatici.position - konum).inMilliseconds.abs() > 150) await _oynatici.seek(konum);
    // play() çalma bitene kadar tamamlanmaz; beklenmez.
    unawaited(_oynatici.play());
  }

  @override
  Future<void> hazirla(String dosya) async {
    if (_oynatici.playing) await _oynatici.pause();
    await _yukle(dosya);
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
  bool get hazir => switch (_oynatici.processingState) {
        ProcessingState.ready || ProcessingState.completed => true,
        _ => false,
      };

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
  // Yalnız pakette olan dosyalar denenir: eksik dosyayı denemek platforma göre
  // saniyeler sürebilir ve bölüm açılışını bekletir.
  final varliklar = await ref.watch(varliklarProvider.future);
  final sahneler = [
    for (final s in bolum.sahneler)
      if (s.sesAnlatim.isNotEmpty && varliklar.contains('$icerikKoku/ses/${s.sesAnlatim}')) s,
  ];
  final sonuc = <String, double>{};
  if (sahneler.isEmpty) return sonuc;
  final ses = ref.read(anlatimSesiFabrikasi)();
  try {
    for (final s in sahneler) {
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

class SesHazirla extends SesKarari {
  const SesHazirla(this.dosya);
  final String dosya;
}

/// Ses çalarken saat sese uyar (bkz. `_OynaticiState._tik`); kayma yalnız
/// kullanıcı kaydırınca ya da sahne atlayınca olur ve o zaman ses yeniden
/// konumlanır. [sesKonumu]: sahnenin sesi içindeki konum (saniye), ses
/// dışındaysa (sahne başı/sonu sessizliği, sessiz sahne) null. Sessizlikte
/// [siradaki] (sıradaki sesli dosya) önceden yüklenir.
SesKarari sesKarari({
  required bool oynuyor,
  required String dosya,
  required double? sesKonumu,
  required String? etkinDosya,
  required bool caliyor,
  required Duration konum,
  bool hazir = true,
  String? siradaki,
  int kaymaSiniriMs = 400,
}) {
  if (!oynuyor || sesKonumu == null) {
    if (caliyor) return const SesDuraklat();
    if (siradaki != null && siradaki != etkinDosya) return SesHazirla(siradaki);
    return const SesBekle();
  }
  final hedef = Duration(microseconds: (sesKonumu * 1e6).round());
  if (etkinDosya != dosya || !caliyor) return SesCal(dosya, hedef);
  // Yüklenirken/tamponlarken konum güvenilmez; aramak döngüye sokar.
  if (!hazir) return const SesBekle();
  if ((konum - hedef).inMilliseconds.abs() > kaymaSiniriMs) return SesAra(hedef);
  return const SesBekle();
}
