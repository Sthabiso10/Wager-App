import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'text_styles.dart';

/// ---------------------------------------------------------------------------
/// Wager App — Design System: ThemeData
///
/// A cohesive Material 3 light theme built on [AppColors] + Inter. Signature is
/// kept (`appTheme({required TextTheme textTheme})`) so `main.dart` is untouched.
/// ---------------------------------------------------------------------------
ThemeData appTheme({required TextTheme textTheme}) {
  const colorScheme = ColorScheme.light(
    primary: AppColors.ink,
    onPrimary: AppColors.onInk,
    secondary: AppColors.accent,
    onSecondary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.border,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.ink,
    canvasColor: AppColors.background,
    dividerColor: AppColors.divider,
    textTheme: AppText.textTheme(textTheme),
    splashFactory: InkRipple.splashFactory,

    // --- App bar -----------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: AppText.h3,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    // --- Cards -------------------------------------------------------------
    cardTheme: CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rXl),
    ),

    // --- Inputs ------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceMuted,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      hintStyle: AppText.body.copyWith(color: AppColors.textTertiary),
      labelStyle: AppText.labelMuted,
      floatingLabelStyle: AppText.label.copyWith(color: AppColors.accentText),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: const BorderSide(color: AppColors.ink, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      errorStyle: AppText.caption.copyWith(color: AppColors.error),
    ),

    // --- Buttons -----------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.onInk,
        disabledBackgroundColor: AppColors.surfaceMuted,
        disabledForegroundColor: AppColors.textTertiary,
        elevation: 0,
        minimumSize: const Size.fromHeight(54),
        textStyle: AppText.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rMd),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentText,
        textStyle: AppText.label,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        minimumSize: const Size.fromHeight(54),
        textStyle: AppText.label,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rMd),
      ),
    ),

    // --- Chips -------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceMuted,
      side: BorderSide.none,
      labelStyle: AppText.caption.copyWith(color: AppColors.textPrimary),
      shape: const StadiumBorder(),
    ),

    // --- Bottom sheets / dialogs ------------------------------------------
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rLg),
      titleTextStyle: AppText.h3,
      contentTextStyle: AppText.bodyMuted,
    ),

    // --- Misc --------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 22),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.ink,
      contentTextStyle: AppText.body.copyWith(color: AppColors.onInk),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rMd),
    ),
  );
}
