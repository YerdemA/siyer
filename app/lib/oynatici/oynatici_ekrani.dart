import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';
import 'gorsel_onbellek.dart';
import 'sahne_cizici.dart';
import 'zaman_plani.dart';

class OynaticiEkrani extends ConsumerWidget {
  const OynaticiEkrani({super.key, required this.bolumId, this.baslangicSahnesi});

  final String bolumId;

  /// 1'den başlar. Verilmezse kayıtlı ilerlemeden (yoksa baştan) başlanır.
  final int? baslangicSahnesi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final bolum = ref.watch(bolumProvider(bolumId));
    final kaynakca = ref.watch(kaynakcaProvider);
    // Yalnız açılışta okunur: oynarken her kayıtta oynatıcı yeniden kurulmasın.
    final ilerleme = ref.watch(ilerlemeProvider.select((d) => d.whenData((_) => true)));
    final notifier = ref.read(ilerlemeProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.black,
      body: switch ((bolum, kaynakca, ilerleme)) {
        (AsyncData(value: final b), AsyncData(value: final k), AsyncData() || AsyncError()) =>
          Oynatici(
            bolum: b,
            kaynakca: k,
            baslangicSahnesi: baslangicSahnesi ??
                ref.read(ilerlemeProvider).value?[bolumId]?.devamSahnesi ??
                1,
            sahneDegisti: (no) => notifier.sahneKaydet(bolumId, no),
            bitti: () => notifier.bitir(bolumId),
          ),
        (AsyncError(:final error), _, _) || (_, AsyncError(:final error), _) =>
          Center(child: Text(m.yuklemeHatasi('$error'), style: const TextStyle(color: Colors.white))),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class Oynatici extends StatefulWidget {
  const Oynatici({
    super.key,
    required this.bolum,
    required this.kaynakca,
    this.baslangicSahnesi = 1,
    this.sahneDegisti,
    this.bitti,
  });

  final Bolum bolum;
  final Map<String, Eser> kaynakca;
  final int baslangicSahnesi;

  /// Görünen sahne değişince (1'den başlayan numarayla) çağrılır.
  final ValueChanged<int>? sahneDegisti;

  /// Bölüm sonuna gelinince bir kez çağrılır.
  final VoidCallback? bitti;

  @override
  State<Oynatici> createState() => _OynaticiState();
}

class _OynaticiState extends State<Oynatici> with SingleTickerProviderStateMixin {
  late final ZamanPlani _plan = ZamanPlani.olustur(widget.bolum);
  late final Ticker _ticker;
  Duration _oncekiTik = Duration.zero;
  double _an = 0;
  bool _oynuyor = true;
  bool _kontroller = true;
  bool _tarif = false;
  bool _altyazi = true;
  final _gorseller = GorselOnbellek();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final i = (widget.baslangicSahnesi - 1).clamp(0, _plan.sahneler.length - 1);
    _an = _plan.sahneler[i].bas;
    _ticker = createTicker(_tik)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _gorseller.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _tik(Duration gecen) {
    final dt = (gecen - _oncekiTik).inMicroseconds / 1e6;
    _oncekiTik = gecen;
    if (!_oynuyor) return;
    setState(() {
      _an = math.min(_an + dt, _plan.toplam);
      if (_an >= _plan.toplam) _oynuyor = false;
    });
  }

  void _git(double an) => setState(() => _an = an.clamp(0.0, _plan.toplam));

  void _sahneyeGit(int fark) {
    final i = (_plan.sahneSirasi(_an) + fark).clamp(0, _plan.sahneler.length - 1);
    _git(_plan.sahneler[i].bas + (i == 0 ? 0 : 0.01));
  }

  bool get _bitti => _an >= _plan.toplam;

  int? _bildirilenSahne;
  bool _bitisBildirildi = false;

  /// İlerleme kaydı build sırasında değil, kare bittikten sonra yapılır.
  void _ilerlemeBildir(int sahneNo) {
    final sahneDegisti = sahneNo != _bildirilenSahne;
    final yeniBitis = _bitti && !_bitisBildirildi;
    if (!sahneDegisti && !yeniBitis) return;
    _bildirilenSahne = sahneNo;
    if (yeniBitis) _bitisBildirildi = true;
    if (!_bitti) _bitisBildirildi = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (sahneDegisti) widget.sahneDegisti?.call(sahneNo);
      if (yeniBitis) widget.bitti?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final konum = _plan.konum(_an);
    _ilerlemeBildir(konum.sahne.sira + 1);
    // Bulunulan ve sıradaki sahnenin görselleri önceden yüklenir.
    _gorseller.onYukle(konum.sahne.sahne);
    final sonraki = konum.sahne.sira + 1;
    if (sonraki < _plan.sahneler.length) _gorseller.onYukle(_plan.sahneler[sonraki].sahne);
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _kontroller = !_kontroller),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: SahneCizici(
                  sahne: konum.sahne.sahne,
                  ilerleme: konum.ilerleme,
                  zaman: _an,
                  gorseller: _gorseller,
                ),
              ),
              if (konum.gelen != null)
                Opacity(
                  opacity: konum.gecisOrani,
                  child: CustomPaint(
                    painter: SahneCizici(
                      sahne: konum.gelen!.sahne,
                      ilerleme: konum.gelenIlerleme,
                      zaman: _an,
                      gorseller: _gorseller,
                    ),
                  ),
                ),
              if (_altyazi && konum.parca != null) _Altyazi(parca: konum.parca!, an: _an),
              if (_tarif) _TarifPaneli(sahne: konum.sahne.sahne),
              if (_kontroller && !_bitti) _kontrolCubugu(context, konum),
              if (_bitti)
                _BolumSonu(
                  bolum: widget.bolum,
                  kaynakca: widget.kaynakca,
                  yenidenOynat: () => setState(() {
                    _an = 0;
                    _oynuyor = true;
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sahnede geçen şahıslar; birine dokununca sözlükteki sayfası açılır.
  /// Oynatma duraklatılır, dönüşte kullanıcı kendisi sürdürür.
  void _sahislariGoster(BuildContext context, List<String> kimlikler) {
    setState(() => _oynuyor = false);
    showModalBottomSheet<void>(
      context: context,
      builder: (c) => Consumer(
        builder: (c, ref, _) {
          final sahislar = ref.watch(sahislarProvider).value ?? const <Sahis>[];
          return ListView(
            shrinkWrap: true,
            children: [
              for (final id in kimlikler)
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(sahislar.where((s) => s.id == id).firstOrNull?.ad ?? id),
                  onTap: () {
                    Navigator.pop(c);
                    context.push('/sahislar/$id');
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _kontrolCubugu(BuildContext context, Konum konum) {
    final m = Metinler.of(context);
    const beyaz = Colors.white;
    final sahneNo = konum.sahne.sira + 1;
    return Stack(
      children: [
        Positioned(
          left: 8,
          top: 8,
          right: 8,
          child: Row(
            children: [
              IconButton(
                tooltip: m.geri,
                color: beyaz,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '${widget.bolum.baslik} · ${m.sahneSayaci(sahneNo, _plan.sahneler.length)} · ${konum.sahne.sahne.id}',
                  style: const TextStyle(color: beyaz, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  [if (konum.sahne.sahne.gorsel.yerTutucuVar) m.yerTutucuUyari, m.sesYok].join(' '),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xCC000000), Color(0x00000000)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 4),
              child: Row(
                children: [
                  IconButton(
                    tooltip: m.oncekiSahne,
                    color: beyaz,
                    icon: const Icon(Icons.skip_previous),
                    onPressed: () => _sahneyeGit(-1),
                  ),
                  IconButton(
                    tooltip: _oynuyor ? m.duraklat : m.oynat,
                    color: beyaz,
                    icon: Icon(_oynuyor ? Icons.pause : Icons.play_arrow),
                    onPressed: () => setState(() => _oynuyor = !_oynuyor),
                  ),
                  IconButton(
                    tooltip: m.sonrakiSahne,
                    color: beyaz,
                    icon: const Icon(Icons.skip_next),
                    onPressed: () => _sahneyeGit(1),
                  ),
                  Expanded(child: _IlerlemeCubugu(plan: _plan, an: _an, git: _git)),
                  Text(
                    '${_sure(_an)} / ${_sure(_plan.toplam)}',
                    style: const TextStyle(color: beyaz, fontSize: 12),
                  ),
                  IconButton(
                    tooltip: m.altyazi,
                    color: _altyazi ? beyaz : Colors.white38,
                    icon: const Icon(Icons.subtitles_outlined),
                    onPressed: () => setState(() => _altyazi = !_altyazi),
                  ),
                  if (konum.sahne.sahne.sahislar.isNotEmpty)
                    IconButton(
                      tooltip: m.sahislar,
                      color: beyaz,
                      icon: const Icon(Icons.people_outline),
                      onPressed: () => _sahislariGoster(context, konum.sahne.sahne.sahislar),
                    ),
                  IconButton(
                    tooltip: m.tarifGoster,
                    color: _tarif ? const Color(0xFFF2C46B) : beyaz,
                    icon: const Icon(Icons.description_outlined),
                    onPressed: () => setState(() => _tarif = !_tarif),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String _sure(double sn) {
    final s = sn.floor();
    return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
  }
}

/// Sahne sınırları işaretli ilerleme çubuğu.
class _IlerlemeCubugu extends StatelessWidget {
  const _IlerlemeCubugu({required this.plan, required this.an, required this.git});

  final ZamanPlani plan;
  final double an;
  final ValueChanged<double> git;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, kisit) {
        final gen = kisit.maxWidth;
        void dokun(Offset yerel) => git(yerel.dx / gen * plan.toplam);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => dokun(d.localPosition),
          onHorizontalDragUpdate: (d) => dokun(d.localPosition),
          child: SizedBox(
            height: 32,
            child: CustomPaint(painter: _CubukCizici(plan, an)),
          ),
        );
      },
    );
  }
}

class _CubukCizici extends CustomPainter {
  _CubukCizici(this.plan, this.an);
  final ZamanPlani plan;
  final double an;

  @override
  void paint(Canvas c, Size s) {
    final y = s.height / 2;
    final boya = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    c.drawLine(Offset(0, y), Offset(s.width, y), boya..color = Colors.white24);
    final x = an / plan.toplam * s.width;
    c.drawLine(Offset(0, y), Offset(x, y), boya..color = const Color(0xFFF2C46B));
    final isaret = Paint()..color = Colors.white54;
    for (final sz in plan.sahneler.skip(1)) {
      final sx = sz.bas / plan.toplam * s.width;
      c.drawRect(Rect.fromCenter(center: Offset(sx, y), width: 2, height: 10), isaret);
    }
    c.drawCircle(Offset(x, y), 6, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_CubukCizici e) => e.an != an;
}

class _Altyazi extends StatelessWidget {
  const _Altyazi({required this.parca, required this.an});

  final ParcaZamani parca;
  final double an;

  @override
  Widget build(BuildContext context) {
    // Cümle başında ve sonunda kısa yumuşak geçiş.
    final gorunur = math.min(
      ((an - parca.bas) / 0.3).clamp(0.0, 1.0),
      ((parca.son - an) / 0.3 + 0.4).clamp(0.0, 1.0),
    );
    return Positioned(
      left: 0,
      right: 0,
      bottom: 64,
      child: Opacity(
        opacity: gorunur,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 720),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0x99000000),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              parca.parca.metin,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFF4EEE2), fontSize: 18, height: 1.35),
            ),
          ),
        ),
      ),
    );
  }
}

/// Revize için: sahnenin içerikteki görsel tarifi, kamerası ve katmanları.
class _TarifPaneli extends StatelessWidget {
  const _TarifPaneli({required this.sahne});

  final Sahne sahne;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final g = sahne.gorsel;
    const stil = TextStyle(color: Colors.white, fontSize: 12, height: 1.35);
    return Positioned(
      left: 12,
      top: 56,
      width: 340,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xD0101010),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0x55F2C46B)),
        ),
        child: DefaultTextStyle(
          style: stil,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(sahne.id, style: const TextStyle(color: Color(0xFFF2C46B), fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(g.tarif),
              const SizedBox(height: 6),
              Text('${m.kamera}: ${g.kamera} · ${m.saat}: ${g.saat}'),
              Text('${m.katmanlar}: ${g.katmanlar.map((k) => '${k.yerTutucu}(${k.derinlik})').join(', ')}',
                  style: const TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BolumSonu extends StatelessWidget {
  const _BolumSonu({required this.bolum, required this.kaynakca, required this.yenidenOynat});

  final Bolum bolum;
  final Map<String, Eser> kaynakca;
  final VoidCallback yenidenOynat;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final atiflar = bolum.tumAtiflar;
    return ColoredBox(
      color: const Color(0xE6120E0B),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 20, 32, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: m.geri,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text('${m.bolumSonu} · ${m.kaynaklar}',
                      style: const TextStyle(color: Color(0xFFF2C46B), fontSize: 18)),
                ),
                TextButton.icon(
                  onPressed: yenidenOynat,
                  icon: const Icon(Icons.replay),
                  label: Text(m.yenidenOynat),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: atiflar.length,
                itemBuilder: (context, i) {
                  final a = atiflar[i];
                  final eser = kaynakca[a.eser]?.kunye ?? a.eser;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: '$eser, ${a.konum}'),
                        if (!a.dogrulandi)
                          TextSpan(
                            text: '  (${m.dogrulamaBekliyor})',
                            style: const TextStyle(color: Colors.white38),
                          ),
                      ]),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
