import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'bolum_yolu.dart';
import 'harita.dart';
import 'sahislar.dart';

/// Açılış ekranı: alt sekmelerle Bölümler (yol haritası), Harita ve Şahıslar.
/// Harita ve şahıslar bölüm izlenmeden de açılabilir; şahıslar izlenen
/// sahnelere göre çoğalır.
class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, this.sekme = 0});

  final int sekme;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late int _sekme = widget.sekme;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    return Scaffold(
      body: IndexedStack(
        index: _sekme,
        children: const [BolumYolu(), HaritaEkrani(), SahislarEkrani()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _sekme,
        onDestinationSelected: (i) => setState(() => _sekme = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.auto_stories_outlined),
            selectedIcon: const Icon(Icons.auto_stories),
            label: m.bolumler,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map),
            label: m.harita,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline),
            selectedIcon: const Icon(Icons.people),
            label: m.sahislar,
          ),
        ],
      ),
    );
  }
}
