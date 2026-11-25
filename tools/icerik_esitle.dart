// İçeriği uygulamaya ve bölüm paketlerine dağıtır.
//
// Kullanım (depo kökünden):
//   dart run tools/icerik_esitle.dart
//
// Flutter yalnız kendi proje klasörü içindeki dosyaları paketleyebildiği için
// `content/` buradan kopyalanır. Hedef klasörler her seferinde silinip
// yeniden yazılır ve git'e girmez. İçerik değiştikten sonra uygulamayı
// çalıştırmadan önce bu betiği çalıştır.
//
// Dağıtım (docs/ICERIK_SEMASI.md → Bölüm paketleri):
// - Uygulamaya gömülü (`app/assets/icerik/`): bütün JSON'lar, şahıs
//   portreleri ve [gomuluBolumler]in kullandığı her ses ve görsel.
// - Bölüm paketi (`app/android/paketler/<paket>/`, Play Asset Delivery,
//   isteğe bağlı): o bölümün kullanıp uygulamada olmayan ses ve görselleri.
//   Birden çok bölümün kullandığı görsel her birinin paketine kopyalanır;
//   her paket tek başına yeter.
// - Fon müziği ve ortam sesleri (`content/fon/`) bütün bölümlerde ortak;
//   hep uygulamaya gömülür.
// Paket içindeki yol, gömülü kopyadaki yolla aynıdır
// (`<paket>/gorseller/x.webp` ↔ `assets/icerik/gorseller/x.webp`).

import 'dart:convert';
import 'dart:io';

/// Uygulamayla gelen, indirme gerektirmeyen bölümler (paket adıyla).
const gomuluBolumler = {'b01'};

/// İçerik (json), katman görselleri (webp) ve anlatım sesleri.
const _uzantilar = ['.json', '.webp', '.mp3', '.m4a', '.ogg'];
const _medya = ['.webp', '.mp3', '.m4a', '.ogg'];

const _gomuluHedef = 'app/assets/icerik';
const _paketHedef = 'app/android/paketler';

/// Bölüm dosya adından paket adı: `b02-fil-vakasi.json` → `b02`.
String paketAdi(String bolumDosyasi) => bolumDosyasi.split('/').last.split('-').first;

String _goreli(FileSystemEntity f, Directory kok) =>
    f.path.substring(kok.path.length + 1).replaceAll(r'\', '/');

/// Bir bölüm JSON'unun gönderme yaptığı medya dosyaları, `content/`e göre.
Set<String> bolumMedyasi(String json, String dil) {
  final sonuc = <String>{};
  void gez(Object? d, String? anahtar) {
    switch (d) {
      case Map<String, dynamic> m:
        m.forEach((k, v) => gez(v, k));
      case List<dynamic> l:
        for (final e in l) {
          gez(e, anahtar);
        }
      case String s when _medya.any(s.toLowerCase().endsWith):
        // Anlatım sesi dil başınadır, görseller ortak.
        sonuc.add(anahtar == 'anlatim' ? '$dil/ses/$s' : 'gorseller/$s');
    }
  }

  gez(jsonDecode(json), null);
  return sonuc;
}

void main() {
  final kaynak = Directory('content');
  if (!kaynak.existsSync()) {
    stderr.writeln('content/ bulunamadı; betiği depo kökünden çalıştır.');
    exit(2);
  }
  final gomulu = Directory(_gomuluHedef);
  final paketler = Directory(_paketHedef);
  for (final d in [gomulu, paketler]) {
    if (d.existsSync()) d.deleteSync(recursive: true);
  }

  // Hangi medya dosyasını hangi paketler kullanıyor.
  final kullanan = <String, Set<String>>{};
  for (final dil in kaynak.listSync().whereType<Directory>()) {
    final dilAdi = dil.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
    final bolumler = Directory('${dil.path}/bolumler');
    if (dilAdi == 'gorseller' || !bolumler.existsSync()) continue;
    for (final f in bolumler.listSync().whereType<File>()) {
      final ad = f.uri.pathSegments.last;
      if (!ad.endsWith('.json') || ad.startsWith('_')) continue;
      for (final m in bolumMedyasi(f.readAsStringSync(), dilAdi)) {
        (kullanan[m] ??= {}).add(paketAdi(ad));
      }
    }
  }

  // Henüz görsel ya da ses yokken de klasörler bulunmalı; pubspec bunları listeler.
  Directory('${gomulu.path}/gorseller/sahislar').createSync(recursive: true);
  Directory('${gomulu.path}/fon/muzik').createSync(recursive: true);
  Directory('${gomulu.path}/fon/ortam').createSync(recursive: true);
  for (final dil in kaynak.listSync().whereType<Directory>()) {
    final ad = dil.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
    if (ad == 'gorseller' || ad == 'fon') continue;
    Directory('${gomulu.path}/$ad/ses').createSync(recursive: true);
  }

  var gomuluSayi = 0;
  final paketSayilari = <String, int>{};
  final kullanilmayan = <String>[];
  void kopyala(File f, String hedef) {
    File(hedef).parent.createSync(recursive: true);
    f.copySync(hedef);
  }

  for (final varlik in kaynak.listSync(recursive: true)) {
    if (varlik is! File) continue;
    final yol = _goreli(varlik, kaynak);
    if (!_uzantilar.any(yol.toLowerCase().endsWith)) continue;
    // Üretim istemleri uygulamaya girmez.
    if (yol.contains('gorseller/istemler/') || yol.contains('ses/istemler/')) continue;

    final medya = _medya.any(yol.toLowerCase().endsWith) &&
        !yol.startsWith('gorseller/sahislar/') &&
        !yol.startsWith('fon/');
    final paketleri = kullanan[yol] ?? const <String>{};
    if (!medya || paketleri.any(gomuluBolumler.contains)) {
      kopyala(varlik, '${gomulu.path}/$yol');
      gomuluSayi++;
    } else if (paketleri.isEmpty) {
      kullanilmayan.add(yol);
    } else {
      for (final p in paketleri) {
        kopyala(varlik, '${paketler.path}/$p/src/main/assets/$p/$yol');
        paketSayilari[p] = (paketSayilari[p] ?? 0) + 1;
      }
    }
  }

  // Her paket bir Gradle asset pack modülüdür (settings.gradle.kts bunları bulur).
  for (final p in paketSayilari.keys) {
    File('${paketler.path}/$p/build.gradle.kts').writeAsStringSync('''
// tools/icerik_esitle.dart üretir; elle değiştirme.
plugins {
    id("com.android.asset-pack")
}

assetPack {
    packName.set("$p")
    // Elle kurulacak test APK'sı için: -PpaketTeslimi=install-time
    // (flutter build: --android-project-arg=paketTeslimi=install-time).
    dynamicDelivery {
        deliveryType.set(providers.gradleProperty("paketTeslimi").orElse("on-demand"))
    }
}
''');
  }

  // Paket boyutları (bayt): uygulama indirmeden önce gösterir.
  final boyutlar = {
    for (final p in paketSayilari.keys.toList()..sort())
      p: Directory('${paketler.path}/$p/src/main/assets')
          .listSync(recursive: true)
          .whereType<File>()
          .fold<int>(0, (t, f) => t + f.lengthSync()),
  };
  File('${gomulu.path}/paketler.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(boyutlar));

  stdout.writeln('$gomuluSayi dosya → ${gomulu.path}');
  for (final p in paketSayilari.keys.toList()..sort()) {
    stdout.writeln('${paketSayilari[p]} dosya → ${paketler.path}/$p');
  }
  if (kullanilmayan.isNotEmpty) {
    stdout.writeln('Hiçbir bölümün kullanmadığı ${kullanilmayan.length} dosya alınmadı: '
        '${kullanilmayan.take(5).join(', ')}${kullanilmayan.length > 5 ? ' …' : ''}');
  }
}
