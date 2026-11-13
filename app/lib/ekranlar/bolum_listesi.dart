import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../l10n/app_localizations.dart';

class BolumListesi extends ConsumerWidget {
  const BolumListesi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final bolumler = ref.watch(bolumListesiProvider);
    return Scaffold(
      appBar: AppBar(title: Text(m.bolumler)),
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
                  return ListTile(
                    leading: CircleAvatar(child: Text('${b.sira}')),
                    title: Text(b.baslik),
                    subtitle: Text(b.ozet, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: b.durum == 'taslak' ? Chip(label: Text(m.taslak)) : null,
                    onTap: () => context.push('/bolum/${b.id}'),
                  );
                },
              ),
      ),
    );
  }
}
