import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

/// Button style variants for the new design system.
enum AppButtonVariant { primary, secondary, accent }

/// Primary app button — a clean, full-width pill/rounded button with tactile
/// press feedback and a loading state.
///
/// Backwards compatible with the previous API: the old `isGlass` / `isGradient`
/// booleans still work and now map onto the new [AppButtonVariant]s
/// (`isGlass` → secondary, `isGradient` → accent).
class MyButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  // --- Legacy flags (kept for compatibility) --------------------------------
  final bool isGlass;
  final bool isGradient;
  final bool neonGlow; // no longer used; accepted so old callers compile.

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
    this.isGlass = false,
    this.isGradient = false,
    this.neonGlow = false,
  });

  AppButtonVariant get _resolvedVariant {
    if (isGlass) return AppButtonVariant.secondary;
    if (isGradient) return AppButtonVariant.accent;
    return variant;
  }

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.isLoading) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final variant = widget._resolvedVariant;

    late final Color bg;
    late final Color fg;
    Border? border;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = AppColors.ink;
        fg = AppColors.onInk;
        break;
      case AppButtonVariant.accent:
        bg = AppColors.accent;
        fg = Colors.white;
        break;
      case AppButtonVariant.secondary:
        bg = AppColors.surface;
        fg = AppColors.textPrimary;
        border = Border.all(color: AppColors.border);
        break;
    }

    final content = widget.isLoading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 20, color: fg),
                const SizedBox(width: 8),
              ],
              Text(widget.text, style: AppText.button.copyWith(color: fg)),
            ],
          );

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.isLoading
          ? null
          : () {
              HapticFeedback.lightImpact();
              widget.onPressed();
            },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: widget.isLoading ? 0.85 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Container(
            width: widget.fullWidth ? double.infinity : null,
            height: 54,
            padding: widget.fullWidth
                ? null
                : const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bg,
              border: border,
              borderRadius: AppRadius.rMd,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
