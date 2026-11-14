import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';

class BolumListesi extends ConsumerWidget {
  const BolumListesi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final bolumler = ref.watch(bolumListesiProvider);
    // İlerleme okunamazsa liste yine gösterilir; yalnız ilerleme bilgisi eksik kalır.
    final ilerleme = ref.watch(ilerlemeProvider).value ?? const {};
    return Scaffold(
      appBar: AppBar(
        title: Text(m.bolumler),
        actions: [
          IconButton(
            tooltip: m.harita,
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push('/harita'),
          ),
          IconButton(
            tooltip: m.zamanCizelgesi,
            icon: const Icon(Icons.timeline),
            onPressed: () => context.push('/zaman'),
          ),
          IconButton(
            tooltip: m.sahislar,
            icon: const Icon(Icons.people_outline),
            onPressed: () => context.push('/sahislar'),
          ),
          IconButton(
            tooltip: m.ayarlar,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/ayarlar'),
          ),
        ],
      ),
      body: bolumler.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) => liste.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(m.bolumYok, textAlign: TextAlign.center),
                ),
              )
            : ListView.separated(
                itemCount: liste.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final b = liste[i];
                  final il = ilerleme[b.id];
                  final toplam = b.sahneler.length;
                  final devamEdiyor = il != null && !il.bitti && il.sonSahne > 1;
                  return ListTile(
                    leading: CircleAvatar(
                      child: il?.bitti == true
                          ? Icon(Icons.check, semanticLabel: m.tamamlandi)
                          : Text('${b.sira}'),
                    ),
                    title: Text(b.baslik),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.ozet, maxLines: 2, overflow: TextOverflow.ellipsis),
                        if (devamEdiyor && toplam > 0) ...[
                          const SizedBox(height: 6),
                          LinearProgressIndicator(value: (il.sonSahne - 1) / toplam),
                          const SizedBox(height: 4),
                          Text(m.kaldiginYer(il.sonSahne, toplam),
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ],
                    ),
                    trailing: b.durum == 'taslak' ? Chip(label: Text(m.taslak)) : null,
                    // Sahne verilmez: oynatıcı kayıtlı ilerlemeden başlar.
                    onTap: () => context.push('/bolum/${b.id}'),
                  );
                },
              ),
      ),
    );
  }
}
