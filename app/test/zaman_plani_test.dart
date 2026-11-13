import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/oynatici/zaman_plani.dart';

import 'ornek_bolum.dart';

void main() {
  const ayar = ZamanAyari();
  final plan = ZamanPlani.olustur(ornekBolum());

  test('kısa cümle en az süreyi alır, uzun cümle kelime hızına göre', () {
    expect(ZamanPlani.parcaSuresi('bir iki üç', ayar), ayar.enAzParca);
    expect(ZamanPlani.parcaSuresi(List.filled(23, 'k').join(' '), ayar), closeTo(10, 1e-9));
  });

  test('sahneler arka arkaya dizilir, toplam son sahnenin sonudur', () {
    final s1 = plan.sahneler[0], s2 = plan.sahneler[1];
    expect(s1.bas, 0);
    // 0.8 baş + 2.5 + 0.6 ara + 10 + 1.2 son
    expect(s1.son, closeTo(15.1, 1e-9));
    expect(s2.bas, s1.son);
    expect(plan.toplam, s2.son);
    expect(s1.parcalar[1].bas, closeTo(0.8 + 2.5 + 0.6, 1e-9));
  });

  test('altyazı yalnız cümle süresince görünür', () {
    expect(plan.konum(0.5).parca, isNull);
    expect(plan.konum(1.0).parca!.parca.metin, 'bir iki üç');
    expect(plan.konum(3.5).parca, isNull, reason: 'iki cümle arası boşluk');
  });

  test('sahne sonunda bir sonraki sahneye çapraz geçiş yapılır', () {
    final s1 = plan.sahneler[0];
    final once = plan.konum(s1.son - ayar.gecis - 0.01);
    expect(once.gelen, isNull);
    final yarisi = plan.konum(s1.son - ayar.gecis / 2);
    expect(yarisi.gelen!.sahne.id, 'b99-s02');
    expect(yarisi.gecisOrani, closeTo(0.5, 1e-9));
    expect(yarisi.gelenIlerleme, greaterThan(0));
  });

  test('zaman sınır dışına taşmaz', () {
    expect(plan.konum(-5).sahne.sira, 0);
    expect(plan.konum(plan.toplam + 5).sahne.sira, 1);
    expect(plan.konum(plan.toplam).ilerleme, 1);
  });

  test('bölüm sonu atıf listesi tekrarları ayıklar', () {
    expect(ornekBolum().tumAtiflar, hasLength(1));
  });
}
