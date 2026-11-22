import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'ekranlar/ana_sayfa.dart';
import 'ekranlar/ayarlar.dart';
import 'ekranlar/harita.dart';
import 'ekranlar/sahislar.dart';
import 'ekranlar/zaman_cizelgesi.dart';
import 'l10n/app_localizations.dart';
import 'oynatici/oynatici_ekrani.dart';
import 'tema.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Oynatıcı dışındaki bütün ekranlar dikey (Erdem, 2026-11-22); oynatıcı
  // açılınca yataya geçer, kapanınca dikeye döner.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: Uygulama()));
}

final _yonlendirici = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const AnaSayfa()),
    GoRoute(path: '/ayarlar', builder: (_, _) => const AyarlarEkrani()),
    GoRoute(path: '/sahislar', builder: (_, _) => const SahislarEkrani()),
    GoRoute(
      path: '/sahislar/:id',
      builder: (_, durum) => SahisEkrani(sahisId: durum.pathParameters['id']!),
    ),
    GoRoute(path: '/harita', builder: (_, _) => const HaritaEkrani()),
    GoRoute(
      path: '/harita/:bolge',
      builder: (_, durum) => HaritaEkrani(bolge: durum.pathParameters['bolge']!),
    ),
    GoRoute(path: '/zaman', builder: (_, _) => const ZamanCizelgesiEkrani()),
    GoRoute(
      path: '/bolum/:id',
      // ?sahne=7 → doğrudan 7. sahneden başlar (revize için).
      builder: (_, durum) => OynaticiEkrani(
        bolumId: durum.pathParameters['id']!,
        // Verilmezse kayıtlı ilerlemeden başlanır.
        baslangicSahnesi: int.tryParse(durum.uri.queryParameters['sahne'] ?? ''),
        // ?cekim=2 → sahnenin 2. çekiminden; ?dur=1 → durmuş açılır.
        baslangicCekimi: int.tryParse(durum.uri.queryParameters['cekim'] ?? '') ?? 1,
        duraklatilmis: durum.uri.queryParameters['dur'] == '1',
      ),
    ),
  ],
);

class Uygulama extends StatelessWidget {
  const Uygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => Metinler.of(context).uygulamaAdi,
      routerConfig: _yonlendirici,
      locale: const Locale('tr'),
      supportedLocales: Metinler.supportedLocales,
      localizationsDelegates: const [
        Metinler.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: uygulamaTemasi(),
    );
  }
}
