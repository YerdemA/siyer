import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';

/// Uygulamanın sürümü; `pubspec.yaml`'daki `version` ile aynı olmalı
/// (test denetler). Hata bildirimine eklenir.
const uygulamaSurumu = '1.0.0+2';

/// Bildirimlerin gittiği adres (gizlilik sayfasındaki iletişim adresi).
const hataBildirimAdresi = 'yusuferdemaykacc@gmail.com';

/// Bildirime eklenen bilgi satırları: nerede görüldüğü ve cihaz.
/// Kişisel bilgi yok; kullanıcı göndermeden önce görür ve silebilir.
String hataBilgisi({
  required String dil,
  String? bolum,
  String? sahne,
  double? saniye,
}) {
  String sure(double s) => '${s ~/ 60}:${(s.floor() % 60).toString().padLeft(2, '0')}';
  return [
    'Sürüm: $uygulamaSurumu',
    'Dil: $dil',
    if (bolum != null) 'Bölüm: $bolum',
    if (sahne != null) 'Sahne: $sahne',
    if (saniye != null) 'Bölüm zamanı: ${sure(saniye)}',
  ].join('\n');
}

/// Hazır konu ve bilgiyle kullanıcının e-posta uygulamasını açar; açılamazsa
/// adresi gösterir.
Future<void> hataBildir(
  BuildContext context, {
  String? bolum,
  String? sahne,
  double? saniye,
}) async {
  final m = Metinler.of(context);
  final dil = Localizations.localeOf(context).languageCode;
  final mesaj = ScaffoldMessenger.maybeOf(context);
  final uri = Uri(
    scheme: 'mailto',
    path: hataBildirimAdresi,
    // queryParameters '+' ile kodlar; e-posta uygulamaları onu boşluk saymaz.
    query: _sorgu({
      'subject': m.hataBildirKonu,
      'body': m.hataBildirGovde(hataBilgisi(dil: dil, bolum: bolum, sahne: sahne, saniye: saniye)),
    }),
  );
  var acildi = false;
  try {
    acildi = await launchUrl(uri);
  } catch (_) {}
  if (!acildi) {
    mesaj?.showSnackBar(SnackBar(
      content: Text(m.hataBildirAcilamadi(hataBildirimAdresi)),
      duration: const Duration(seconds: 8),
    ));
  }
}

String _sorgu(Map<String, String> p) =>
    p.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');
