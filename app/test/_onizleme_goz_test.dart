// Geçici önizleme: b04-s07'yi oynatıcının çizim koduyla kare kare çizer.
// Çıktı: ONIZLEME_KLASORU ortam değişkeni (yoksa build/onizleme).
// Commit'lenmez.
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyer/icerik/model.dart';
import 'package:siyer/oynatici/gorsel_onbellek.dart';
import 'package:siyer/oynatici/sahne_cizici.dart';
import 'package:siyer/oynatici/zaman_plani.dart';

const _sureler = {
  'b04-s01': 21.28, 'b04-s02': 34.48, 'b04-s03': 23.92, 'b04-s04': 17.84, 'b04-s05': 14.24,
  'b04-s06': 22.56, 'b04-s07': 23.6, 'b04-s08': 12.48, 'b04-s09': 32.96, 'b04-s10': 20.8,
};

void main() {
  testWidgets('b04-s07 önizleme kareleri', (tester) async {
    final klasor = Platform.environment['ONIZLEME_KLASORU'] ?? 'build/onizleme';
    final fps = double.parse(Platform.environment['ONIZLEME_FPS'] ?? '12');
    const gen = 1280.0, yuk = 720.0;
    await tester.runAsync(() async {
      final j = jsonDecode(await File('../content/tr/bolumler/b04-sut-anne.json').readAsString());
      final bolum = Bolum.fromJson(j as Map<String, dynamic>);
      final plan = ZamanPlani.olustur(bolum, sesSureleri: _sureler);
      final s = plan.sahneler[6];
      final onbellek = GorselOnbellek(okuyucu: (d) => File('../content/gorseller/$d').readAsBytes());
      final dosyalar = {
        for (final c in [...s.sahne.cekimler, ...plan.sahneler[5].sahne.cekimler, ...plan.sahneler[7].sahne.cekimler])
          for (final k in c.katmanlar)
            if (k.dosya.isNotEmpty) k.dosya,
      };
      for (final d in dosyalar) {
        onbellek.al(d);
      }
      for (var i = 0; i < 200 && dosyalar.any((d) => onbellek.al(d) == null && !onbellek.bulunamadi(d)); i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
      Directory(klasor).createSync(recursive: true);
      final ib = double.tryParse(Platform.environment['ONIZLEME_BAS'] ?? '');
      final is_ = double.tryParse(Platform.environment['ONIZLEME_SON'] ?? '');
      final bas = ib != null ? s.bas + ib : s.bas - 1.0, son = is_ != null ? s.bas + is_ : s.son + 0.5;
      var no = 0;
      final satirlar = <String>[];
      for (var t = bas; t <= son; t += 1 / fps) {
        final k = plan.konum(t);
        final kayit = ui.PictureRecorder();
        final tuval = Canvas(kayit);
        const boyut = Size(gen, yuk);
        SahneCizici(gorsel: k.cekim.gorsel, ilerleme: k.cekimIlerleme, zaman: t, gorseller: onbellek)
            .paint(tuval, boyut);
        if (k.gelenCekim != null) {
          tuval.saveLayer(Offset.zero & boyut, Paint()..color = Color.fromRGBO(0, 0, 0, k.gecisOrani));
          SahneCizici(gorsel: k.gelenCekim!.gorsel, ilerleme: k.gelenCekimIlerleme, zaman: t, gorseller: onbellek)
              .paint(tuval, boyut);
          tuval.restore();
        }
        final resim = await kayit.endRecording().toImage(gen.toInt(), yuk.toInt());
        final png = await resim.toByteData(format: ui.ImageByteFormat.png);
        File('$klasor/k${(no++).toString().padLeft(4, '0')}.png').writeAsBytesSync(png!.buffer.asUint8List());
        satirlar.add('${(t - s.bas).toStringAsFixed(2)} ${k.cekim.sira} ${k.gelenCekim?.sira ?? '-'} '
            '${k.gecisOrani.toStringAsFixed(2)} ${k.parca?.parca.metin.substring(0, 12) ?? ''}');
      }
      File('$klasor/zaman.txt').writeAsStringSync(satirlar.join('\n'));
    });
  }, timeout: const Timeout(Duration(minutes: 40)));
}
