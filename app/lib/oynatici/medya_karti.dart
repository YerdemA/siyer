import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kilit ekranındaki ve bildirim panelindeki medya kartından (ve kulaklık
/// tuşlarından) gelen istekler. Oynatıcı bunları kendi düğmeleri gibi uygular.
class MedyaKomutlari {
  const MedyaKomutlari({
    required this.oynat,
    required this.duraklat,
    required this.onceki,
    required this.sonraki,
    required this.git,
    required this.kapat,
  });

  final VoidCallback oynat;
  final VoidCallback duraklat;
  final VoidCallback onceki;
  final VoidCallback sonraki;

  /// Bölüm içinde saniye cinsinden konuma atlar.
  final ValueChanged<double> git;

  /// Kart kaydırılıp kapatıldı: oynatma durur, ilerleme kaydedilir.
  final VoidCallback kapat;
}

/// Kartta gösterilenler.
class MedyaDurumu {
  const MedyaDurumu({
    required this.kimlik,
    required this.baslik,
    required this.altBaslik,
    required this.toplam,
    required this.konum,
    required this.oynuyor,
    required this.hiz,
    this.kapak,
  });

  /// Bölüm ve sahne (ör. `b04-s07`); sahne değişince kart yenilenir.
  final String kimlik;
  final String baslik;

  /// Ör. "Sahne 7/10".
  final String altBaslik;
  final double toplam;
  final double konum;
  final bool oynuyor;
  final double hiz;

  /// Sahnenin kapak resmi (yerel PNG dosyası); yoksa uygulama simgesi.
  final Uri? kapak;
}

/// Bölüm açıkken sistemin medya oturumu: kilit ekranı/bildirim kartı,
/// kulaklık tuşları, ses odağı. Testlerde [SessizMedyaKarti] kullanılır.
abstract class MedyaKarti {
  /// Bölüm açılınca. [kanalAdi]: Android ayarlarında görünen bildirim kanalı adı.
  Future<void> baglan(MedyaKomutlari komutlar, {required String kanalAdi});

  void guncelle(MedyaDurumu durum);

  /// Kapak resmi çizilsin mi (sessiz kartta gereksiz iş).
  bool get kapakIster;

  /// Bölüm kapanınca: kart kaldırılır, ön plan servisi biter.
  Future<void> birak();
}

class SessizMedyaKarti implements MedyaKarti {
  const SessizMedyaKarti();

  @override
  Future<void> baglan(MedyaKomutlari komutlar, {required String kanalAdi}) async {}

  @override
  void guncelle(MedyaDurumu durum) {}

  @override
  bool get kapakIster => false;

  @override
  Future<void> birak() async {}
}

final medyaKartiProvider = Provider<MedyaKarti>((ref) => SistemMedyaKarti());

/// `audio_service` ile Android'in medya oturumu. Sesi çalan bu değil
/// (`JustAudioSesi`); bu yalnız kartı gösterir ve isteği oynatıcıya iletir.
/// Oynarken ön plan servisi açık kalır, sistem uygulamayı öldürmez.
class SistemMedyaKarti implements MedyaKarti {
  static Future<_KartIsleyici?>? _kurulum;
  _KartIsleyici? _isleyici;
  final _abonelikler = <StreamSubscription<Object?>>[];
  MedyaKomutlari? _komutlar;

  /// Telefon araması gibi geçici bir kesinti oynatmayı biz durdurduysak,
  /// kesinti bitince sürer.
  bool _kesintiyleDurdu = false;
  String? _sonKimlik;
  Uri? _sonKapak;

  static Future<_KartIsleyici?> _kur(String kanalAdi) => _kurulum ??= () async {
        try {
          return await AudioService.init(
            builder: _KartIsleyici.new,
            config: AudioServiceConfig(
              androidNotificationChannelId: 'com.yerdema.siyer.oynatma',
              androidNotificationChannelName: kanalAdi,
              androidNotificationIcon: 'mipmap/ic_launcher',
              // Duraklayınca kart kaydırılıp kapatılabilsin.
              androidStopForegroundOnPause: true,
            ),
          );
        } catch (hata) {
          debugPrint('Medya kartı kurulamadı: $hata');
          return null;
        }
      }();

  @override
  Future<void> baglan(MedyaKomutlari komutlar, {required String kanalAdi}) async {
    _komutlar = komutlar;
    _isleyici = await _kur(kanalAdi);
    if (_komutlar != komutlar) return; // bu arada bırakıldı
    _isleyici?.komutlar = komutlar;
    try {
      final oturum = await AudioSession.instance;
      await oturum.configure(const AudioSessionConfiguration.speech());
      _abonelikler
        ..add(oturum.interruptionEventStream.listen(_kesinti))
        // Kulaklık çıkınca durur.
        ..add(oturum.becomingNoisyEventStream.listen((_) => _komutlar?.duraklat()));
    } catch (hata) {
      debugPrint('Ses oturumu kurulamadı: $hata');
    }
  }

  void _kesinti(AudioInterruptionEvent e) {
    final k = _komutlar;
    if (k == null) return;
    if (e.begin) {
      // Kısık sesle sürmek (duck) anlatımda söz kaçırtır; durulur.
      if (_isleyici?.playbackState.value.playing ?? false) {
        _kesintiyleDurdu = e.type != AudioInterruptionType.unknown;
        k.duraklat();
      }
    } else if (_kesintiyleDurdu) {
      _kesintiyleDurdu = false;
      if (e.type != AudioInterruptionType.unknown) k.oynat();
    }
  }

  @override
  bool get kapakIster => true;

  @override
  void guncelle(MedyaDurumu d) {
    final i = _isleyici;
    if (i == null) return;
    if (d.kimlik != _sonKimlik || d.kapak != _sonKapak) {
      _sonKimlik = d.kimlik;
      _sonKapak = d.kapak;
      i.mediaItem.add(MediaItem(
        id: d.kimlik,
        title: d.baslik,
        artist: d.altBaslik,
        duration: _sure(d.toplam),
        artUri: d.kapak,
      ));
    }
    if (d.oynuyor) _kesintiyleDurdu = false;
    i.playbackState.add(PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        d.oynuyor ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: const {MediaAction.seek},
      androidCompactActionIndices: const [0, 1, 2],
      processingState: AudioProcessingState.ready,
      playing: d.oynuyor,
      updatePosition: _sure(d.konum),
      speed: d.oynuyor ? d.hiz : 0,
    ));
  }

  @override
  Future<void> birak() async {
    _komutlar = null;
    for (final a in _abonelikler) {
      await a.cancel();
    }
    _abonelikler.clear();
    final i = _isleyici;
    _isleyici = null;
    if (i == null) return;
    i.komutlar = null;
    // Boşta durumu servisi durdurur, kart kalkar.
    i.playbackState.add(PlaybackState());
    i.mediaItem.add(null);
  }

  static Duration _sure(double saniye) => Duration(microseconds: (saniye * 1e6).round());
}

class _KartIsleyici extends BaseAudioHandler {
  MedyaKomutlari? komutlar;

  @override
  Future<void> play() async => komutlar?.oynat();

  @override
  Future<void> pause() async => komutlar?.duraklat();

  @override
  Future<void> skipToNext() async => komutlar?.sonraki();

  @override
  Future<void> skipToPrevious() async => komutlar?.onceki();

  @override
  Future<void> seek(Duration position) async => komutlar?.git(position.inMicroseconds / 1e6);

  @override
  Future<void> stop() async => komutlar?.kapat();

  @override
  Future<void> onNotificationDeleted() async => komutlar?.kapat();
}
