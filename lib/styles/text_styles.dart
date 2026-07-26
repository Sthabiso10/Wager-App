import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// ---------------------------------------------------------------------------
/// Wager App — Design System: Typography
///
/// One consistent family (Inter) across the whole app, with a clear weight
/// hierarchy: bold for headlines, medium for labels, regular for body. This
/// replaces the previous mix of Ubuntu / Poppins / Work Sans.
/// ---------------------------------------------------------------------------
class AppText {
  AppText._();

  static TextStyle _base(
    double size,
    FontWeight weight, {
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // --- Display / headlines -------------------------------------------------
  /// Big greeting headline ("Good afternoon!").
  static TextStyle display =
      _base(30, FontWeight.w700, height: 1.15, letterSpacing: -0.6);

  static TextStyle h1 =
      _base(24, FontWeight.w700, height: 1.2, letterSpacing: -0.4);

  static TextStyle h2 =
      _base(20, FontWeight.w700, height: 1.25, letterSpacing: -0.3);

  static TextStyle h3 =
      _base(17, FontWeight.w600, height: 1.3, letterSpacing: -0.2);

  // --- Body ----------------------------------------------------------------
  static TextStyle bodyLarge = _base(16, FontWeight.w400, height: 1.5);
  static TextStyle body = _base(15, FontWeight.w400, height: 1.5);
  static TextStyle bodyMuted =
      _base(15, FontWeight.w400, height: 1.5, color: AppColors.textSecondary);

  // --- Labels / meta -------------------------------------------------------
  static TextStyle label = _base(14, FontWeight.w600, letterSpacing: -0.1);
  static TextStyle labelMuted =
      _base(14, FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle caption =
      _base(12.5, FontWeight.w500, color: AppColors.textSecondary);
  static TextStyle overline = _base(
    11.5,
    FontWeight.w600,
    color: AppColors.textTertiary,
    letterSpacing: 0.6,
  );

  // --- Numeric (tabular figures for money / stats) -------------------------
  static TextStyle money = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle moneySmall = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  // --- Button --------------------------------------------------------------
  static TextStyle button =
      _base(16, FontWeight.w600, color: AppColors.onInk, letterSpacing: -0.1);

  /// Build a Material [TextTheme] from Inter so any un-restyled widget still
  /// renders in the app font.
  static TextTheme textTheme(TextTheme base) {
    return GoogleFonts.interTextTheme(base).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );
  }
}
