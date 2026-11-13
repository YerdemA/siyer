import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/l10n/app_localizations.dart';
import 'package:siyer/oynatici/anlatim_sesi.dart';
import 'package:siyer/oynatici/oynatici_ekrani.dart';
import 'package:siyer/oynatici/zaman_plani.dart';

import 'ornek_bolum.dart';

class _SahteSes implements AnlatimSesi {
  final olaylar = <String>[];
  String? _etkin;
  bool _caliyor = false;
  Duration _konum = Duration.zero;

  @override
  Future<Duration?> sure(String dosya) async => const Duration(seconds: 4);

  @override
  Future<void> cal(String dosya, Duration konum) async {
    olaylar.add('cal $dosya');
    _etkin = dosya;
    _caliyor = true;
    _konum = konum;
  }

  @override
  Future<void> ara(Duration konum) async => _konum = konum;

  @override
  Future<void> duraklat() async {
    olaylar.add('duraklat');
    _caliyor = false;
  }

  @override
  String? get etkinDosya => _etkin;

  @override
  bool get caliyor => _caliyor;

  // Sahte saat ilerlemez; oynatıcı her karede yeniden konumlar. Sorun değil.
  @override
  Duration get konum => _konum;

  @override
  Future<void> kapat() async => olaylar.add('kapat');
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
  group('ZamanPlani ile ses', () {
    test('sesli sahnede parçalar ses süresini kelime sayısıyla paylaşır', () {
      final p = ZamanPlani.olustur(ornekBolum(), sesSureleri: {'b99-s01': 13.0});
      final s1 = p.sahneler[0];
      const a = ZamanAyari();
      expect(s1.sesli, isTrue);
      expect(s1.sesBas, closeTo(a.sahneBasi, 1e-9));
      // 3 ve 23 kelime → 13 sn'nin 3/26'sı ve 23/26'sı; parça arası boşluk yok.
      expect(s1.parcalar[0].son - s1.parcalar[0].bas, closeTo(1.5, 1e-9));
      expect(s1.parcalar[1].bas, closeTo(s1.parcalar[0].son, 1e-9));
      expect(s1.parcalar[1].son, closeTo(a.sahneBasi + 13, 1e-9));
      expect(s1.son, closeTo(a.sahneBasi + 13 + a.sahneSonu, 1e-9));
      // Sesi olmayan sahne eski kurala göre devam eder.
      final s2 = p.sahneler[1];
      expect(s2.sesli, isFalse);
      expect(s2.bas, closeTo(s1.son, 1e-9));
    });

    test('ses süresi verilmeyen plan değişmez', () {
      final eski = ZamanPlani.olustur(ornekBolum());
      final yeni = ZamanPlani.olustur(ornekBolum(), sesSureleri: {'baska': 5});
      expect(yeni.toplam, eski.toplam);
      expect(yeni.sahneler.every((s) => !s.sesli), isTrue);
    });

    test('ses konumu yalnız ses aralığında vardır', () {
      final s = ZamanPlani.olustur(ornekBolum(), sesSureleri: {'b99-s01': 4.0}).sahneler[0];
      expect(s.sesKonumu(0.5), isNull, reason: 'sahne başı sessizliği');
      expect(s.sesKonumu(s.sesBas + 1), closeTo(1, 1e-9));
      expect(s.sesKonumu(s.sesBas + 4.1), isNull, reason: 'sahne sonu sessizliği');
    });
  });

  group('sesKarari', () {
    SesKarari k({bool oynuyor = true, double? an = 1, String? etkin = 'a.mp3', bool caliyor = true, int konumMs = 1000}) =>
        sesKarari(
          oynuyor: oynuyor,
          dosya: 'a.mp3',
          sesKonumu: an,
          etkinDosya: etkin,
          caliyor: caliyor,
          konum: Duration(milliseconds: konumMs),
        );

    test('uyumluysa bekler', () => expect(k(), isA<SesBekle>()));
    test('duraklatılınca ya da sessizlikte durur', () {
      expect(k(oynuyor: false), isA<SesDuraklat>());
      expect(k(an: null), isA<SesDuraklat>());
      expect(k(an: null, caliyor: false), isA<SesBekle>());
    });
    test('başka dosya ya da durmuş ses baştan çalınır', () {
      expect(k(etkin: 'b.mp3'), isA<SesCal>());
      expect((k(caliyor: false, an: 2.5) as SesCal).konum, const Duration(milliseconds: 2500));
    });
    test('kaydırınca (kayma > 200 ms) yeniden konumlanır', () {
      expect(k(konumMs: 1150), isA<SesBekle>());
      expect((k(an: 3, konumMs: 1000) as SesAra).konum, const Duration(seconds: 3));
    });
  });

  group('Oynatici ile ses', () {
    const kaynakca = {'eser-a': Eser(id: 'eser-a', yazar: 'Yazar', ad: 'Eser')};

    testWidgets('sessiz başlangıçtan sonra çalar, duraklatınca durur, kapanınca bırakır', (tester) async {
      final ses = _SahteSes();
      await tester.pumpWidget(_sar(Oynatici(
        bolum: ornekBolum(),
        kaynakca: kaynakca,
        sesSureleri: const {'b99-s01': 4.0},
        sesFabrikasi: () => ses,
      )));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(ses.olaylar, isEmpty, reason: 'sahne başı sessizliğinde ses yok');
      expect(find.textContaining('Anlatım sesi henüz yok'), findsNothing);

      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(ses.olaylar, contains('cal b99-s01.mp3'));

      await tester.tap(find.byTooltip('Duraklat'));
      await tester.pump();
      await tester.pump();
      expect(ses.olaylar.last, 'duraklat');

      await tester.pumpWidget(const SizedBox());
      expect(ses.olaylar.last, 'kapat');
    });

    testWidgets('sesi olmayan sahnede ses uyarısı görünür', (tester) async {
      await tester.pumpWidget(_sar(Oynatici(
        bolum: ornekBolum(),
        kaynakca: kaynakca,
        baslangicSahnesi: 2,
        sesSureleri: const {'b99-s01': 4.0},
        sesFabrikasi: _SahteSes.new,
      )));
      await tester.pump();
      expect(find.textContaining('Anlatım sesi henüz yok'), findsOneWidget);
    });
  });
}
