import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/paketler.dart';
import '../l10n/app_localizations.dart';
import '../tema.dart';

/// Bölümün paketi inmemişken oynatıcının yerinde durur. Açılınca indirmeyi
/// kendiliğinden başlatır (kullanıcı bölümü izlemek için dokundu); inince
/// [paketDurumuProvider] değişir ve oynatıcı açılır.
class BolumIndirme extends ConsumerStatefulWidget {
  const BolumIndirme({super.key, required this.bolumId});

  final String bolumId;

  @override
  ConsumerState<BolumIndirme> createState() => _BolumIndirmeState();
}

class _BolumIndirmeState extends ConsumerState<BolumIndirme> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(paketDurumuProvider(widget.bolumId), (_, d) {
      if (d is PaketYok) _indir();
    }, fireImmediately: true);
  }

  void _indir() => ref.read(paketDurumlariProvider.notifier).indir(paketAdi(widget.bolumId));

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final dil = Localizations.localeOf(context).languageCode;
    final durum = ref.watch(paketDurumuProvider(widget.bolumId));
    final bolum = ref.watch(bolumProvider(widget.bolumId)).value;
    final boyut = ref.watch(paketBoyutlariProvider).value?[paketAdi(widget.bolumId)];
    const acik = TextStyle(color: Palet.kagitAcik);

    final Widget govde = switch (durum) {
      PaketHatasi() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(m.indirmeHatasi, textAlign: TextAlign.center, style: acik),
            const SizedBox(height: 16),
            FilledButton(onPressed: _indir, child: Text(m.tekrarDene)),
          ],
        ),
      PaketBekliyor() => Text(m.indirmeBekliyor, textAlign: TextAlign.center, style: acik),
      PaketIniyor(:final oran, :final inen, :final toplam) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(m.indiriliyor, style: acik),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: oran,
              minHeight: 4,
              color: Palet.altin,
              backgroundColor: Palet.kagitAcik.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            const SizedBox(height: 8),
            Text(
              toplam > 0
                  ? m.indirmeIlerleme(mbMetni(inen, dil), mbMetni(toplam, dil))
                  : boyut != null
                      ? m.indirmeBoyutu(mbMetni(boyut, dil))
                      : '',
              style: TextStyle(fontSize: 12, color: Palet.kagitAcik.withValues(alpha: 0.75)),
            ),
          ],
        ),
      _ => const CircularProgressIndicator(color: Palet.altin),
    };

    return Scaffold(
      backgroundColor: Palet.gece,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Palet.kagitAcik,
        leading: BackButton(onPressed: () => context.canPop() ? context.pop() : context.go('/')),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (bolum != null) ...[
                  Text(m.bolumNo(bolum.sira), style: const TextStyle(color: Palet.altin, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    bolum.baslik,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: baslikYazisi,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Palet.kagitAcik,
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
                govde,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
