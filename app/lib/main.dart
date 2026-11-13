import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'ekranlar/bolum_listesi.dart';
import 'l10n/app_localizations.dart';
import 'oynatici/oynatici_ekrani.dart';

void main() => runApp(const ProviderScope(child: Uygulama()));

final _yonlendirici = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const BolumListesi()),
    GoRoute(
      path: '/bolum/:id',
      // ?sahne=7 → doğrudan 7. sahneden başlar (revize için).
      builder: (_, durum) => OynaticiEkrani(
        bolumId: durum.pathParameters['id']!,
        baslangicSahnesi: int.tryParse(durum.uri.queryParameters['sahne'] ?? '') ?? 1,
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B6B4A),
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
