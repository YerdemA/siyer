import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ayarlar/tercihler.dart';
import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';
import 'anlatim_sesi.dart';
import 'gorsel_onbellek.dart';
import 'harita_gecisi.dart';
import 'sahne_cizici.dart';
import 'zaman_plani.dart';

class OynaticiEkrani extends ConsumerWidget {
  const OynaticiEkrani({
    super.key,
    required this.bolumId,
    this.baslangicSahnesi,
    this.baslangicCekimi = 1,
    this.duraklatilmis = false,
  });

  final String bolumId;

  /// 1'den başlar. Verilmezse kayıtlı ilerlemeden (yoksa baştan) başlanır.
  final int? baslangicSahnesi;

  /// Revize için: sahnenin kaçıncı çekiminden (1'den) başlanacağı.
  final int baslangicCekimi;

  /// Revize için: oynatma durmuş açılır (ekran görüntüsü).
  final bool duraklatilmis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = Metinler.of(context);
    final bolum = ref.watch(bolumProvider(bolumId));
    final kaynakca = ref.watch(kaynakcaProvider);
    // Yalnız açılışta okunur: oynarken her kayıtta oynatıcı yeniden kurulmasın.
    final ilerleme = ref.watch(ilerlemeProvider.select((d) => d.whenData((_) => true)));
    final notifier = ref.read(ilerlemeProvider.notifier);
    // Ses süreleri okunamazsa bölüm sessiz (süreler metinden) oynar.
    final sureler = ref.watch(sesSureleriProvider(bolumId));
    // Yerler okunamazsa bölüm harita geçişi olmadan oynar.
    final yerler = ref.watch(yerlerProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: switch ((bolum, kaynakca, ilerleme, sureler, yerler)) {
        (
          AsyncData(value: final b),
          AsyncData(value: final k),
          AsyncData() || AsyncError(),
          AsyncData() || AsyncError(),
          AsyncData() || AsyncError(),
        ) =>
          Oynatici(
            bolum: b,
            kaynakca: k,
            sesSureleri: sureler.value ?? const {},
            // Revize açılışlarında (belirli çekim ya da durmuş) harita araya girmez.
            yerler: duraklatilmis || baslangicCekimi > 1 ? const [] : yerler.value ?? const [],
            sesFabrikasi: ref.read(anlatimSesiFabrikasi),
            altyaziOlcegi: ref.read(tercihlerProvider).value?.altyazi.olcek ?? 1,
            altyaziAcik: ref.read(tercihlerProvider).value?.altyaziAcik ?? false,
            altyaziDegisti: ref.read(tercihlerProvider.notifier).altyaziAcikSec,
            efekt: ref.read(efektCalProvider),
            azHareket: hareketAz(context, ref),
            sonrakiBolum: _sonraki(ref.read(bolumListesiProvider).value ?? const [], b),
            baslangicSahnesi: baslangicSahnesi ??
                ref.read(ilerlemeProvider).value?[bolumId]?.devamSahnesi ??
                1,
            baslangicCekimi: baslangicCekimi,
            duraklatilmis: duraklatilmis,
            sahneDegisti: (no) => notifier.sahneKaydet(bolumId, no),
            bitti: () => notifier.bitir(bolumId),
          ),
        (AsyncError(:final error), _, _, _, _) || (_, AsyncError(:final error), _, _, _) =>
          Center(child: Text(m.yuklemeHatasi('$error'), style: const TextStyle(color: Colors.white))),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  /// Sırada [b]'den sonra gelen bölüm; yoksa null.
  static Bolum? _sonraki(List<Bolum> liste, Bolum b) {
    final sonrakiler = liste.where((x) => x.sira > b.sira).toList()..sort((x, y) => x.sira.compareTo(y.sira));
    return sonrakiler.firstOrNull;
  }
}

class Oynatici extends StatefulWidget {
  const Oynatici({
    super.key,
    required this.bolum,
    required this.kaynakca,
    this.baslangicSahnesi = 1,
    this.baslangicCekimi = 1,
    this.duraklatilmis = false,
    this.sahneDegisti,
    this.bitti,
    this.sesSureleri = const {},
    this.sesFabrikasi,
    this.yerler = const [],
    this.altyaziOlcegi = 1,
    this.altyaziAcik = false,
    this.altyaziDegisti,
    this.efekt,
    this.sonrakiBolum,
    this.azHareket = false,
  });

  /// Hareketi azalt: harita geçişi kısa ve kamerasız.
  final bool azHareket;

  /// Ayarlar'daki altyazı boyutu (1 = orta).
  final double altyaziOlcegi;

  /// Sesli sahnelerde altyazı gösterilsin mi (sessiz sahnede her zaman görünür).
  final bool altyaziAcik;

  /// Oynatıcıdaki altyazı düğmesi tercihi değiştirince (kalıcı kayıt için).
  final ValueChanged<bool>? altyaziDegisti;

  /// Efekt sesi çalar (ör. harita geçişinde `parsomen`); verilmezse sessiz.
  final void Function(String ad)? efekt;

  /// Bölüm sonunda "Sıradaki bölüm" düğmesi için.
  final Bolum? sonrakiBolum;

  /// Harita geçişleri için `yerler.json`; boşsa geçiş gösterilmez.
  final List<Yer> yerler;

  /// Sahne kimliğinden anlatım sesinin süresine (saniye); bkz. [sesSureleriProvider].
  final Map<String, double> sesSureleri;

  /// Verilmezse ses çalınmaz (yalnız zaman planı ve altyazı).
  final AnlatimSesi Function()? sesFabrikasi;

  final Bolum bolum;
  final Map<String, Eser> kaynakca;
  final int baslangicSahnesi;
  final int baslangicCekimi;
  final bool duraklatilmis;

  /// Görünen sahne değişince (1'den başlayan numarayla) çağrılır.
  final ValueChanged<int>? sahneDegisti;

  /// Bölüm sonuna gelinince bir kez çağrılır.
  final VoidCallback? bitti;

  @override
  State<Oynatici> createState() => _OynaticiState();
}

class _OynaticiState extends State<Oynatici> with SingleTickerProviderStateMixin {
  late final ZamanPlani _plan = ZamanPlani.olustur(widget.bolum, sesSureleri: widget.sesSureleri);
  late final AnlatimSesi? _ses = widget.sesSureleri.isEmpty ? null : widget.sesFabrikasi?.call();
  late final AppLifecycleListener _yasamDongusu;
  bool _sesIstegiSuruyor = false;
  late final Ticker _ticker;
  Duration _oncekiTik = Duration.zero;
  double _an = 0;
  bool _oynuyor = true;
  bool _kontroller = true;
  bool _tarif = false;
  late bool _altyazi = widget.altyaziAcik;
  final _gorseller = GorselOnbellek();

  /// Gösterilen harita geçişi; varken zaman ve ses durur.
  ({Yer? onceki, Yer hedef})? _gecis;

  /// Son bilinen yer (yeri boş sahneler öncekini korur) ve son sahne sırası.
  Yer? _sonYer;
  int _sonSahne = -1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final i = (widget.baslangicSahnesi - 1).clamp(0, _plan.sahneler.length - 1);
    _an = widget.baslangicCekimi > 1
        ? _plan.cekimBasi(i, widget.baslangicCekimi - 1)
        : _plan.sahneler[i].bas;
    _oynuyor = !widget.duraklatilmis;
    _sonSahne = i;
    // Bölüm açılınca: bütün harita, sonra olayın geçtiği yer.
    final ilkYer = _sahneYeri(i, geriye: false);
    if (ilkYer != null) _gecis = (onceki: null, hedef: ilkYer);
    _sonYer = ilkYer;
    _ticker = createTicker(_tik)..start();
    // Uygulama arka plana geçince oynatma (ve ses) durur.
    _yasamDongusu = AppLifecycleListener(onHide: () {
      if (mounted && _oynuyor) setState(() => _oynuyor = false);
    });
  }

  @override
  void dispose() {
    _yasamDongusu.dispose();
    _ses?.kapat();
    _ticker.dispose();
    _gorseller.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _tik(Duration gecen) {
    final dt = (gecen - _oncekiTik).inMicroseconds / 1e6;
    _oncekiTik = gecen;
    _sesiEsitle();
    if (!_oynuyor || _gecis != null) return;
    final sesAni = _sesSaati(dt);
    setState(() {
      _an = math.min(sesAni ?? _an + dt, _plan.toplam);
      if (_an >= _plan.toplam) _oynuyor = false;
      _yerDegistiMi();
    });
  }

  void _git(double an) => setState(() {
        _an = an.clamp(0.0, _plan.toplam);
        _yerDegistiMi(atlama: true);
      });

  void _sahneyeGit(int fark) {
    final i = (_plan.sahneSirasi(_an) + fark).clamp(0, _plan.sahneler.length - 1);
    setState(() {
      _an = _plan.sahneler[i].bas + (i == 0 ? 0 : 0.01);
      _yerDegistiMi(atlama: fark != 1);
    });
  }

  /// [sira]daki sahnenin yeri; boşsa [geriye] doğru (ya da ileri) ilk dolu yer.
  Yer? _sahneYeri(int sira, {bool geriye = true}) {
    if (widget.yerler.isEmpty) return null;
    final s = _plan.sahneler;
    for (var i = sira; i >= 0 && i < s.length; i += geriye ? -1 : 1) {
      final id = s[i].sahne.yer;
      if (id.isNotEmpty) return widget.yerler.where((y) => y.id == id).firstOrNull;
    }
    return null;
  }

  /// Sahne sırası değiştiyse yeri izler. Bir sonraki sahneye (kendiliğinden
  /// ya da "sonraki sahne"yle) geçilip uzak bir yere varıldıysa harita
  /// geçişi başlar; kaydırma ve geri atlamada yalnız yer güncellenir.
  void _yerDegistiMi({bool atlama = false}) {
    final i = _plan.sahneSirasi(_an);
    if (i == _sonSahne) return;
    final ileri = i == _sonSahne + 1 && !atlama;
    _sonSahne = i;
    final yeni = _plan.sahneler[i].sahne.yer.isEmpty ? null : _sahneYeri(i);
    if (yeni == null) return;
    if (ileri && _sonYer != null && haritaGecisiGerekir(_sonYer, yeni)) {
      _gecis = (onceki: _sonYer, hedef: yeni);
    }
    _sonYer = yeni;
  }

  bool get _bitti => _an >= _plan.toplam;

  /// Son [kararmaSuresi] saniyede 0'dan 1'e; sonra bölüm sonu kartı açılır.
  double get _kararma {
    final bas = _plan.toplam - kararmaSuresi;
    if (_an <= bas) return 0;
    return Curves.easeInOut.transform(((_an - bas) / kararmaSuresi).clamp(0.0, 1.0));
  }

  static const kararmaSuresi = 3.0;

  /// Sesin akmasını bekleyen süre (saniye); bkz. [_sesSaati].
  double _sesBekleme = 0;

  /// Anlatım bölgesinde saati sese bağlar. Ses yüklenirken saat durur (en çok
  /// [enCokBekleme] sn; ses hiç gelmezse saat kendi işler), ses akarken sesin
  /// konumunu izler. Böylece yükleme gecikmesi kayma sayılıp ses tekrar tekrar
  /// başa sarılmaz. null: saat kendi işler.
  double? _sesSaati(double dt) {
    final ses = _ses;
    if (ses == null) return null;
    final s = _plan.sahneler[_plan.sahneSirasi(_an)];
    final k = s.sesKonumu(_an);
    if (k == null) {
      _sesBekleme = 0;
      return null;
    }
    final akiyor =
        !_sesIstegiSuruyor && ses.etkinDosya == s.sahne.sesAnlatim && ses.caliyor && ses.hazir;
    if (!akiyor) {
      _sesBekleme += dt;
      return _sesBekleme < enCokBekleme ? _an : null;
    }
    _sesBekleme = 0;
    final sesAni = s.sesBas + ses.konum.inMicroseconds / 1e6;
    // Büyük fark kullanıcının kaydırmasıdır; ses saate uyar (_sesiEsitle arar).
    if ((sesAni - _an).abs() * 1000 > sesKaymaSiniri) return null;
    // Saat geri gitmez; ses konumundaki küçük titremeler görüntüyü sarsmasın.
    return math.max(_an, sesAni);
  }

  static const enCokBekleme = 2.0;

  /// Saat asıl; ses ona uyar. Her karede çağrılır: duraklatma, kaydırma,
  /// sahne atlama, bölüm sonu ve sahne başı/sonu sessizlikleri buradan yönetilir.
  void _sesiEsitle() {
    final ses = _ses;
    if (ses == null || _sesIstegiSuruyor) return;
    final i = _plan.sahneSirasi(_an);
    final s = _plan.sahneler[i];
    switch (sesKarari(
      oynuyor: _oynuyor && _gecis == null,
      dosya: s.sahne.sesAnlatim,
      sesKonumu: s.sesKonumu(_an),
      etkinDosya: ses.etkinDosya,
      caliyor: ses.caliyor,
      hazir: ses.hazir,
      konum: ses.konum,
      siradaki: _siradakiSes(i),
      kaymaSiniriMs: sesKaymaSiniri,
    )) {
      case SesBekle():
        break;
      case SesHazirla(:final dosya):
        _sesIstegi(ses.hazirla(dosya));
      case SesDuraklat():
        _sesIstegi(ses.duraklat());
      case SesCal(:final dosya, :final konum):
        _sesIstegi(ses.cal(dosya, konum));
      case SesAra(:final konum):
        _sesIstegi(ses.ara(konum));
    }
  }

  /// Sessizlikte önceden yüklenecek dosya: sahnenin sesi henüz başlamadıysa
  /// kendisininki, bittiyse sıradaki sesli sahneninki.
  String? _siradakiSes(int i) {
    final s = _plan.sahneler[i];
    if (s.sesli && _an < s.sesBas) return s.sahne.sesAnlatim;
    for (var j = i + 1; j < _plan.sahneler.length; j++) {
      if (_plan.sahneler[j].sesli) return _plan.sahneler[j].sahne.sesAnlatim;
    }
    return null;
  }

  /// Ses saatten bu kadar (ms) ayrılırsa (kaydırma, atlama) yeniden konumlanır.
  static const sesKaymaSiniri = 400;

  void _sesIstegi(Future<void> istek) {
    _sesIstegiSuruyor = true;
    istek.catchError((Object hata) {
      debugPrint('Anlatım sesi hatası: $hata');
    }).whenComplete(() => _sesIstegiSuruyor = false);
  }

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
                  gorsel: konum.cekim.gorsel,
                  ilerleme: konum.cekimIlerleme,
                  zaman: _an,
                  gorseller: _gorseller,
                ),
              ),
              if (konum.gelenCekim != null)
                Opacity(
                  opacity: konum.gecisOrani,
                  child: CustomPaint(
                    painter: SahneCizici(
                      gorsel: konum.gelenCekim!.gorsel,
                      ilerleme: konum.gelenCekimIlerleme,
                      zaman: _an,
                      gorseller: _gorseller,
                    ),
                  ),
                ),
              // Bölüm sonu: son sahnenin kapanış sessizliğinde görüntü kararır.
              if (_kararma > 0) ColoredBox(color: Colors.black.withValues(alpha: _kararma)),
              if ((_altyazi || !konum.sahne.sesli) && konum.parca != null)
                _Altyazi(
                  parca: konum.parca!,
                  an: _an,
                  olcek: widget.altyaziOlcegi,
                  // Kontroller gizliyken altyazı kenara iner, görüntüyü az örter.
                  alt: _kontroller && !_bitti ? 64 : 16,
                ),
              if (_tarif) _TarifPaneli(sahne: konum.sahne.sahne, cekim: konum.cekim),
              if (_kontroller && !_bitti) _kontrolCubugu(context, konum),
              if (_gecis case final g?)
                HaritaGecisi(
                  key: ValueKey(g),
                  yerler: widget.yerler,
                  onceki: g.onceki,
                  hedef: g.hedef,
                  efekt: widget.efekt,
                  azHareket: widget.azHareket,
                  bitti: () => setState(() => _gecis = null),
                ),
              if (_bitti)
                _BolumSonu(
                  azHareket: widget.azHareket,
                  bolum: widget.bolum,
                  kaynakca: widget.kaynakca,
                  sonraki: widget.sonrakiBolum,
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
                  [
                    if (konum.cekim.gorsel.yerTutucuVar) m.yerTutucuUyari,
                    if (!konum.sahne.sesli) m.sesYok,
                  ].join(' '),
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
                    onPressed: () {
                      setState(() => _altyazi = !_altyazi);
                      widget.altyaziDegisti?.call(_altyazi);
                    },
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
  const _Altyazi({required this.parca, required this.an, this.olcek = 1, this.alt = 64});

  final ParcaZamani parca;
  final double alt;
  final double an;
  final double olcek;

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
      bottom: alt,
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
              style: TextStyle(color: const Color(0xFFF4EEE2), fontSize: 18 * olcek, height: 1.35),
            ),
          ),
        ),
      ),
    );
  }
}

/// Revize için: sahnenin içerikteki görsel tarifi, kamerası ve katmanları.
class _TarifPaneli extends StatelessWidget {
  const _TarifPaneli({required this.sahne, required this.cekim});

  final Sahne sahne;
  final CekimZamani cekim;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    final g = cekim.gorsel;
    final cekimSayisi = sahne.cekimler.length;
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
              Text(cekimSayisi > 1 ? '${sahne.id} · ${cekim.sira + 1}/$cekimSayisi' : sahne.id, style: const TextStyle(color: Color(0xFFF2C46B), fontWeight: FontWeight.bold)),
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

/// Kararmanın ardından önce bölüm adı, biraz sonra kaynaklar ve düğmeler
/// belirir; bölüm birden kesilmez.
class _BolumSonu extends StatefulWidget {
  const _BolumSonu({
    required this.bolum,
    required this.kaynakca,
    required this.yenidenOynat,
    this.sonraki,
    this.azHareket = false,
  });

  final Bolum bolum;
  final Bolum? sonraki;
  final Map<String, Eser> kaynakca;
  final VoidCallback yenidenOynat;
  final bool azHareket;

  @override
  State<_BolumSonu> createState() => _BolumSonuState();
}

class _BolumSonuState extends State<_BolumSonu> with SingleTickerProviderStateMixin {
  late final _zaman = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.azHareket ? 600 : 4200),
  )..forward();

  @override
  void dispose() {
    _zaman.dispose();
    super.dispose();
  }

  /// Zaman çizelgesinin [bas]–[son] aralığında 0→1.
  Animation<double> _aralik(double bas, double son) =>
      CurvedAnimation(parent: _zaman, curve: Interval(bas, son, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    // Kart: ilk %25'te belirir, %60'ta çekilir; liste %60'tan sonra gelir.
    final kartGir = _aralik(0, 0.25);
    final kartCik = _aralik(0.55, 0.7);
    final liste = _aralik(0.6, 0.85);
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: _zaman,
            builder: (context, _) => Opacity(
              opacity: (kartGir.value - kartCik.value).clamp(0.0, 1.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.bolum.baslik,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFFF2C46B), fontSize: 30, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 10),
                    Text(m.bolumSonu, style: const TextStyle(color: Colors.white54, fontSize: 15, letterSpacing: 2)),
                  ],
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: liste,
            child: _BolumSonuListesi(
              bolum: widget.bolum,
              kaynakca: widget.kaynakca,
              sonraki: widget.sonraki,
              yenidenOynat: widget.yenidenOynat,
            ),
          ),
        ],
      ),
    );
  }
}

class _BolumSonuListesi extends StatelessWidget {
  const _BolumSonuListesi({required this.bolum, required this.kaynakca, required this.yenidenOynat, this.sonraki});

  final Bolum bolum;
  final Bolum? sonraki;
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
                if (sonraki case final s?) ...[
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => context.pushReplacement('/bolum/${s.id}'),
                    icon: const Icon(Icons.skip_next),
                    label: Text(m.siradakiBolum(s.baslik)),
                  ),
                ],
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
