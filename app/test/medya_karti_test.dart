import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/medya_karti.dart';
import 'package:siyer/oynatici/oynatici_ekrani.dart';

import 'ornek_bolum.dart';

class _SahteKart implements MedyaKarti {
  MedyaKomutlari? komutlar;
  String? kanal;
  final durumlar = <MedyaDurumu>[];
  bool birakildi = false;

  @override
  Future<void> baglan(MedyaKomutlari k, {required String kanalAdi}) async {
    komutlar = k;
    kanal = kanalAdi;
  }

  @override
  void guncelle(MedyaDurumu d) => durumlar.add(d);

  @override
  bool get kapakIster => false;

  @override
  Future<void> birak() async => birakildi = true;
}

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
  testWidgets('kart bölüm ve sahneyi gösterir, düğmeleri oynatıcıyı yönetir', (tester) async {
    final kart = _SahteKart();
    await tester.pumpWidget(_sar(Oynatici(bolum: ornekBolum(), kaynakca: const {}, medyaKarti: kart)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(kart.kanal, 'Bölüm oynatma');
    final ilk = kart.durumlar.last;
    expect(ilk.baslik, ornekBolum().baslik);
    expect(ilk.altBaslik, 'Sahne 1/2');
    expect(ilk.oynuyor, isTrue);

    // Oynarken her karede değil, yalnız değişince yenilenir.
    final sayi = kart.durumlar.length;
    await tester.pump(const Duration(milliseconds: 500));
    expect(kart.durumlar.length, sayi);

    kart.komutlar!.duraklat();
    await tester.pump();
    expect(kart.durumlar.last.oynuyor, isFalse);
    expect(find.byTooltip('Oynat'), findsOneWidget);

    kart.komutlar!.sonraki();
    await tester.pump();
    expect(kart.durumlar.last.altBaslik, 'Sahne 2/2');

    kart.komutlar!.git(0);
    await tester.pump();
    expect(kart.durumlar.last.altBaslik, 'Sahne 1/2');
    expect(kart.durumlar.last.konum, 0);

    kart.komutlar!.oynat();
    await tester.pump();
    expect(kart.durumlar.last.oynuyor, isTrue);
    expect(find.byTooltip('Duraklat'), findsOneWidget);

    kart.komutlar!.kapat();
    await tester.pump();
    expect(kart.durumlar.last.oynuyor, isFalse);

    await tester.pumpWidget(const SizedBox());
    expect(kart.birakildi, isTrue);
  });
}
