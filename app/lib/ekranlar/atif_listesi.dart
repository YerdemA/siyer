import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../l10n/app_localizations.dart';

/// Verilen iddiaların atıfları. Hiç atıf bulunamazsa "kaynak bekliyor" yazar:
/// kaynaksız tarihî bilgi düz metin gibi sunulmaz (docs/KAYNAK_POLITIKASI.md).
class AtifListesi extends ConsumerWidget {
  const AtifListesi({super.key, required this.iddialar});

  final List<String> iddialar;

  /// Kayıtta tanımlı ve en az bir atfı olan iddia var mı.
  static bool kaynakli(List<String> iddialar, Map<String, Iddia> dizin) =>
      iddialar.any((i) => dizin[i]?.kaynaklar.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final dizin = ref.watch(iddiaDiziniProvider).value ?? const {};
    final kaynakca = ref.watch(kaynakcaProvider).value ?? const {};
    final soluk = Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor);
    final gorulen = <String>{};
    final atiflar = [
      for (final i in iddialar)
        for (final a in dizin[i]?.kaynaklar ?? const <Atif>[])
          if (gorulen.add('${a.eser}|${a.konum}')) a,
    ];
    if (atiflar.isEmpty) return Text(m.kaynakBekliyor, style: soluk);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final a in atiflar)
          Text.rich(
            TextSpan(children: [
              TextSpan(text: '${kaynakca[a.eser]?.kunye ?? a.eser}, ${a.konum.isEmpty ? '—' : a.konum}'),
              if (!a.dogrulandi) TextSpan(text: '  (${m.dogrulamaBekliyor})', style: soluk),
            ]),
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}
