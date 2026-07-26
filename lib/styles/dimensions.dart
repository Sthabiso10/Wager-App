import 'package:flutter/widgets.dart';

/// ---------------------------------------------------------------------------
/// Wager App — Design System: Spacing, radii & elevation
///
/// A single 4/8-based rhythm plus a rounded-corner scale tuned for the soft,
/// pill-and-card fintech look.
/// ---------------------------------------------------------------------------
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Standard horizontal screen inset.
  static const double screen = 20;
}

class AppRadius {
  AppRadius._();

  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 26;
  static const double pill = 999;

  static const BorderRadius rSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius rMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius rLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius rXl = BorderRadius.all(Radius.circular(xl));
}

// --- Legacy spacing helpers (kept so existing screens keep compiling) -------
const SizedBox spacingHeight16 = SizedBox(height: 16);
const SizedBox spacingWidth16 = SizedBox(width: 16);

// Convenient gap helpers for new code.
const SizedBox gap4 = SizedBox(height: 4, width: 4);
const SizedBox gap8 = SizedBox(height: 8, width: 8);
const SizedBox gap12 = SizedBox(height: 12, width: 12);
const SizedBox gap16 = SizedBox(height: 16, width: 16);
const SizedBox gap20 = SizedBox(height: 20, width: 20);
const SizedBox gap24 = SizedBox(height: 24, width: 24);
