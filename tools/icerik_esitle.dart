// İçeriği uygulamanın asset klasörüne kopyalar.
//
// Kullanım (depo kökünden):
//   dart run tools/icerik_esitle.dart
//
// Flutter yalnız kendi proje klasörü içindeki dosyaları paketleyebildiği için
// `content/` klasörü `app/assets/icerik/` altına aynen kopyalanır. Hedef klasör
// her seferinde silinip yeniden yazılır ve git'e girmez. İçerik değiştikten
// sonra uygulamayı çalıştırmadan önce bu betiği çalıştır.

import 'dart:io';

void main() {
  final kaynak = Directory('content');
  final hedef = Directory('app/assets/icerik');
  if (!kaynak.existsSync()) {
    stderr.writeln('content/ bulunamadı; betiği depo kökünden çalıştır.');
    exit(2);
  }
  if (hedef.existsSync()) hedef.deleteSync(recursive: true);

  // Henüz görsel yokken de klasör bulunmalı; pubspec bu klasörü listeler.
  Directory('${hedef.path}/gorseller').createSync(recursive: true);

  var sayi = 0;
  for (final varlik in kaynak.listSync(recursive: true)) {
    if (varlik is! File) continue;
    if (!varlik.path.endsWith('.json') && !varlik.path.endsWith('.webp')) continue;
    // Üretim istemleri uygulamaya girmez.
    if (varlik.path.replaceAll(r'\', '/').contains('gorseller/istemler/')) continue;
    final goreli = varlik.path.substring(kaynak.path.length + 1);
    final yeni = File('${hedef.path}/$goreli');
    yeni.parent.createSync(recursive: true);
    varlik.copySync(yeni.path);
    sayi++;
  }
  stdout.writeln('$sayi dosya → ${hedef.path}');
}
