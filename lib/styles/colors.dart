import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Wager App — Design System: Colors
///
/// A clean, light-first "minimal fintech" palette inspired by modern money
/// apps (soft off-white canvas, white cards, near-black ink for primary
/// actions, and a set of soft pastel accent chips for iconography).
///
/// New code should use [AppColors]. The legacy top-level tokens below are kept
/// (repointed to the new palette) so existing screens keep compiling and pick
/// up the new look automatically.
/// ---------------------------------------------------------------------------
class AppColors {
  AppColors._();

  // --- Canvas & surfaces ---------------------------------------------------
  /// App background — soft, warm off-white/light-gray canvas.
  static const Color background = Color(0xFFF4F4F5);

  /// Primary surface — cards, sheets, elevated containers.
  static const Color surface = Color(0xFFFFFFFF);

  /// Muted surface — nested chips, inputs, segmented backgrounds.
  static const Color surfaceMuted = Color(0xFFF1F1F4);

  /// Sunken surface — subtle wells behind grouped content.
  static const Color surfaceSunken = Color(0xFFFAFAFB);

  // --- Text / ink ----------------------------------------------------------
  /// Primary text and the "black pill" primary action color.
  static const Color ink = Color(0xFF0B0B0F);
  static const Color onInk = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF0B0B0F);
  static const Color textSecondary = Color(0xFF71717A); // zinc-500
  static const Color textTertiary = Color(0xFFA1A1AA); // zinc-400

  // --- Lines ---------------------------------------------------------------
  static const Color border = Color(0xFFE7E7EA);
  static const Color divider = Color(0xFFEDEDF0);

  // --- Brand accent (gold, from the Watt logo) -----------------------------
  /// Metallic gold — the brand accent. Used for decorative fills, progress,
  /// status dots, badges and highlights on light surfaces.
  static const Color accent = Color(0xFFC99A2E);

  /// Soft gold wash for accent chip backgrounds.
  static const Color accentSoft = Color(0xFFF7EFD6);

  /// Deep, readable gold for text/links on light surfaces (meets contrast).
  static const Color accentText = Color(0xFF7A5D10);

  /// Brighter gold tuned for use on the dark "ink" surfaces (hero cards, nav).
  static const Color goldOnDark = Color(0xFFE8C15A);

  // --- Semantic ------------------------------------------------------------
  static const Color success = Color(0xFF16A34A);
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorSoft = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFD97706);
  static const Color warningSoft = Color(0xFFFEF3C7);

  // --- Pastel accent chips (icon backgrounds) ------------------------------
  static const Color lavender = Color(0xFFEDE9FE);
  static const Color onLavender = Color(0xFF7C3AED);
  static const Color mint = Color(0xFFDCFCE7);
  static const Color onMint = Color(0xFF16A34A);
  static const Color peach = Color(0xFFFFEDD5);
  static const Color onPeach = Color(0xFFEA580C);
  static const Color sky = Color(0xFFDBEAFE);
  static const Color onSky = Color(0xFF2563EB);
  static const Color rose = Color(0xFFFFE4E6);
  static const Color onRose = Color(0xFFE11D48);
  static const Color amber = Color(0xFFFEF3C7);
  static const Color onAmber = Color(0xFFD97706);

  /// Ordered pastel pairs — handy for deterministically coloring lists
  /// (e.g. wagers) by index so items feel varied but on-brand.
  static const List<List<Color>> chipPairs = [
    [lavender, onLavender],
    [sky, onSky],
    [mint, onMint],
    [peach, onPeach],
    [rose, onRose],
    [amber, onAmber],
  ];

  /// Returns a [bg, fg] pastel pair for a given index.
  static List<Color> chipForIndex(int index) =>
      chipPairs[index.abs() % chipPairs.length];

  // --- Soft shadow used across floating cards ------------------------------
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0B0B0F).withValues(alpha: 0.05),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: const Color(0xFF0B0B0F).withValues(alpha: 0.03),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];
}

/// ---------------------------------------------------------------------------
/// Legacy tokens (kept for backwards-compatibility, repointed to [AppColors]).
/// Existing screens reference these names; repointing them here shifts the
/// whole app onto the new light palette without touching every file.
/// ---------------------------------------------------------------------------
Color colorAccent = AppColors.accent;
Color backgroundColor = AppColors.background;
Color containerColor = AppColors.surface;
Color colorText = AppColors.textPrimary;
Color errorColor = AppColors.error;
Color successColor = AppColors.success;
