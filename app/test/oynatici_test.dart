import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/ekran.dart';
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
  arkaPlanTestleri();
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

  testWidgets('hız düğmesi 1×, 1,5×, 2× arasında döner ve saati hızlandırır', (tester) async {
    final secilen = <double>[];
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, hizDegisti: secilen.add)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('1×'), findsOneWidget);
    await tester.tap(find.text('1×'));
    await tester.pump();
    await tester.tap(find.text('1,5×'));
    await tester.pump();
    expect(find.text('2×'), findsOneWidget);
    expect(secilen, [1.5, 2.0]);
    await tester.pump(const Duration(seconds: 3));
    expect(find.textContaining('0:06 /'), findsOneWidget, reason: '2× hızda 3 sn, 6 sn ilerletir');
    await tester.tap(find.text('2×'));
    await tester.pump();
    expect(find.text('1×'), findsOneWidget);
  });

  testWidgets('kayıtlı hızla açılır', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, hiz: 1.5)));
    await tester.pump();
    expect(find.text('1,5×'), findsOneWidget);
    expect(hizMetni(1.5, 'en'), '1.5×');
  });

  testWidgets('sağa çift dokunma 10 sn ileri, sola geri sarar', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, duraklatilmis: true)));
    await tester.pump();
    final alan = tester.getRect(find.byType(Oynatici));
    Future<void> ciftDokun(double oran) async {
      final nokta = Offset(alan.left + alan.width * oran, alan.center.dy);
      await tester.tapAt(nokta);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(nokta);
      await tester.pump();
    }

    await ciftDokun(0.75);
    expect(find.textContaining('0:10 /'), findsOneWidget);
    expect(find.text('+10 sn'), findsOneWidget);
    // Gösterge açıkken art arda sarmalar birikir.
    await ciftDokun(0.75);
    expect(find.textContaining('0:20 /'), findsOneWidget);
    expect(find.text('+20 sn'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('+20 sn'), findsNothing);

    await ciftDokun(0.25);
    expect(find.textContaining('0:10 /'), findsOneWidget);
    expect(find.text('−10 sn'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('çift dokunmadan sonraki tek dokunuş da sarar, gösterge kapanınca kontrolleri açar', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, duraklatilmis: true)));
    await tester.pump();
    final alan = tester.getRect(find.byType(Oynatici));
    final sag = Offset(alan.left + alan.width * 0.75, alan.center.dy);
    // Üç dokunuş: çift dokunma + tek dokunuş = 20 sn.
    await tester.tapAt(sag);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tapAt(sag);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tapAt(sag);
    await tester.pump(const Duration(milliseconds: 350)); // çift dokunma beklemesi
    expect(find.textContaining('0:20 /'), findsOneWidget);
    expect(find.text('+20 sn'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('+20 sn'), findsNothing);

    // Gösterge kapalıyken tek dokunuş sarmaz, kontrolleri açıp kapar.
    final once = find.byTooltip('Sonraki sahne').evaluate().length;
    await tester.tapAt(sag);
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.byTooltip('Sonraki sahne').evaluate().length, isNot(once));
  });

  test('efekt katmanları yer tutucu sayılmaz', () {
    const g = Gorsel(tarif: '', saat: 'gunduz', kamera: '', katmanlar: [
      Katman(id: 'toz', dosya: '', yerTutucu: 'toz', derinlik: 0.9),
      Katman(id: 'gok', dosya: 'gok.webp', yerTutucu: 'gok', derinlik: 0),
    ]);
    expect(g.yerTutucuVar, isFalse);
  });
}

class _SahteEkran extends Ekran {
  _SahteEkran({required this.acik});
  bool acik;
  final istekler = <String>[];
  @override
  Future<bool> acikMi() async => acik;
  @override
  Future<void> acikTut(bool a) async => istekler.add('acikTut:$a');
  @override
  Future<void> uyanikTut(bool a) async => istekler.add('uyanikTut:$a');
}

void arkaPlanTestleri() {
  const kaynakca = {'eser-a': Eser(id: 'eser-a', yazar: 'Yazar', ad: 'Eser')};

  testWidgets('ekran kapanınca bölüm sürer, açılınca kaldığı yerden devam eder', (tester) async {
    final ekran = _SahteEkran(acik: false);
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, ekran: ekran)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(ekran.istekler, contains('acikTut:true'), reason: 'oynarken ekran kararmasın');
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    await tester.pump();
    expect(ekran.istekler, contains('uyanikTut:true'));
    await tester.pump(const Duration(seconds: 3));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(ekran.istekler.last, 'uyanikTut:false');
    expect(find.textContaining('0:03 /'), findsOneWidget, reason: 'saat arka planda ilerledi');
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('0:04 /'), findsOneWidget, reason: 'dönüşte süre iki kez sayılmaz');
  });

  testWidgets('başka uygulamaya geçilince bölüm durur', (tester) async {
    final ekran = _SahteEkran(acik: true);
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: kaynakca, ekran: ekran)));
    await tester.pump(const Duration(milliseconds: 100));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    await tester.pump();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(find.byTooltip('Oynat'), findsOneWidget);
    expect(ekran.istekler, isNot(contains('uyanikTut:true')));
    expect(ekran.istekler.last, 'acikTut:false', reason: 'duraklayınca ekran kararabilir');
  });
}
