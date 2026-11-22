import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/depo.dart';
import 'package:siyer/icerik/paketler.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/bolum_indirme.dart';

import 'ornek_bolum.dart';

/// Yerel paket yöneticisinin sahtesi: istenen yanıtları verir, çağrıları kaydeder.
class _SahteKanal implements PaketKanali {
  _SahteKanal({this.indirSonucu = const PaketIniyor()});

  PaketDurumu ilkDurum = const PaketYok();
  PaketDurumu indirSonucu;
  final cagrilar = <String>[];
  final _olay = StreamController<(String, PaketDurumu)>.broadcast();

  void yayinla(String ad, PaketDurumu d) => _olay.add((ad, d));

  @override
  Future<PaketDurumu> durum(String ad) async {
    cagrilar.add('durum $ad');
    return ilkDurum;
  }

  @override
  Future<PaketDurumu> indir(String ad) async {
    cagrilar.add('indir $ad');
    return indirSonucu;
  }

  @override
  Future<PaketDurumu> sil(String ad) async {
    cagrilar.add('sil $ad');
    return const PaketYok();
  }

  @override
  Stream<(String, PaketDurumu)> get olaylar => _olay.stream;
}

void main() {
  test('paket adı bölüm kimliğinin ilk parçasıdır', () {
    expect(paketAdi('b02-fil-vakasi'), 'b02');
    expect(mbMetni(4508877, 'tr'), '4,3');
    expect(mbMetni(4508877, 'en'), '4.3');
  });

  group('BolumDosyalari', () {
    const d = BolumDosyalari(
      varliklar: {'assets/icerik/gorseller/mekke-zemin.webp'},
      paketYolu: '/veri/b02',
      paketDosyalari: {'gorseller/b02-fil.webp', 'tr/ses/b02-s01.m4a'},
    );

    test('ortak görsel uygulamadan, bölüme özgü dosya paketten okunur', () {
      expect(d.gomulu('gorseller/mekke-zemin.webp'), isTrue);
      expect(d.dosyaYolu('gorseller/mekke-zemin.webp'), isNull);
      expect(d.dosyaYolu('gorseller/b02-fil.webp'), '/veri/b02/gorseller/b02-fil.webp');
      expect(d.bulunur('tr/ses/b02-s01.m4a'), isTrue);
      expect(d.bulunur('tr/ses/b03-s01.m4a'), isFalse);
    });

    test('ne uygulamada ne pakette olan dosya hata verir', () {
      expect(d.oku('gorseller/yok.webp'), throwsA(isA<FlutterError>()));
    });
  });

  group('PaketDurumlari', () {
    ProviderContainer kap(_SahteKanal k) {
      final c = ProviderContainer(overrides: [paketKanaliProvider.overrideWithValue(k)]);
      addTearDown(c.dispose);
      return c;
    }

    test('gömülü bölüm her zaman hazırdır, kanala sorulmaz', () async {
      final k = _SahteKanal();
      final c = kap(k);
      expect(c.read(paketDurumuProvider('b01-cahiliye-mekkesi')), isA<PaketHazir>());
      await pumpEventQueue();
      expect(k.cagrilar, isEmpty);
    });

    test('bilinmeyen paket sorulur, indirme ilerlemesi olaylardan gelir', () async {
      final k = _SahteKanal();
      final c = kap(k);
      final dinleyici = c.listen(paketDurumuProvider('b02-fil'), (_, _) {});
      addTearDown(dinleyici.close);
      expect(dinleyici.read(), isA<PaketBilinmiyor>());
      await pumpEventQueue();
      expect(dinleyici.read(), isA<PaketYok>());

      await c.read(paketDurumlariProvider.notifier).indir('b02');
      expect(dinleyici.read(), isA<PaketIniyor>());
      k.yayinla('b02', const PaketIniyor(inen: 50, toplam: 100));
      await pumpEventQueue();
      expect((dinleyici.read() as PaketIniyor).oran, 0.5);
      k.yayinla('b02', const PaketHazir('/veri/b02'));
      await pumpEventQueue();
      expect((dinleyici.read() as PaketHazir).yol, '/veri/b02');

      // Hazır paket yeniden indirilmez; silinince yok olur.
      await c.read(paketDurumlariProvider.notifier).indir('b02');
      await c.read(paketDurumlariProvider.notifier).sil('b02');
      expect(k.cagrilar, ['durum b02', 'indir b02', 'sil b02']);
      expect(dinleyici.read(), isA<PaketYok>());
    });

    test('olaylar indirme yanıtından önce bitirdiyse hazır durumu ezilmez', () async {
      final k = _SahteKanal();
      final c = kap(k);
      c.read(paketDurumlariProvider);
      k.yayinla('b03', const PaketHazir('/veri/b03'));
      await pumpEventQueue();
      // Durum zaten hazır: indirme hiç istenmez.
      await c.read(paketDurumlariProvider.notifier).indir('b03');
      expect(c.read(paketDurumlariProvider)['b03'], isA<PaketHazir>());
      expect(k.cagrilar, isEmpty);
    });
  });

  group('BolumIndirme', () {
    Widget sar(_SahteKanal k) => ProviderScope(
          overrides: [
            paketKanaliProvider.overrideWithValue(k),
            bolumProvider('b99-deneme').overrideWith((_) async => ornekBolum()),
            paketBoyutlariProvider.overrideWith((_) async => {'b99': 3 * 1024 * 1024}),
          ],
          child: const MaterialApp(
            locale: Locale('tr'),
            supportedLocales: Metinler.supportedLocales,
            localizationsDelegates: [
              Metinler.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: BolumIndirme(bolumId: 'b99-deneme'),
          ),
        );

    testWidgets('inmemiş bölüm açılınca indirme kendiliğinden başlar', (tester) async {
      final k = _SahteKanal();
      await tester.pumpWidget(sar(k));
      await tester.pump();
      await tester.pump();
      expect(k.cagrilar, ['durum b99', 'indir b99']);
      expect(find.text('Bölüm indiriliyor'), findsOneWidget);
      expect(find.text('3,0 MB'), findsOneWidget, reason: 'toplam bilinmezken paket boyutu');
      expect(find.text('Deneme'), findsOneWidget);
    });

    testWidgets('indirme düşerse tekrar dene düğmesi yeniden ister', (tester) async {
      final k = _SahteKanal(indirSonucu: const PaketHatasi('ağ yok'));
      await tester.pumpWidget(sar(k));
      await tester.pump();
      await tester.pump();
      expect(find.text('Tekrar dene'), findsOneWidget);
      await tester.tap(find.text('Tekrar dene'));
      await tester.pump();
      expect(k.cagrilar.where((c) => c.startsWith('indir')), hasLength(2));
    });
  });
}
