import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
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
  const kaynakca = {'eser-a': Eser(id: 'eser-a', yazar: 'Yazar', ad: 'Eser')};

  testWidgets('oynatıcı zamanı ilerletir ve cümleyi altyazıda gösterir', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca)));
    expect(find.text('bir iki üç'), findsNothing);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('bir iki üç'), findsOneWidget);
    expect(find.textContaining('Sahne 1 / 2'), findsOneWidget);
  });

  testWidgets('duraklatınca zaman durur', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca)));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.byTooltip('Duraklat'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('bir iki üç'), findsNothing);
    expect(find.byTooltip('Oynat'), findsOneWidget);
  });

  testWidgets('bölüm bitince kaynak listesi görünür', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca)));
    await tester.pump(const Duration(milliseconds: 100));
    for (var i = 0; i < 25; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.textContaining('Kaynaklar'), findsOneWidget);
    expect(find.textContaining('Yazar, Eser, s. 1'), findsOneWidget);
    expect(find.textContaining('doğrulama bekliyor'), findsOneWidget);
  });

  testWidgets('yer tutucu uyarısı ve şahıslar düğmesi sahneye göre görünür', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca)));
    await tester.pump(const Duration(milliseconds: 100));
    // 1. sahnede görseli olmayan gök katmanı var (nur efekt sayılmaz); şahıs yok.
    expect(find.textContaining('Görseller geçici yer tutucudur.'), findsOneWidget);
    expect(find.byTooltip('Şahıslar'), findsNothing);
    await tester.tap(find.byTooltip('Sonraki sahne'));
    await tester.pump();
    // 2. sahnede katman yok; bir şahıs var.
    expect(find.textContaining('Görseller geçici yer tutucudur.'), findsNothing);
    expect(find.byTooltip('Şahıslar'), findsOneWidget);
  });

  test('efekt katmanları yer tutucu sayılmaz', () {
    const g = Gorsel(tarif: '', saat: 'gunduz', kamera: '', katmanlar: [
      Katman(id: 'toz', dosya: '', yerTutucu: 'toz', derinlik: 0.9),
      Katman(id: 'gok', dosya: 'gok.webp', yerTutucu: 'gok', derinlik: 0),
    ]);
    expect(g.yerTutucuVar, isFalse);
  });
}
