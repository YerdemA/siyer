import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../l10n/app_localizations.dart';
import 'atif_listesi.dart';
import '../tema.dart';

class ZamanCizelgesiEkrani extends ConsumerWidget {
  const ZamanCizelgesiEkrani({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final olaylar = ref.watch(zamanCizelgesiProvider);
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(m.zamanCizelgesi)),
      body: olaylar.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) => ListView.builder(
          padding: altPayli(context, const EdgeInsets.symmetric(vertical: 8)),
          itemCount: liste.length,
          itemBuilder: (context, i) {
            final o = liste[i];
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 84,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, right: 8),
                      child: Text(
                        o.yaklasik ? m.yilYaklasik(o.yil) : m.yil(o.yil),
                        textAlign: TextAlign.end,
                        style: tema.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  // Çizelge çizgisi ve nokta.
                  SizedBox(
                    width: 24,
                    child: Stack(alignment: Alignment.topCenter, children: [
                      Positioned.fill(
                        child: Center(child: Container(width: 2, color: tema.dividerColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: CircleAvatar(radius: 6, backgroundColor: tema.colorScheme.primary),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o.olay),
                          const SizedBox(height: 4),
                          AtifListesi(iddialar: [if (o.iddia.isNotEmpty) o.iddia]),
                          if (o.bolum.isNotEmpty)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                onPressed: () => context.push('/bolum/${o.bolum}'),
                                icon: const Icon(Icons.play_circle_outline, size: 18),
                                label: Text(m.bolumeGit),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
