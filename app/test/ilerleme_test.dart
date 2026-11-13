import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/ilerleme/ilerleme.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/oynatici_ekrani.dart';

import 'ornek_bolum.dart';

Widget _sar(Widget w) => MaterialApp(
      locale: const Locale('tr'),
      supportedLocales: Metinler.supportedLocales,
      localizationsDelegates: const [
        Metinler.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(body: w),
    );

void main() {
  group('BolumIlerlemesi', () {
    test('bitmemiş bölüm kaldığı sahneden, bitmiş bölüm baştan açılır', () {
      expect(const BolumIlerlemesi(sonSahne: 5).devamSahnesi, 5);
      expect(const BolumIlerlemesi(sonSahne: 5, bitti: true).devamSahnesi, 1);
    });
  });

  group('IlerlemeDeposu', () {
    test('kayıtlar cihazdan okunur, bozuk kayıt yok sayılır', () async {
      SharedPreferences.setMockInitialValues({
        'ilerleme.b09': '{"sahne": 4, "bitti": false}',
        'ilerleme.b10': 'bozuk{',
        'baska.anahtar': 'x',
      });
      final c = ProviderContainer();
      addTearDown(c.dispose);
      final d = await c.read(ilerlemeProvider.future);
      expect(d, {'b09': const BolumIlerlemesi(sonSahne: 4)});
    });

    test('sahne ve bitiş kaydedilir; yeniden izlemek bitişi silmez', () async {
      SharedPreferences.setMockInitialValues({});
      final c = ProviderContainer();
      addTearDown(c.dispose);
      await c.read(ilerlemeProvider.future);
      final n = c.read(ilerlemeProvider.notifier);
      await n.sahneKaydet('b09', 7);
      await n.bitir('b09');
      await n.sahneKaydet('b09', 2);
      expect(c.read(ilerlemeProvider).value!['b09'], const BolumIlerlemesi(sonSahne: 2, bitti: true));
      final p = await SharedPreferences.getInstance();
      expect(p.getString('ilerleme.b09'), '{"sahne":2,"bitti":true}');
    });
  });

  group('Oynatici ilerleme bildirimi', () {
    const kaynakca = {'eser-a': Eser(id: 'eser-a', yazar: 'Yazar', ad: 'Eser')};

    testWidgets('açılışta, sahne geçişinde ve bölüm sonunda bildirir', (tester) async {
      final sahneler = <int>[];
      var bitis = 0;
      await tester.pumpWidget(_sar(Oynatici(
        bolum: ornekBolum(),
        kaynakca: kaynakca,
        sahneDegisti: sahneler.add,
        bitti: () => bitis++,
      )));
      await tester.pump(const Duration(milliseconds: 100));
      expect(sahneler, [1]);
      await tester.tap(find.byTooltip('Sonraki sahne'));
      await tester.pump();
      await tester.pump();
      expect(sahneler, [1, 2]);
      for (var i = 0; i < 25; i++) {
        await tester.pump(const Duration(seconds: 1));
      }
      expect(bitis, 1);
    });

    testWidgets('verilen sahneden başlar', (tester) async {
      final sahneler = <int>[];
      await tester.pumpWidget(_sar(Oynatici(
        bolum: ornekBolum(),
        kaynakca: kaynakca,
        baslangicSahnesi: 2,
        sahneDegisti: sahneler.add,
      )));
      await tester.pump();
      expect(sahneler.first, 2);
      expect(find.textContaining('Sahne 2 / 2'), findsOneWidget);
    });
  });
}
