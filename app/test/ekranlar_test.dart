import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyer/ekranlar/ayarlar.dart';
import 'package:siyer/ekranlar/sahislar.dart';
import 'package:siyer/ekranlar/zaman_cizelgesi.dart';
import 'package:siyer/icerik/depo.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/ilerleme/ilerleme.dart';
import 'package:siyer/l10n/app_localizations.dart';

const _kaynakca = {
  'eser-a': Eser(
    id: 'eser-a',
    yazar: 'Yazar',
    ad: 'Eser',
    baski: 'Birinci baskı',
    katman: 'C',
    erisim: 'https://ornek.org/eser — yerel kopya: kaynaklar/eser.pdf',
  ),
};

const _iddialar = {
  'i-1': Iddia(id: 'i-1', kaynaklar: [Atif(eser: 'eser-a', konum: 's. 12', dogrulandi: false)]),
  'i-bos': Iddia(id: 'i-bos', kaynaklar: []),
};

const _sahislar = [
  Sahis(id: 'kaynakli', ad: 'Kaynaklı Kişi', ozet: 'Kaynaklı özet.', iddialar: ['i-1']),
  Sahis(id: 'kaynaksiz', ad: 'Kaynaksız Kişi', ozet: 'Kaynaksız özet.', iddialar: ['i-bos']),
];

Widget _sar(Widget w) => ProviderScope(
      overrides: [
        kaynakcaProvider.overrideWith((_) async => _kaynakca),
        iddiaDiziniProvider.overrideWith((_) async => _iddialar),
        sahislarProvider.overrideWith((_) async => _sahislar),
        bolumListesiProvider.overrideWith((_) async => const []),
        zamanCizelgesiProvider.overrideWith((_) async => const [
              ZamanOlayi(id: 'z-1', yil: 570, yaklasik: true, olay: 'Birinci olay.', iddia: 'i-1'),
              ZamanOlayi(id: 'z-2', yil: 605, olay: 'İkinci olay.'),
            ]),
      ],
      child: MaterialApp(
        locale: const Locale('tr'),
        supportedLocales: Metinler.supportedLocales,
        localizationsDelegates: const [
          Metinler.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: w,
      ),
    );

void main() {
  testWidgets('şahıs sayfası atfı gösterir', (tester) async {
    await tester.pumpWidget(_sar(const SahisEkrani(sahisId: 'kaynakli')));
    await tester.pumpAndSettle();
    expect(find.text('Kaynaklı özet.'), findsOneWidget);
    expect(find.textContaining('Yazar, Eser, s. 12'), findsOneWidget);
    expect(find.textContaining('doğrulama bekliyor'), findsOneWidget);
    expect(find.text('Kaynak bekliyor'), findsNothing);
  });

  testWidgets('kaynaksız şahısta "Kaynak bekliyor" yazar', (tester) async {
    await tester.pumpWidget(_sar(const SahisEkrani(sahisId: 'kaynaksiz')));
    await tester.pumpAndSettle();
    expect(find.text('Kaynak bekliyor'), findsOneWidget);
  });

  testWidgets('bilinmeyen şahıs kimliğinde "bulunamadı"', (tester) async {
    await tester.pumpWidget(_sar(const SahisEkrani(sahisId: 'yok')));
    await tester.pumpAndSettle();
    expect(find.text('Kayıt bulunamadı.'), findsOneWidget);
  });

  testWidgets('zaman çizelgesi yılları, olayları ve kaynak durumunu gösterir', (tester) async {
    await tester.pumpWidget(_sar(const ZamanCizelgesiEkrani()));
    await tester.pumpAndSettle();
    expect(find.text('yakl. 570'), findsOneWidget);
    expect(find.text('605'), findsOneWidget);
    expect(find.text('Birinci olay.'), findsOneWidget);
    expect(find.textContaining('Yazar, Eser, s. 12'), findsOneWidget);
    // İddiası olmayan olay kaynaksız gösterilmez.
    expect(find.text('Kaynak bekliyor'), findsOneWidget);
  });

  testWidgets('kaynakça yalnız web adresini gösterir; ilerleme sıfırlanır', (tester) async {
    SharedPreferences.setMockInitialValues({'ilerleme.b09': '{"sahne":3,"bitti":false}'});
    await tester.pumpWidget(_sar(const AyarlarEkrani()));
    await tester.pumpAndSettle();
    expect(find.text('Yazar, Eser'), findsOneWidget);
    expect(find.textContaining('https://ornek.org/eser'), findsOneWidget);
    expect(find.textContaining('kaynaklar/eser.pdf'), findsNothing);
    expect(find.textContaining('Kaynak katmanı C'), findsOneWidget);

    await tester.tap(find.text('İlerlemeyi sıfırla'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sıfırla'));
    await tester.pumpAndSettle();
    final p = await SharedPreferences.getInstance();
    expect(p.getKeys().where((k) => k.startsWith(IlerlemeDeposu.onek)), isEmpty);
  });
}
