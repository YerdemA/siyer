import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ayarlar/tercihler.dart';
import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../hata_bildir.dart';
import '../icerik/paketler.dart';
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
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(m.altyaziDili),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'tr', label: Text('Türkçe')),
                  ButtonSegment(value: 'en', label: Text('English')),
                ],
                selected: {tercih.altyaziDili},
                onSelectionChanged: (s) => depo.altyaziDiliSec(s.first),
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.queue_music_outlined),
            title: Text(m.fonSesi),
            subtitle: Text(m.fonSesiAciklama),
            value: tercih.fonSesi,
            onChanged: depo.fonSesiSec,
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
          const _IndirilenBolumler(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: Text(m.hataBildir),
            subtitle: Text(m.hataBildirAciklama),
            onTap: () => hataBildir(context),
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

/// İndirilmiş bölüm paketleri; her biri silinebilir (yeniden açılınca iner).
class _IndirilenBolumler extends ConsumerWidget {
  const _IndirilenBolumler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final dil = Localizations.localeOf(context).languageCode;
    final bolumler = ref.watch(bolumListesiProvider).value ?? const <Bolum>[];
    final boyutlar = ref.watch(paketBoyutlariProvider).value ?? const {};
    final inenler = [
      for (final b in bolumler)
        if (!gomuluPaketler.contains(paketAdi(b.id)) && ref.watch(paketDurumuProvider(b.id)) is PaketHazir) b,
    ];
    final toplam = inenler.fold<int>(0, (t, b) => t + (boyutlar[paketAdi(b.id)] ?? 0));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(
            toplam > 0 ? '${m.indirilenBolumler} · ${m.indirmeBoyutu(mbMetni(toplam, dil))}' : m.indirilenBolumler,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(m.indirilenBolumlerAciklama),
        ),
        if (inenler.isEmpty)
          ListTile(dense: true, title: Text(m.indirilenYok))
        else
          for (final b in inenler)
            ListTile(
              dense: true,
              title: Text('${m.bolumNo(b.sira)} · ${b.baslik}'),
              subtitle: switch (boyutlar[paketAdi(b.id)]) {
                final bayt? => Text(m.indirmeBoyutu(mbMetni(bayt, dil))),
                null => null,
              },
              trailing: IconButton(
                tooltip: m.sil,
                icon: const Icon(Icons.delete_outline),
                onPressed: () => ref.read(paketDurumlariProvider.notifier).sil(paketAdi(b.id)),
              ),
            ),
      ],
    );
  }
}
