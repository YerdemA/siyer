import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ayarlar/tercihler.dart';
import '../icerik/depo.dart';
import '../icerik/model.dart';
import '../icerik/paketler.dart';
import '../ilerleme/ilerleme.dart';
import '../l10n/app_localizations.dart';
import 'anlatim_sesi.dart';
import 'ekran.dart';
import 'bolum_indirme.dart';
import 'gorsel_onbellek.dart';
import 'harita_gecisi.dart';
import 'medya_karti.dart';
import 'sahne_cizici.dart';
import 'zaman_plani.dart';
import '../tema.dart';

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
    // İnmemiş bölüm önce indirilir; inince oynatıcı açılır.
    if (ref.watch(paketDurumuProvider(bolumId)) is! PaketHazir) return BolumIndirme(bolumId: bolumId);
    final dosyalar = ref.watch(bolumDosyalariProvider(bolumId));
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
      body: switch ((bolum, kaynakca, ilerleme, sureler, yerler, dosyalar)) {
        (
          AsyncData(value: final b),
          AsyncData(value: final k),
          AsyncData() || AsyncError(),
          AsyncData() || AsyncError(),
          AsyncData() || AsyncError(),
          AsyncData(value: final d),
        ) =>
          Oynatici(
            bolum: b,
            kaynakca: k,
            gorselOkuyucu: (dosya) => d.oku('gorseller/$dosya'),
            sesSureleri: sureler.value ?? const {},
            // Revize açılışlarında (belirli çekim ya da durmuş) harita araya girmez.
            yerler: duraklatilmis || baslangicCekimi > 1 ? const [] : yerler.value ?? const [],
            sesFabrikasi: () => ref.read(anlatimSesiFabrikasi)(d),
            altyaziOlcegi: ref.read(tercihlerProvider).value?.altyazi.olcek ?? 1,
            altyaziAcik: ref.read(tercihlerProvider).value?.altyaziAcik ?? false,
            altyaziDegisti: ref.read(tercihlerProvider.notifier).altyaziAcikSec,
            hiz: ref.read(tercihlerProvider).value?.hiz ?? 1,
            hizDegisti: ref.read(tercihlerProvider.notifier).hizSec,
            efekt: ref.read(efektCalProvider),
            azHareket: hareketAz(context, ref),
            sonrakiBolum: _sonraki(ref.read(bolumListesiProvider).value ?? const [], b),
            baslangicSahnesi: baslangicSahnesi ?? ref.read(ilerlemeProvider).value?[bolumId]?.devamSahnesi ?? 1,
            baslangicCekimi: baslangicCekimi,
            duraklatilmis: duraklatilmis,
            medyaKarti: ref.read(medyaKartiProvider),
            sahneDegisti: (no) => notifier.sahneKaydet(bolumId, no),
            bitti: () => notifier.bitir(bolumId),
          ),
        (AsyncError(:final error), _, _, _, _, _) ||
        (_, AsyncError(:final error), _, _, _, _) ||
        (_, _, _, _, _, AsyncError(:final error)) => Center(
          child: Text(m.yuklemeHatasi('$error'), style: const TextStyle(color: Colors.white)),
        ),
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
    this.gorselOkuyucu,
    this.yerler = const [],
    this.altyaziOlcegi = 1,
    this.altyaziAcik = false,
    this.altyaziDegisti,
    this.hiz = 1,
    this.hizDegisti,
    this.efekt,
    this.sonrakiBolum,
    this.azHareket = false,
    this.ekran = const Ekran(),
    this.medyaKarti = const SessizMedyaKarti(),
  });

  /// Kilit ekranı/bildirim kartı ve kulaklık tuşları; testlerde sessiz.
  final MedyaKarti medyaKarti;

  /// Hareketi azalt: harita geçişi kısa ve kamerasız.
  final bool azHareket;

  /// Ayarlar'daki altyazı boyutu (1 = orta).
  final double altyaziOlcegi;

  /// Sesli sahnelerde altyazı gösterilsin mi (sessiz sahnede her zaman görünür).
  final bool altyaziAcik;

  /// Oynatıcıdaki altyazı düğmesi tercihi değiştirince (kalıcı kayıt için).
  final ValueChanged<bool>? altyaziDegisti;

  /// Oynatma hızı (bkz. [oynatmaHizlari]); saat ve anlatım sesi birlikte hızlanır.
  final double hiz;

  /// Hız düğmesi hızı değiştirince (kalıcı kayıt için).
  final ValueChanged<double>? hizDegisti;

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

  /// Katman görselinin baytları (indirilen paketten ya da uygulamadan);
  /// verilmezse uygulamaya gömülü varlıklardan okunur.
  final Future<Uint8List> Function(String dosya)? gorselOkuyucu;

  final Bolum bolum;
  final Map<String, Eser> kaynakca;
  final int baslangicSahnesi;
  final int baslangicCekimi;
  final bool duraklatilmis;

  /// Görünen sahne değişince (1'den başlayan numarayla) çağrılır.
  final ValueChanged<int>? sahneDegisti;

  /// Bölüm sonuna gelinince bir kez çağrılır.
  final VoidCallback? bitti;

  /// Ekranı açık tutma, ekran kapalı mı sorusu; testlerde sahtesi verilir.
  final Ekran ekran;

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
  late double _hiz = widget.hiz;

  /// Çift dokunmayla sarmanın göstergesi: yön ve art arda dokunmalarla
  /// biriken saniye. Kısa süre görünür, sonra kaybolur.
  ({bool ileri, int saniye})? _sarma;
  Timer? _sarmaSayaci;
  double? _ciftDokunmaX;
  late final _gorseller = GorselOnbellek(okuyucu: widget.gorselOkuyucu);

  /// Gösterilen harita geçişi; varken zaman ve ses durur.
  ({Yer? onceki, Yer hedef})? _gecis;

  /// Son bilinen yer (yeri boş sahneler öncekini korur) ve son sahne sırası.
  Yer? _sonYer;
  int _sonSahne = -1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final i = (widget.baslangicSahnesi - 1).clamp(0, _plan.sahneler.length - 1);
    _an = widget.baslangicCekimi > 1 ? _plan.cekimBasi(i, widget.baslangicCekimi - 1) : _plan.sahneler[i].bas;
    _oynuyor = !widget.duraklatilmis;
    _sonSahne = i;
    // Bölüm açılınca: bütün harita, sonra olayın geçtiği yer.
    final ilkYer = _sahneYeri(i, geriye: false);
    if (ilkYer != null) _gecis = (onceki: null, hedef: ilkYer);
    _sonYer = ilkYer;
    _ticker = createTicker(_tik)..start();
    if (_hiz != 1) _ses?.hizAyarla(_hiz);
    // Başka uygulamaya geçilince oynatma (ve ses) durur; yalnız ekran
    // kapandıysa sürer: kullanıcı yalnız anlatımı dinlemek isteyebilir
    // (Erdem, 2026-11-22). Ekran kapalıyken kare çizilmez, saati
    // [_arkaPlanSaati] ilerletir.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.medyaKarti.baglan(
        MedyaKomutlari(
          oynat: _karttanOynat,
          duraklat: () => _karttanDurum(false),
          onceki: () => _karttan(() => _sahneyeGit(-1)),
          sonraki: () => _karttan(() => _sahneyeGit(1)),
          git: (an) => _karttan(() => _git(an)),
          kapat: () => _karttanDurum(false),
        ),
        kanalAdi: Metinler.of(context).kartKanali,
      );
      _kartiGuncelle();
    });
    _yasamDongusu = AppLifecycleListener(
      onHide: () async {
        _gizli = true;
        final ekranAcik = await widget.ekran.acikMi();
        if (!mounted) return;
        if (ekranAcik) {
          if (_oynuyor) setState(() => _oynuyor = false);
        } else if (_oynuyor) {
          _arkaPlanaGec();
        }
      },
      onShow: () {
        _gizli = false;
        _onPlanaDon();
      },
    );
  }

  @override
  void dispose() {
    _yasamDongusu.dispose();
    widget.medyaKarti.birak();
    _arkaPlanSaati?.cancel();
    _sarmaSayaci?.cancel();
    _ses?.kapat();
    _ticker.dispose();
    _gorseller.dispose();
    widget.ekran.acikTut(false);
    widget.ekran.uyanikTut(false);
    // Oynatıcı dışındaki ekranlar dikey (bkz. main.dart).
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  /// Ekran kapalıyken saati ilerleten zamanlayıcı; ekran açıkken null.
  Timer? _arkaPlanSaati;

  /// Ön plana dönünce ticker'ın ilk karesi aradaki süreyi yeniden saymasın.
  bool _tikYenile = false;

  void _arkaPlanaGec() {
    if (_arkaPlanSaati != null) return;
    // Harita geçişi çizilmeden ilerlemez; ekran kapalıyken atlanır.
    _gecis = null;
    widget.ekran.uyanikTut(true);
    // Timer.tick geciken çağrılarda atlanan adımları da sayar; süre kaymaz.
    const adim = 0.1;
    var onceki = 0;
    _arkaPlanSaati = Timer.periodic(const Duration(milliseconds: 100), (t) {
      _ilerle((t.tick - onceki) * adim);
      onceki = t.tick;
      if (!_oynuyor) _onPlanaDon(); // bölüm bitti ya da durdu: kilit bırakılır
    });
  }

  void _onPlanaDon() {
    if (_arkaPlanSaati == null) return;
    _arkaPlanSaati!.cancel();
    _arkaPlanSaati = null;
    _tikYenile = true;
    widget.ekran.uyanikTut(false);
  }

  bool get _arkaPlanda => _arkaPlanSaati != null;

  /// Ekranı açık tutma isteğinin son gönderilen değeri.
  bool? _acikTutuluyor;

  /// Bölüm oynarken ekran kendiliğinden kararmasın; duraklayınca kararabilir.
  void _ekraniAcikTut() {
    final istenen = _oynuyor && !_bitti;
    if (istenen == _acikTutuluyor) return;
    _acikTutuluyor = istenen;
    widget.ekran.acikTut(istenen);
  }

  void _tik(Duration gecen) {
    if (_tikYenile) {
      _tikYenile = false;
      _oncekiTik = gecen;
      return;
    }
    final dt = (gecen - _oncekiTik).inMicroseconds / 1e6;
    _oncekiTik = gecen;
    if (_arkaPlanda) return; // saati zamanlayıcı ilerletiyor
    _ilerle(dt);
  }

  void _ilerle(double dt) {
    _sesiEsitle();
    if (_arkaPlanda) _ilerlemeBildir(_plan.sahneSirasi(_an) + 1, hemen: true);
    if (_oynuyor && _gecis == null) {
      final sesAni = _sesSaati(dt);
      setState(() {
        _an = math.min(sesAni ?? _an + dt * _hiz, _plan.toplam);
        if (_an >= _plan.toplam) _oynuyor = false;
        _yerDegistiMi();
      });
    }
    _kartiGuncelle();
  }

  /// Uygulama görünmüyor (ekran kapalı ya da başka uygulama önde).
  bool _gizli = false;

  /// Karttan ya da kulaklıktan gelen bir isteği uygular. Uygulama
  /// görünmüyorsa kare çizilmez: ilerleme hemen kaydedilir, kart hemen yenilenir.
  void _karttan(VoidCallback istek) {
    if (!mounted) return;
    istek();
    if (_gizli) _ilerlemeBildir(_plan.sahneSirasi(_an) + 1, hemen: true);
    _kartiGuncelle();
  }

  void _karttanDurum(bool oynuyor) => _karttan(() => setState(() => _oynuyor = oynuyor));

  /// Görünmezken (ör. kilit ekranından) sürdürülürse saati zamanlayıcı ilerletir.
  void _karttanOynat() {
    if (_bitti) return;
    _karttanDurum(true);
    if (_gizli) _arkaPlanaGec();
  }

  /// Kartta son gösterilen durum ve o andan beri geçen süre. Kart konumu
  /// kendisi ilerletir; yalnız durum değişince ya da 1 sn'den çok kayınca yenilenir.
  MedyaDurumu? _kartDurumu;
  final _kartSaati = Stopwatch();

  void _kartiGuncelle() {
    if (!mounted) return;
    final sira = _plan.sahneSirasi(_an);
    final oynuyor = _oynuyor && _gecis == null && !_bitti;
    final kimlik = _plan.sahneler[sira].sahne.id;
    _kapakHazirla(sira);
    final o = _kartDurumu;
    if (o != null && o.oynuyor == oynuyor && o.kimlik == kimlik && o.kapak == _kapak && o.hiz == _hiz) {
      final beklenen = o.konum + (oynuyor ? _kartSaati.elapsedMicroseconds / 1e6 * _hiz : 0);
      if ((beklenen - _an).abs() < 1) return;
    }
    _kartSaati
      ..reset()
      ..start();
    _kartDurumu = MedyaDurumu(
      kimlik: kimlik,
      baslik: widget.bolum.baslik,
      altBaslik: Metinler.of(context).kartSahne(sira + 1, _plan.sahneler.length),
      toplam: _plan.toplam,
      konum: _an,
      oynuyor: oynuyor,
      hiz: _hiz,
      kapak: _kapak,
    );
    widget.medyaKarti.guncelle(_kartDurumu!);
  }

  /// Kartın kapak resmi: sahnenin ilk çekimi, oynatıcının kendi çizimiyle.
  Uri? _kapak;
  int _kapakSahnesi = -1;
  bool _kapakCiziliyor = false;

  void _kapakHazirla(int sira) {
    if (!widget.medyaKarti.kapakIster || sira == _kapakSahnesi || _kapakCiziliyor) return;
    final cekim = _plan.sahneler[sira].cekimler.first;
    final bekleyen = cekim.gorsel.katmanlar.where(
        (k) => k.dosya.isNotEmpty && _gorseller.al(k.dosya) == null && !_gorseller.bulunamadi(k.dosya));
    if (bekleyen.isNotEmpty) return; // al() yüklemeyi başlattı; sonraki adımda yeniden denenir
    _kapakCiziliyor = true;
    _kapakCiz(sira, cekim).whenComplete(() => _kapakCiziliyor = false);
  }

  Future<void> _kapakCiz(int sira, CekimZamani cekim) async {
    try {
      const boyut = Size(512, 288);
      final kayit = ui.PictureRecorder();
      SahneCizici(gorsel: cekim.gorsel, ilerleme: 0.5, zaman: (cekim.bas + cekim.son) / 2, gorseller: _gorseller)
          .paint(Canvas(kayit), boyut);
      final resim = await kayit.endRecording().toImage(boyut.width.toInt(), boyut.height.toInt());
      final png = await resim.toByteData(format: ui.ImageByteFormat.png);
      resim.dispose();
      if (png == null || !mounted) return;
      final dosya = File('${Directory.systemTemp.path}/kapak-${_plan.sahneler[sira].sahne.id}.png');
      await dosya.writeAsBytes(png.buffer.asUint8List());
      if (!mounted) return;
      _kapakSahnesi = sira;
      _kapak = dosya.uri;
      _kartiGuncelle();
    } catch (hata) {
      debugPrint('Kart kapağı çizilemedi: $hata');
      _kapakSahnesi = sira; // her adımda yeniden denenmesin
    }
  }

  void _git(double an) => setState(() {
    _an = an.clamp(0.0, _plan.toplam);
    _yerDegistiMi(atlama: true);
  });

  /// Çift dokunmayla sarılan süre (saniye).
  static const sarmaAdimi = 10;

  /// Ekranın sağ yarısına çift dokunma ileri, sol yarısına geri sarar.
  /// Art arda dokunmalar gösterge açıkken birikir (10, 20, 30 sn); tek
  /// dokunuş ancak çift dokunma beklemesinden (300 ms) sonra geldiği için
  /// gösterge 900 ms açık kalır.
  void _ciftDokunmaylaSar(double genislik) {
    final x = _ciftDokunmaX;
    if (x == null || _bitti || _gecis != null) return;
    final ileri = x > genislik / 2;
    final onceki = _sarma;
    final saniye = onceki != null && onceki.ileri == ileri ? onceki.saniye + sarmaAdimi : sarmaAdimi;
    _git(_an + (ileri ? sarmaAdimi : -sarmaAdimi));
    setState(() => _sarma = (ileri: ileri, saniye: saniye));
    _sarmaSayaci?.cancel();
    _sarmaSayaci = Timer(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _sarma = null);
    });
  }

  void _hizDegistir() {
    final i = oynatmaHizlari.indexOf(_hiz);
    final yeni = oynatmaHizlari[(i + 1) % oynatmaHizlari.length];
    setState(() => _hiz = yeni);
    _ses?.hizAyarla(yeni);
    widget.hizDegisti?.call(yeni);
  }

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
    // Tek sahnelik uğrak (ör. Yesrib'deki kabir) harita açtırmaz; dönüşte de
    // açılmasın diye son yer değişmez (Erdem, 2026-11-22).
    if (!kaliciYer([for (var j = 0; j < _plan.sahneler.length; j++) _sahneYeri(j)?.id], i)) return;
    if (ileri && !_arkaPlanda && _sonYer != null && haritaGecisiGerekir(_sonYer, yeni)) {
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
    final akiyor = !_sesIstegiSuruyor && ses.etkinDosya == s.sahne.sesAnlatim && ses.caliyor && ses.hazir;
    if (!akiyor) {
      _sesBekleme += dt;
      return _sesBekleme < enCokBekleme ? _an : null;
    }
    _sesBekleme = 0;
    final sesAni = s.sesAni(ses.konum.inMicroseconds / 1e6, yakin: _an);
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
    istek
        .catchError((Object hata) {
          debugPrint('Anlatım sesi hatası: $hata');
        })
        .whenComplete(() => _sesIstegiSuruyor = false);
  }

  int? _bildirilenSahne;
  bool _bitisBildirildi = false;

  int _hazirlananSahne = -1;

  /// Bulunulan ve sıradaki sahnenin görselleri önceden yüklenir; bir önceki
  /// sahneninkiler geri sarmaya karşı tutulur, gerisi bellekten atılır.
  void _gorselleriHazirla(int sira) {
    if (sira == _hazirlananSahne) return;
    _hazirlananSahne = sira;
    final yakin = [
      for (var i = sira - 1; i <= sira + 1; i++)
        if (i >= 0 && i < _plan.sahneler.length) _plan.sahneler[i].sahne,
    ];
    _gorseller.sinirla(yakin);
    _gorseller.onYukle(_plan.sahneler[sira].sahne);
    if (sira + 1 < _plan.sahneler.length) _gorseller.onYukle(_plan.sahneler[sira + 1].sahne);
  }

  /// İlerleme kaydı build sırasında değil, kare bittikten sonra yapılır.
  /// Ekran kapalıyken kare çizilmez; [hemen] ise beklemeden bildirilir.
  void _ilerlemeBildir(int sahneNo, {bool hemen = false}) {
    final sahneDegisti = sahneNo != _bildirilenSahne;
    final yeniBitis = _bitti && !_bitisBildirildi;
    if (!sahneDegisti && !yeniBitis) return;
    _bildirilenSahne = sahneNo;
    if (yeniBitis) _bitisBildirildi = true;
    if (!_bitti) _bitisBildirildi = false;
    void bildir() {
      if (!mounted) return;
      if (sahneDegisti) widget.sahneDegisti?.call(sahneNo);
      if (yeniBitis) widget.bitti?.call();
    }

    if (hemen) {
      bildir();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => bildir());
    }
  }

  @override
  Widget build(BuildContext context) {
    final konum = _plan.konum(_an);
    _ilerlemeBildir(konum.sahne.sira + 1);
    _ekraniAcikTut();
    _gorselleriHazirla(konum.sahne.sira);
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Dokunma algılayıcısı yalnız görüntüyü sarar: çift dokunma
            // beklemesi kontrol düğmelerini geciktirmesin.
            LayoutBuilder(
              builder: (context, alan) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                // Sarma göstergesi açıkken tek dokunuş da sarar (üç dokunuş
                // 20 sn); kapalıyken kontrolleri açıp kapar.
                onTapUp: (d) {
                  if (_sarma != null) {
                    _ciftDokunmaX = d.localPosition.dx;
                    _ciftDokunmaylaSar(alan.maxWidth);
                  } else {
                    setState(() => _kontroller = !_kontroller);
                  }
                },
                onDoubleTapDown: (d) => _ciftDokunmaX = d.localPosition.dx,
                onDoubleTap: () => _ciftDokunmaylaSar(alan.maxWidth),
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
                  ],
                ),
              ),
            ),
            if (_sarma case final s?) _SarmaGostergesi(ileri: s.ileri, saniye: s.saniye),
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
            padding: altPayli(c),
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
                  [if (konum.cekim.gorsel.yerTutucuVar) m.yerTutucuUyari, if (!konum.sahne.sesli) m.sesYok].join(' '),
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
                  Expanded(
                    child: _IlerlemeCubugu(plan: _plan, an: _an, git: _git),
                  ),
                  Text('${_sure(_an)} / ${_sure(_plan.toplam)}', style: const TextStyle(color: beyaz, fontSize: 12)),
                  TextButton(
                    onPressed: _hizDegistir,
                    style: TextButton.styleFrom(
                      foregroundColor: _hiz == 1 ? Colors.white70 : beyaz,
                      minimumSize: const Size(48, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    child: Tooltip(
                      message: m.oynatmaHizi,
                      child: Text(
                        hizMetni(_hiz, Localizations.localeOf(context).languageCode),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
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

/// Hız düğmesinin metni: `1×`, `1,5×` (Türkçe), `1.5×` (İngilizce).
String hizMetni(double hiz, String dilKodu) {
  final s = hiz == hiz.roundToDouble() ? '${hiz.toInt()}' : '$hiz';
  return '${dilKodu == 'tr' ? s.replaceAll('.', ',') : s}×';
}

/// Çift dokunmayla sarmada dokunulan yarıda beliren ok ve saniye.
class _SarmaGostergesi extends StatelessWidget {
  const _SarmaGostergesi({required this.ileri, required this.saniye});

  final bool ileri;
  final int saniye;

  @override
  Widget build(BuildContext context) {
    final m = Metinler.of(context);
    return IgnorePointer(
      child: Align(
        alignment: ileri ? const Alignment(0.6, 0) : const Alignment(-0.6, 0),
        child: Semantics(
          liveRegion: true,
          label: ileri ? m.saniyeIleri(saniye) : m.saniyeGeri(saniye),
          child: ExcludeSemantics(
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Color(0x88000000), shape: BoxShape.circle),
              child: SizedBox.square(
                dimension: 88,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(ileri ? Icons.fast_forward_rounded : Icons.fast_rewind_rounded, color: Colors.white, size: 32),
                    Text(
                      '${ileri ? '+' : '−'}${m.saniyeKisa(saniye)}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
          child: SizedBox(height: 32, child: CustomPaint(painter: _CubukCizici(plan, an))),
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
    final gorunur = math.min(((an - parca.bas) / 0.3).clamp(0.0, 1.0), ((parca.son - an) / 0.3 + 0.4).clamp(0.0, 1.0));
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
            decoration: BoxDecoration(color: const Color(0x99000000), borderRadius: BorderRadius.circular(6)),
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
              Text(
                cekimSayisi > 1 ? '${sahne.id} · ${cekim.sira + 1}/$cekimSayisi' : sahne.id,
                style: const TextStyle(color: Color(0xFFF2C46B), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(g.tarif),
              const SizedBox(height: 6),
              Text('${m.kamera}: ${g.kamera} · ${m.saat}: ${g.saat}'),
              Text(
                '${m.katmanlar}: ${g.katmanlar.map((k) => '${k.yerTutucu}(${k.derinlik})').join(', ')}',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
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
  Animation<double> _aralik(double bas, double son) => CurvedAnimation(
    parent: _zaman,
    curve: Interval(bas, son, curve: Curves.easeInOut),
  );

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
                  child: Text(
                    '${m.bolumSonu} · ${m.kaynaklar}',
                    style: const TextStyle(color: Color(0xFFF2C46B), fontSize: 18),
                  ),
                ),
                TextButton.icon(onPressed: yenidenOynat, icon: const Icon(Icons.replay), label: Text(m.yenidenOynat)),
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
                      TextSpan(
                        children: [
                          TextSpan(text: '$eser, ${a.konum}'),
                          if (!a.dogrulandi)
                            TextSpan(
                              text: '  (${m.dogrulamaBekliyor})',
                              style: const TextStyle(color: Colors.white38),
                            ),
                        ],
                      ),
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
