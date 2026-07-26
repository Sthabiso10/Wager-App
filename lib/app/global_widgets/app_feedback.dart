import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

/// ---------------------------------------------------------------------------
/// App feedback: toasts + dialogs
///
/// A modern, non-blocking toast that slides in from the top with a pastel icon,
/// plus a polished confirm dialog with a springy entrance. Both respect the
/// platform reduce-motion setting.
/// ---------------------------------------------------------------------------

enum ToastKind { success, error, info }

class AppToast {
  AppToast._();

  static OverlayEntry? _current;

  static void show(
    BuildContext context, {
    required String message,
    ToastKind kind = ToastKind.info,
    Duration duration = const Duration(milliseconds: 2600),
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    // Replace any toast already on screen.
    _current?.remove();
    _current = null;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastCard(
        message: message,
        kind: kind,
        duration: duration,
        onDismissed: () {
          if (_current == entry) _current = null;
          entry.remove();
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);

    // Light haptic cue.
    if (kind == ToastKind.error) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.lightImpact();
    }
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, kind: ToastKind.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, kind: ToastKind.error);

  static void info(BuildContext context, String message) =>
      show(context, message: message, kind: ToastKind.info);
}

class _ToastCard extends StatefulWidget {
  final String message;
  final ToastKind kind;
  final Duration duration;
  final VoidCallback onDismissed;

  const _ToastCard({
    required this.message,
    required this.kind,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
    reverseDuration: const Duration(milliseconds: 260),
  );

  late final Animation<double> _fade =
      CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, -0.4),
    end: Offset.zero,
  ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (_dismissed || !mounted) return;
    _dismissed = true;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ({IconData icon, Color bg, Color fg}) get _style {
    switch (widget.kind) {
      case ToastKind.success:
        return (
          icon: Icons.check_rounded,
          bg: AppColors.mint,
          fg: AppColors.onMint
        );
      case ToastKind.error:
        return (
          icon: Icons.priority_high_rounded,
          bg: AppColors.errorSoft,
          fg: AppColors.error
        );
      case ToastKind.info:
        return (
          icon: Icons.info_outline_rounded,
          bg: AppColors.sky,
          fg: AppColors.onSky
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: _dismiss,
                  onVerticalDragEnd: (d) {
                    if ((d.primaryVelocity ?? 0) < 0) _dismiss();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.ink.withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: s.bg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(s.icon, color: s.fg, size: 22),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: AppText.label,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A polished confirm dialog with a springy entrance and pill buttons.
/// Returns `true` if confirmed, `false`/`null` otherwise.
Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  IconData icon = Icons.help_outline_rounded,
  bool destructive = false,
}) {
  final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: title,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    transitionDuration:
        reduceMotion ? Duration.zero : const Duration(milliseconds: 260),
    pageBuilder: (context, _, __) => const SizedBox.shrink(),
    transitionBuilder: (context, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
      return Opacity(
        opacity: anim.value.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: reduceMotion ? 1.0 : (0.92 + 0.08 * curved.value),
          child: _ConfirmDialog(
            title: title,
            message: message,
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
            icon: icon,
            destructive: destructive,
          ),
        ),
      );
    },
  );
}

class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final IconData icon;
  final bool destructive;

  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.icon,
    required this.destructive,
  });

  @override
  Widget build(BuildContext context) {
    final accentBg = destructive ? AppColors.errorSoft : AppColors.sky;
    final accentFg = destructive ? AppColors.error : AppColors.onSky;
    final confirmBg = destructive ? AppColors.error : AppColors.ink;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rXl),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: accentBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: accentFg, size: 28),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: AppText.h2, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(message,
                style: AppText.bodyMuted, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: _pill(
                    label: cancelLabel,
                    bg: AppColors.surfaceMuted,
                    fg: AppColors.textPrimary,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _pill(
                    label: confirmLabel,
                    bg: confirmBg,
                    fg: Colors.white,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill({
    required String label,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, borderRadius: AppRadius.rMd),
        child: Text(label, style: AppText.label.copyWith(color: fg)),
      ),
    );
  }
}
