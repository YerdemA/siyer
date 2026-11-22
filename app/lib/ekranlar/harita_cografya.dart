import 'dart:ui';

/// Parşömen haritanın coğrafyası (docs/GORSEL_USLUP.md → Harita).
///
/// `yerler.json`'daki `harita.x/y` değerleri enlem-boylamdan bu doğrusal
/// izdüşümle hesaplanmıştır (Mekke 21,42 K / 39,83 D → 0,46 / 0,654; Şam,
/// Busrâ, Yesrib ve San'a aynı formüle oturur). Kıyı ve süsler de bununla
/// çizilir ki noktalarla örtüşsün. Ölçekli değildir; kıyı bugünkü
/// coğrafyadan, kabaca alınmıştır (Erdem, 2026-11-19: kıyı kodla çizilsin).
Offset izdusum(double enlem, double boylam) =>
    Offset(0.46 + 0.0955 * (boylam - 39.83), 0.654 - 0.05 * (enlem - 21.42));

/// Haritanın gösterilen bölümü; [alan] 0–1 harita koordinatlarındadır.
class HaritaBolgesi {
  const HaritaBolgesi(this.id, this.alan);
  final String id;
  final Rect alan;

  /// Ekrandaki en/boy oranı (bütün harita 3:4).
  double get oran => 3 * alan.width / (4 * alan.height);

  bool icerir(Offset p) => alan.contains(p);

  /// [ekranOrani] (en/boy) olan bir ekranı dolduracak pencere: bölge ortada
  /// kalır, eksik yönde (dikey ekranda üst-alt) genişletilir.
  Rect ekranaGore(double ekranOrani) {
    // Ekran oranı = 3/4 · (genişlik / yükseklik); bkz. [oran].
    if (ekranOrani < oran) {
      return Rect.fromCenter(center: alan.center, width: alan.width, height: alan.width * 3 / (4 * ekranOrani));
    }
    return Rect.fromCenter(center: alan.center, width: alan.height * 4 * ekranOrani / 3, height: alan.height);
  }
}

const tumHarita = HaritaBolgesi('tum', Rect.fromLTRB(0, 0, 1, 1));

/// Mekke ile çevresindeki yakın yerler (Hira, Şuaybe, Nahle, Ukâz, Tâif)
/// bütün haritada üst üste bindiği için ayrı, büyütülmüş bir bölgede
/// gösterilir.
const mekkeCevresi = HaritaBolgesi('mekke', Rect.fromLTRB(0.405, 0.632, 0.555, 0.702));

const haritaBolgeleri = {'tum': tumHarita, 'mekke': mekkeCevresi};

typedef Nokta = (double enlem, double boylam);

/// Kızıldeniz'in Arabistan kıyısı, kuzeyden güneye (Akabe → Bâbülmendeb).
const arabistanKiyisi = <Nokta>[
  (29.53, 35.00), (28.80, 34.85), (28.05, 34.62), (27.90, 35.25), (27.35, 35.70),
  (26.55, 36.10), (26.20, 36.45), (25.20, 37.20), (24.10, 38.05), (23.50, 38.60),
  (22.80, 39.03), (22.20, 39.08), (21.50, 39.17), (20.80, 39.50), (20.15, 40.27),
  (19.13, 41.08), (18.20, 41.55), (16.90, 42.55), (15.90, 42.70), (14.80, 42.95),
  (13.90, 43.15), (13.30, 43.25), (12.65, 43.45), (12.00, 43.50),
  // Aden Körfezi'nin kuzey kıyısı (dikey ekranda harita aşağı uzayınca görünür).
  (12.60, 44.40), (12.80, 45.03), (13.40, 46.70), (14.00, 48.30), (14.50, 49.20), (15.30, 51.00), (15.80, 52.50),
];

/// Kızıldeniz'in Afrika kıyısı, kuzeyden güneye.
const afrikaKiyisi = <Nokta>[
  (29.97, 32.55), (27.20, 33.80), (25.00, 34.90), (23.90, 35.47), (22.00, 36.88),
  (20.80, 37.20), (19.60, 37.22), (19.10, 37.33), (18.20, 38.20), (16.60, 39.10),
  (15.60, 39.45), (14.90, 40.30), (13.90, 41.20), (13.00, 42.75), (12.00, 43.30),
  // Aden Körfezi'nin güney kıyısı.
  (11.50, 43.10), (11.20, 43.60), (10.40, 44.40), (10.50, 45.50), (11.00, 47.50), (11.30, 49.50), (11.80, 51.20), (11.80, 52.50),
];

/// Akdeniz'in doğu kıyısı (sol üst köşede ince bir şerit), güneyden kuzeye.
const akdenizKiyisi = <Nokta>[
  (31.20, 34.20), (31.50, 34.45), (32.10, 34.77), (32.80, 34.95), (33.27, 35.20),
  (33.56, 35.37), (33.90, 35.50), (34.40, 35.80), (35.20, 35.90),
  // İskenderun ve Anadolu'nun güney kıyısı (harita yukarı uzayınca görünür).
  (35.90, 35.90), (36.60, 36.15), (36.90, 35.60), (36.75, 34.60), (36.30, 33.80), (36.10, 32.80), (36.70, 31.00), (36.70, 29.00),
];

/// Hicaz ve Yemen dağları için süs (kıyıya koşut sıradağ); konum kabadır.
const daglar = <Nokta>[
  (28.30, 35.90), (27.00, 36.90), (25.80, 37.80), (24.40, 38.70), (23.20, 39.40),
  (20.70, 41.00), (19.60, 41.80), (18.40, 42.55), (17.20, 43.30), (16.10, 43.70),
];

/// Kervan yolları: yer kimlikleriyle, sırayla. Yalnız iki ucu da haritada
/// olan parçalar çizilir.
const kervanYollari = <List<String>>[
  ['mekke', 'ebva', 'yesrib', 'busra', 'sam'],
  ['mekke', 'sana'],
];
