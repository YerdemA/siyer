import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../l10n/app_localizations.dart';
import 'atif_listesi.dart';

/// Şahıslar sözlüğü. Özet tarihî bilgi olduğundan kaynaksız kayıtta özetin
/// yanında "kaynak bekliyor" görünür.
class SahislarEkrani extends ConsumerWidget {
  const SahislarEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final sahislar = ref.watch(sahislarProvider);
    return Scaffold(
      appBar: AppBar(title: Text(m.sahislar)),
      body: sahislar.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) => ListView.separated(
          itemCount: liste.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final s = liste[i];
            return ListTile(
              title: Text(s.ad),
              subtitle: s.lakap.isEmpty && s.yakinlik.isEmpty
                  ? null
                  : Text([s.lakap, s.yakinlik].where((x) => x.isNotEmpty).join(' · ')),
              onTap: () => context.push('/sahislar/${s.id}'),
            );
          },
        ),
      ),
    );
  }
}

class SahisEkrani extends ConsumerWidget {
  const SahisEkrani({super.key, required this.sahisId});

  final String sahisId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final sahislar = ref.watch(sahislarProvider).value;
    final dizin = ref.watch(iddiaDiziniProvider).value ?? const {};
    final bolumler = ref.watch(bolumListesiProvider).value ?? const <Bolum>[];
    final s = sahislar?.where((x) => x.id == sahisId).firstOrNull;
    if (sahislar == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (s == null) {
      return Scaffold(appBar: AppBar(), body: Center(child: Text(m.bulunamadi)));
    }
    final tema = Theme.of(context).textTheme;
    final kaynakli = AtifListesi.kaynakli(s.iddialar, dizin);
    return Scaffold(
      appBar: AppBar(title: Text(s.ad)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (s.lakap.isNotEmpty) Text(s.lakap, style: tema.titleMedium),
          if (s.yakinlik.isNotEmpty) Text(s.yakinlik, style: tema.bodyMedium),
          if (s.ozet.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(s.ozet, style: kaynakli ? null : tema.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
          ],
          const SizedBox(height: 16),
          Text(m.kaynaklar, style: tema.titleSmall),
          const SizedBox(height: 4),
          AtifListesi(iddialar: s.iddialar),
          if (s.bolumler.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(m.bolumler, style: tema.titleSmall),
            for (final id in s.bolumler)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.play_circle_outline),
                title: Text(bolumler.where((b) => b.id == id).firstOrNull?.baslik ?? id),
                onTap: () => context.push('/bolum/$id'),
              ),
          ],
        ],
      ),
    );
  }
}
