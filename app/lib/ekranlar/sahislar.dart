import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../ilerleme/gorulenler.dart';
import '../l10n/app_localizations.dart';
import '../tema.dart';
import 'atif_listesi.dart';
import 'sahis_madalyonu.dart';

/// Şahıslar sözlüğü. Yalnız izlenen sahnelerde geçen şahıslar listelenir
/// ([gorulenSahislarProvider]); hiç bölüm izlenmemişse yalnız Efendimiz.
/// Özet tarihî bilgi olduğundan kaynaksız kayıtta özetin yanında "kaynak
/// bekliyor" görünür.
class SahislarEkrani extends ConsumerStatefulWidget {
  const SahislarEkrani({super.key});

  @override
  ConsumerState<SahislarEkrani> createState() => _SahislarEkraniState();
}

class _SahislarEkraniState extends ConsumerState<SahislarEkrani> {
  String _arama = '';

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final sahislar = ref.watch(sahislarProvider);
    final gorulen = ref.watch(gorulenSahislarProvider);
    return Scaffold(
      appBar: AppBar(title: Text(m.sahislar)),
      body: sahislar.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(m.yuklemeHatasi('$e'))),
        data: (liste) {
          final acik = [for (final s in liste) if (gorulen.contains(s.id)) s];
          final aranan = sadelestir(_arama);
          final gorunen = aranan.isEmpty
              ? acik
              : [
                  for (final s in acik)
                    if (sadelestir('${s.ad} ${s.lakap} ${s.yakinlik}').contains(aranan)) s,
                ];
          final kapali = liste.length - acik.length;
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: gorunen.length + 2,
            separatorBuilder: (_, i) => i == 0 ? const SizedBox.shrink() : const Divider(height: 1, indent: 76),
            itemBuilder: (context, i) {
              if (i == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    onChanged: (v) => setState(() => _arama = v),
                    decoration: InputDecoration(
                      hintText: m.sahisAra,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Palet.kagitAcik,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Palet.kagitKoyu),
                      ),
                    ),
                  ),
                );
              }
              if (i == gorunen.length + 1) {
                final tema = Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Palet.murekkepSoluk,
                      fontStyle: FontStyle.italic,
                    );
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: Column(
                    children: [
                      if (gorunen.isEmpty) Text(m.sahisAramaBos, style: tema, textAlign: TextAlign.center),
                      if (kapali > 0) ...[
                        const SizedBox(height: 8),
                        Text(m.sahisKilitNotu(kapali), style: tema, textAlign: TextAlign.center),
                      ],
                    ],
                  ),
                );
              }
              final s = gorunen[i - 1];
              final alt = [s.lakap, s.yakinlik].where((x) => x.isNotEmpty).join(' · ');
              return ListTile(
                leading: SahisMadalyonu(sahis: s),
                title: Text(s.ad, style: const TextStyle(fontFamily: baslikYazisi, fontWeight: FontWeight.w600)),
                subtitle: alt.isEmpty ? null : Text(alt),
                onTap: () => context.push('/sahislar/${s.id}'),
              );
            },
          );
        },
      ),
    );
  }
}

/// Aramada Türkçe ve transkripsiyon işaretlerini yok sayar (ör. "ebu talib"
/// → "Ebû Tâlib").
String sadelestir(String s) {
  const harfler = {
    'â': 'a', 'î': 'i', 'û': 'u', 'ı': 'i', 'ş': 's', 'ç': 'c', 'ğ': 'g', 'ö': 'o', 'ü': 'u',
    'Â': 'a', 'Î': 'i', 'Û': 'u', 'İ': 'i', 'I': 'i', 'Ş': 's', 'Ç': 'c', 'Ğ': 'g', 'Ö': 'o', 'Ü': 'u',
  };
  final b = StringBuffer();
  for (final h in s.characters) {
    final y = harfler[h] ?? h.toLowerCase();
    if (y == "'" || y == '’' || y == '‘' || y == '.') continue;
    b.write(y);
  }
  return b.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
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
          Center(child: SahisMadalyonu(sahis: s, boyut: 148)),
          const SizedBox(height: 12),
          Text(
            s.ad,
            textAlign: TextAlign.center,
            style: tema.headlineSmall?.copyWith(fontFamily: baslikYazisi, fontWeight: FontWeight.w700),
          ),
          if (s.lakap.isNotEmpty) Text(s.lakap, textAlign: TextAlign.center, style: tema.titleMedium),
          if (s.yakinlik.isNotEmpty) Text(s.yakinlik, textAlign: TextAlign.center, style: tema.bodyMedium),
          if (s.ozet.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(s.ozet, style: kaynakli ? tema.bodyLarge : tema.bodyLarge?.copyWith(fontStyle: FontStyle.italic)),
          ],
          if (ilkGorunus(bolumler, s.id) case final ilk?)
            Card(
              margin: const EdgeInsets.only(top: 16),
              color: Palet.kagitAcik,
              child: ListTile(
                leading: const Icon(Icons.place_outlined, color: Palet.kina),
                title: Text(m.ilkGorundugu),
                subtitle: Text(m.ilkGorunduguAyrinti(
                  '${m.bolumNo(ilk.bolum.sira)} · ${ilk.bolum.baslik}',
                  ilk.sahne,
                )),
                trailing: const Icon(Icons.play_circle_outline),
                onTap: () => context.push('/bolum/${ilk.bolum.id}?sahne=${ilk.sahne}'),
              ),
            ),
          const SizedBox(height: 16),
          Text(m.kaynaklar, style: tema.titleSmall),
          const SizedBox(height: 4),
          AtifListesi(iddialar: s.iddialar),
          if (s.bolumler.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(m.bolumler, style: tema.titleSmall),
            for (final b in bolumler.where((b) => s.bolumler.contains(b.id)))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.play_circle_outline),
                title: Text(b.baslik),
                onTap: () => context.push('/bolum/${b.id}'),
              ),
          ],
        ],
      ),
    );
  }
}
