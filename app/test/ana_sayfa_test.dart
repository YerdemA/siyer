import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyer/ekranlar/harita_cografya.dart';
import 'package:siyer/ayarlar/tercihler.dart';
import 'package:siyer/ekranlar/ayarlar.dart';
import 'package:siyer/ekranlar/bolum_yolu.dart';
import 'package:siyer/ekranlar/sahislar.dart';
import 'package:siyer/icerik/depo.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/ilerleme/gorulenler.dart';
import 'package:siyer/ilerleme/ilerleme.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/harita_gecisi.dart';
import 'package:siyer/oynatici/oynatici_ekrani.dart';

import 'ornek_bolum.dart';

const _mekke = Yer(id: 'mekke', ad: 'Mekke', x: 0.46, y: 0.654);
const _hira = Yer(id: 'hira', ad: 'Hira', x: 0.471, y: 0.652);
const _busra = Yer(id: 'busra', ad: 'Busrâ', x: 0.141, y: 0.099);

const _sahislar = [
  Sahis(id: efendimizId, ad: 'Hz. Muhammed (s.a.v.)', temsil: 'nur'),
  Sahis(id: 'kisi-a', ad: 'Ebû Tâlib'),
  Sahis(id: 'kisi-b', ad: 'Bahîrâ'),
];

/// İki sahneli örnek bölüm; ikinci sahnede kisi-a geçer.
Bolum _bolum({String yer1 = 'mekke', String yer2 = 'busra', String? yer3}) {
  final b = ornekBolum();
  return Bolum(
    id: b.id,
    sira: 1,
    baslik: 'Deneme Bölümü',
    ozet: 'Kısa açıklama.',
    durum: b.durum,
    sahneler: [
      Sahne(id: 's1', anlatim: b.sahneler[0].anlatim, gorsel: b.sahneler[0].gorsel, sesAnlatim: '', yer: yer1),
      Sahne(
        id: 's2',
        anlatim: b.sahneler[1].anlatim,
        gorsel: b.sahneler[1].gorsel,
        sesAnlatim: '',
        sahislar: const ['kisi-a'],
        yer: yer2,
      ),
      if (yer3 != null)
        Sahne(id: 's3', anlatim: b.sahneler[1].anlatim, gorsel: b.sahneler[1].gorsel, sesAnlatim: '', yer: yer3),
    ],
    iddialar: b.iddialar,
  );
}

/// Testte gerçek ses eklentisi yok; çalınan sesler kaydedilir.
class _SahteEfekt implements EfektSesi {
  final calinan = <String>[];
  @override
  Future<void> cal(String ad) async => calinan.add(ad);
  @override
  Future<void> kapat() async {}
}

Widget _sar(Widget w, {List<Bolum>? bolumler}) => ProviderScope(
      overrides: [
        efektSesiProvider.overrideWithValue(_SahteEfekt()),
        kaynakcaProvider.overrideWith((_) async => const {}),
        sahislarProvider.overrideWith((_) async => _sahislar),
        bolumListesiProvider.overrideWith((_) async => bolumler ?? [_bolum()]),
        iddiaDiziniProvider.overrideWith((_) async => const {}),
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
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('görülen şahıslar', () {
    test('hiç izlenmemişse yalnız Efendimiz', () {
      expect(gorulenSahislar([_bolum()], const {}), {efendimizId});
    });

    test('yarım bölümde yalnız kalınan sahneye kadarkiler', () {
      final b = _bolum();
      expect(gorulenSahislar([b], {b.id: const BolumIlerlemesi(sonSahne: 1)}), {efendimizId});
      expect(gorulenSahislar([b], {b.id: const BolumIlerlemesi(sonSahne: 2)}), {efendimizId, 'kisi-a'});
    });

    test('bitirilen bölümün hepsi', () {
      final b = _bolum();
      expect(
        gorulenSahislar([b], {b.id: const BolumIlerlemesi(sonSahne: 1, bitti: true)}),
        {efendimizId, 'kisi-a'},
      );
    });
  });

  test('harita yalnız bölümün kalanında birden çok sahnesi olan yere açılır', () {
    // b03 gibi: Mekke, Mekke, Yesrib (tek sahne: kabir), Mekke.
    const yerler = ['mekke', 'mekke', 'yesrib', 'mekke'];
    expect(kaliciYer(yerler, 1), isTrue);
    expect(kaliciYer(yerler, 2), isFalse);
    expect(kaliciYer(yerler, 3), isFalse, reason: 'son sahne tek kalır');
    expect(kaliciYer(['busra', 'mekke', 'busra'], 0), isTrue, reason: 'ardışık olmasa da sayılır');
    expect(kaliciYer([null, 'mekke'], 0), isFalse);
  });

  test('harita penceresi ekranı doldurur, bölge ortada kalır', () {
    // Bütün harita 3:4; dikey telefonda (9:16) üst-alt genişler.
    final p = tumHarita.ekranaGore(9 / 16);
    expect(p.width, 1);
    expect(p.height, closeTo(4 / 3, 1e-9));
    expect(p.center.dx, closeTo(0.5, 1e-9));
    expect(p.center.dy, closeTo(0.5, 1e-9));
    // Mekke çevresi geniş; dikeyde yine yalnız yükseklik artar.
    final m = mekkeCevresi.ekranaGore(9 / 16);
    expect(m.width, closeTo(mekkeCevresi.alan.width, 1e-9));
    expect(m.height, greaterThan(mekkeCevresi.alan.height));
    // Yatay geniş ekranda genişlik artar.
    expect(tumHarita.ekranaGore(2).height, 1);
  });

  test('harita geçişi Mekke çevresi içinde gösterilmez', () {
    expect(haritaGecisiGerekir(null, _mekke), isTrue);
    expect(haritaGecisiGerekir(_mekke, _mekke), isFalse);
    expect(haritaGecisiGerekir(_mekke, _hira), isFalse);
    expect(haritaGecisiGerekir(_mekke, _busra), isTrue);
  });

  test('arama işaretleri yok sayar', () {
    expect(sadelestir("Ebû Tâlib"), 'ebu talib');
    expect(sadelestir('Şuaybe'), 'suaybe');
  });

  testWidgets('şahıslar: izlenmemişse yalnız Efendimiz ve kilit notu', (tester) async {
    await tester.pumpWidget(_sar(const SahislarEkrani()));
    await tester.pumpAndSettle();
    expect(find.text('Hz. Muhammed (s.a.v.)'), findsOneWidget);
    expect(find.text('Ebû Tâlib'), findsNothing);
    expect(find.textContaining('2 şahıs daha'), findsOneWidget);
  });

  testWidgets('şahıslar: izlenen sahnedeki şahıs görünür ve aranabilir', (tester) async {
    SharedPreferences.setMockInitialValues({'ilerleme.b99-deneme': '{"sahne":2,"bitti":false}'});
    await tester.pumpWidget(_sar(const SahislarEkrani()));
    await tester.pumpAndSettle();
    expect(find.text('Ebû Tâlib'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'ebu tal');
    await tester.pumpAndSettle();
    expect(find.text('Ebû Tâlib'), findsOneWidget);
    expect(find.text('Hz. Muhammed (s.a.v.)'), findsNothing);
  });

  testWidgets('bölüm kartına dokununca çarpı çizilir ve bölüm açılır', (tester) async {
    tester.view.physicalSize = const Size(1080, 2200);
    tester.view.devicePixelRatio = 2.6;
    addTearDown(tester.view.reset);
    final efekt = _SahteEfekt();
    final yonlendirici = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const Scaffold(body: BolumYolu())),
      GoRoute(path: '/bolum/:id', builder: (_, d) => Text('açıldı ${d.pathParameters['id']}')),
    ]);
    await tester.pumpWidget(ProviderScope(
      // Birden çok bölüm: dokunulan kart üste alınırken durumu korunmalı.
      overrides: [
        efektSesiProvider.overrideWithValue(efekt),
        bolumListesiProvider.overrideWith((_) async {
          final b = _bolum();
          final ikinci = Bolum(
            id: 'b98-ikinci',
            sira: 2,
            baslik: 'İkinci',
            ozet: '',
            durum: b.durum,
            sahneler: b.sahneler,
            iddialar: b.iddialar,
          );
          return [b, ikinci];
        }),
      ],
      child: MaterialApp.router(
        routerConfig: yonlendirici,
        locale: const Locale('tr'),
        supportedLocales: Metinler.supportedLocales,
        localizationsDelegates: const [
          Metinler.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Deneme Bölümü'), findsOneWidget);
    expect(find.text('Kısa açıklama.'), findsOneWidget);
    // Hiç izlenmemiş: ilk bölüm sıradaki, ikincisi soluk.
    expect(find.text('Sıradaki'), findsOneWidget);
    await tester.tap(find.text('Deneme Bölümü'));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byWidgetPredicate((w) => w is CustomPaint && w.painter is CarpiCizici), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('açıldı b99-deneme'), findsOneWidget);
    expect(efekt.calinan, ['kalem']);
  });

  testWidgets('bölüm açılınca harita gösterilir, uzak yere geçişte yine', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(yer3: 'busra'),
      kaynakca: const {},
      yerler: const [_mekke, _hira, _busra],
    )));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(HaritaGecisi), findsOneWidget);
    // Harita sürerken zaman durur: altyazı yok.
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('bir iki üç'), findsNothing);
    await tester.tap(find.text('Geç'));
    await tester.pump();
    expect(find.byType(HaritaGecisi), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('bir iki üç'), findsOneWidget);
    // Sonraki iki sahne Busrâ'da: harita yeniden.
    await tester.tap(find.byTooltip('Sonraki sahne'));
    await tester.pump();
    expect(find.byType(HaritaGecisi), findsOneWidget);
  });

  testWidgets('tek sahnelik uzak uğrakta harita açılmaz', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(yer3: 'mekke'),
      kaynakca: const {},
      yerler: const [_mekke, _hira, _busra],
    )));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Geç'));
    await tester.pump();
    await tester.tap(find.byTooltip('Sonraki sahne'));
    await tester.pump();
    expect(find.byType(HaritaGecisi), findsNothing, reason: 'Busrâ tek sahne');
    await tester.tap(find.byTooltip('Sonraki sahne'));
    await tester.pump();
    expect(find.byType(HaritaGecisi), findsNothing, reason: "Mekke'ye dönüşte de yok");
  });

  testWidgets('Mekke çevresinde sahne geçişinde harita yok', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(yer2: 'hira'),
      kaynakca: const {},
      yerler: const [_mekke, _hira, _busra],
    )));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Geç'));
    await tester.pump();
    await tester.tap(find.byTooltip('Sonraki sahne'));
    await tester.pump();
    expect(find.byType(HaritaGecisi), findsNothing);
  });

  test('görülen yerler ve ilk görünüş', () {
    final b = _bolum();
    expect(gorulenYerler([b], const {}), isEmpty);
    expect(gorulenYerler([b], {b.id: const BolumIlerlemesi(sonSahne: 1)}), {'mekke'});
    expect(gorulenYerler([b], {b.id: const BolumIlerlemesi(bitti: true)}), {'mekke', 'busra'});
    final ilk = ilkGorunus([b], 'kisi-a');
    expect(ilk?.bolum.id, b.id);
    expect(ilk?.sahne, 2);
    expect(ilkGorunus([b], 'yok'), isNull);
  });

  testWidgets('bölüm sonunda sıradaki bölüm düğmesi, altyazı ölçeği', (tester) async {
    final sonraki = Bolum(id: 'b100', sira: 2, baslik: 'Öteki', ozet: '', durum: '', sahneler: const [], iddialar: const []);
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(),
      kaynakca: const {},
      sonrakiBolum: sonraki,
      altyaziOlcegi: 1.3,
    )));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 1));
    final yazi = tester.widget<Text>(find.text('bir iki üç'));
    expect(yazi.style?.fontSize, closeTo(18 * 1.3, 0.01));
    for (var i = 0; i < 25; i++) {
      await tester.pump(const Duration(seconds: 1));
    }
    expect(find.text('Sıradaki bölüm: Öteki'), findsOneWidget);
  });

  testWidgets('ayarlar: altyazı boyutu ve efekt sesleri saklanır', (tester) async {
    await tester.pumpWidget(_sar(const AyarlarEkrani()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Büyük'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Efekt sesleri'));
    await tester.pumpAndSettle();
    final p = await SharedPreferences.getInstance();
    expect(p.getString('tercih.altyazi'), 'buyuk');
    expect(p.getBool('tercih.efekt'), isFalse);
  });

  testWidgets('harita geçişi açılışta parşömen sesi çalar', (tester) async {
    final calinan = <String>[];
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(),
      kaynakca: const {},
      yerler: const [_mekke, _busra],
      efekt: calinan.add,
    )));
    await tester.pump(const Duration(milliseconds: 100));
    expect(calinan, ['parsomen']);
  });

  testWidgets('yarım bölüm varsa en üstte devam kartı çıkar ve bölümü açar', (tester) async {
    SharedPreferences.setMockInitialValues({
      'ilerleme.b99-deneme': '{"sahne":2,"bitti":false,"zaman":5}',
    });
    final yonlendirici = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, _) => const Scaffold(body: BolumYolu())),
      GoRoute(path: '/bolum/:id', builder: (_, d) => Text('açıldı ${d.pathParameters['id']}')),
    ]);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        efektSesiProvider.overrideWithValue(_SahteEfekt()),
        bolumListesiProvider.overrideWith((_) async => [_bolum()]),
      ],
      child: MaterialApp.router(
        routerConfig: yonlendirici,
        locale: const Locale('tr'),
        supportedLocales: Metinler.supportedLocales,
        localizationsDelegates: const [
          Metinler.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byType(DevamKarti), findsOneWidget);
    expect(find.text('Sahne 2 / 2'), findsOneWidget);
    await tester.tap(find.byType(DevamKarti));
    await tester.pumpAndSettle();
    expect(find.text('açıldı b99-deneme'), findsOneWidget);
  });

  testWidgets('yarım bölüm yoksa devam kartı yok', (tester) async {
    await tester.pumpWidget(_sar(const Scaffold(body: BolumYolu())));
    await tester.pumpAndSettle();
    expect(find.byType(DevamKarti), findsNothing);
  });

  testWidgets('yolun sonunda sıradaki dönem "Yakında" kartı', (tester) async {
    await tester.pumpWidget(_sar(const Scaffold(body: BolumYolu())));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.byType(YakindaKarti), 200);
    expect(find.text('Peygamberlik Dönemi'), findsOneWidget);
    expect(find.text('Yakında'), findsOneWidget);
  });

  testWidgets('hareketi azalt: harita geçişi kısa sürer, ayar saklanır', (tester) async {
    await tester.pumpWidget(_sar(Oynatici(
      bolum: _bolum(),
      kaynakca: const {},
      yerler: const [_mekke, _busra],
      azHareket: true,
    )));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(HaritaGecisi), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1600));
    expect(find.byType(HaritaGecisi), findsNothing);

    await tester.pumpWidget(_sar(const AyarlarEkrani()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hareketi azalt'));
    await tester.pumpAndSettle();
    final p = await SharedPreferences.getInstance();
    expect(p.getBool('tercih.hareketiAzalt'), isTrue);
  });
}
