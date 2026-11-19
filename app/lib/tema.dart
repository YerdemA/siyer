import 'package:flutter/material.dart';

/// Uygulamanın renk paleti: eski bir yol haritası gibi parşömen ve mürekkep.
/// Doygunluk düşük; vurgu kına kırmızısı ve şafak altını
/// (docs/GORSEL_USLUP.md → Renk ve ışık).
abstract final class Palet {
  /// Açık parşömen: kartların yüzü.
  static const kagitAcik = Color(0xFFF3E8CF);

  /// Parşömen: sayfa zemini.
  static const kagit = Color(0xFFE6D3A8);

  /// Koyu parşömen: çubuklar, ayraçlar.
  static const kagitKoyu = Color(0xFFD5BE8E);

  /// Mürekkep: yazı ve çizgiler.
  static const murekkep = Color(0xFF3B2716);

  /// Soluk mürekkep: ikincil yazı.
  static const murekkepSoluk = Color(0xFF6E5236);

  /// Kına kırmızısı: vurgu, işaret, çarpı.
  static const kina = Color(0xFF9C3B22);

  /// Şafak altını: seçili sekme, ilerleme.
  static const altin = Color(0xFFC2913F);

  /// Zeytin: tamamlanan bölüm.
  static const zeytin = Color(0xFF5F6B3D);

  /// Gece laciverdi: koyu yüzeyler.
  static const gece = Color(0xFF1E2230);
}

/// Başlıklar için tırnaklı (serif) yazı; Android'de Noto Serif.
const baslikYazisi = 'serif';

ThemeData uygulamaTemasi() {
  final renkler = ColorScheme.fromSeed(
    seedColor: Palet.kina,
    brightness: Brightness.light,
  ).copyWith(
    primary: Palet.kina,
    onPrimary: Palet.kagitAcik,
    secondary: Palet.altin,
    onSecondary: Palet.murekkep,
    surface: Palet.kagit,
    onSurface: Palet.murekkep,
    onSurfaceVariant: Palet.murekkepSoluk,
    surfaceContainerLowest: Palet.kagitAcik,
    surfaceContainerLow: Palet.kagitAcik,
    surfaceContainer: Palet.kagitKoyu,
    surfaceContainerHigh: Palet.kagitAcik,
    surfaceContainerHighest: Palet.kagitKoyu,
    outline: Palet.murekkepSoluk,
    outlineVariant: Palet.kagitKoyu,
    secondaryContainer: Palet.altin.withValues(alpha: 0.45),
    onSecondaryContainer: Palet.murekkep,
  );
  final temel = ThemeData(colorScheme: renkler, useMaterial3: true);
  return temel.copyWith(
    scaffoldBackgroundColor: Palet.kagit,
    appBarTheme: const AppBarTheme(
      backgroundColor: Palet.kagitKoyu,
      foregroundColor: Palet.murekkep,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: baslikYazisi,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Palet.murekkep,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Palet.kagitKoyu,
      indicatorColor: Palet.altin.withValues(alpha: 0.45),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Palet.murekkep),
      ),
      iconTheme: WidgetStateProperty.all(const IconThemeData(color: Palet.murekkep)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Palet.kagitAcik),
    dividerTheme: const DividerThemeData(color: Palet.kagitKoyu),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Palet.altin,
      linearTrackColor: Palet.kagitKoyu,
    ),
  );
}
