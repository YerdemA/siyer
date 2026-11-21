import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ayarlar/tercihler.dart';
import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';

class AyarlarEkrani extends ConsumerWidget {
  const AyarlarEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final kaynakca = ref.watch(kaynakcaProvider);
    final tercih = ref.watch(tercihlerProvider).value ?? const Tercihler();
    final depo = ref.read(tercihlerProvider.notifier);
    final tema = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(m.ayarlar)),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.subtitles_outlined),
            title: Text(m.altyazi),
            subtitle: Text(m.altyaziAciklama),
            value: tercih.altyaziAcik,
            onChanged: depo.altyaziAcikSec,
          ),
          ListTile(
            leading: const Icon(Icons.format_size),
            title: Text(m.altyaziBoyutu),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SegmentedButton<AltyaziBoyutu>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(value: AltyaziBoyutu.kucuk, label: Text(m.boyutKucuk)),
                  ButtonSegment(value: AltyaziBoyutu.orta, label: Text(m.boyutOrta)),
                  ButtonSegment(value: AltyaziBoyutu.buyuk, label: Text(m.boyutBuyuk)),
                ],
                selected: {tercih.altyazi},
                onSelectionChanged: (s) => depo.altyaziSec(s.first),
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.music_note_outlined),
            title: Text(m.efektSesleri),
            subtitle: Text(m.efektSesleriAciklama),
            value: tercih.efektSesleri,
            onChanged: depo.efektSesleriSec,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.motion_photos_off_outlined),
            title: Text(m.hareketiAzalt),
            subtitle: Text(m.hareketiAzaltAciklama),
            value: tercih.hareketiAzalt,
            onChanged: depo.hareketiAzaltSec,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restart_alt),
            title: Text(m.ilerlemeyiSifirla),
            onTap: () => _sifirlaSor(context, ref),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(m.hakkinda, style: tema.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(m.hakkindaMetni),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(m.kaynakca, style: tema.titleMedium),
          ),
          ...kaynakca.when(
            loading: () => [const Center(child: CircularProgressIndicator())],
            error: (e, _) => [ListTile(title: Text(m.yuklemeHatasi('$e')))],
            data: (k) => _kaynakcaSatirlari(context, k.values.toList()),
          ),
        ],
      ),
    );
  }

  List<Widget> _kaynakcaSatirlari(BuildContext context, List<Eser> eserler) {
    final m = Metinler.of(context);
    eserler.sort((a, b) {
      final k = a.katman.compareTo(b.katman);
      return k != 0 ? k : a.kunye.compareTo(b.kunye);
    });
    return [
      for (final e in eserler)
        ListTile(
          key: ValueKey('eser-${e.id}'),
          dense: true,
          title: Text(e.kunye),
          subtitle: Text([
            if (e.baski.isNotEmpty) e.baski,
            if (e.katman.isNotEmpty) m.kaynakKatmani(e.katman),
            if (e.webAdresi.isNotEmpty) e.webAdresi,
          ].join('\n')),
        ),
    ];
  }

  Future<void> _sifirlaSor(BuildContext context, WidgetRef ref) async {
    final m = Metinler.of(context);
    final onay = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(m.ilerlemeSifirlaOnay),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(m.iptal)),
          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(m.sifirla)),
        ],
      ),
    );
    if (onay == true) await ref.read(ilerlemeProvider.notifier).sifirla();
  }
}
