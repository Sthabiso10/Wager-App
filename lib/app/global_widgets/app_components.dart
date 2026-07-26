import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

/// ---------------------------------------------------------------------------
/// Shared UI building blocks for the Wager App design system.
///
///   • [AppCard]         — white, softly-shadowed rounded container
///   • [PastelIconBadge] — rounded-square pastel icon chip
///   • [SectionHeader]   — section title with optional trailing action
///   • [AppBadge]        — small status pill ("NEW", "ACTIVE"…)
///   • [PressableScale]  — tap-to-scale feedback wrapper
///   • [IconPillButton]  — compact circular/rounded icon button
/// ---------------------------------------------------------------------------

/// A white rounded card with the standard soft elevation.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final double radius;
  final bool shadow;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.color,
    this.radius = AppRadius.xl,
    this.shadow = true,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow ? AppColors.cardShadow : null,
        border: border,
      ),
      child: child,
    );

    if (onTap == null) return card;
    return PressableScale(onTap: onTap!, child: card);
  }
}

/// A soft, rounded-square pastel chip holding an icon — the signature element
/// of the reference designs (Rainy Day, Emergency cushion, etc.).
class PastelIconBadge extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color foreground;
  final double size;

  const PastelIconBadge({
    super.key,
    required this.icon,
    required this.background,
    required this.foreground,
    this.size = 44,
  });

  /// Builds a badge from one of the ordered pastel pairs by [index].
  factory PastelIconBadge.indexed(
    int index, {
    required IconData icon,
    double size = 44,
  }) {
    final pair = AppColors.chipForIndex(index);
    return PastelIconBadge(
      icon: icon,
      background: pair[0],
      foreground: pair[1],
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Icon(icon, color: foreground, size: size * 0.5),
    );
  }
}

/// A section title with an optional trailing action (chevron / text button).
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppText.h2),
        if (onAction != null)
          PressableScale(
            onTap: onAction!,
            child: Row(
              children: [
                if (actionLabel != null)
                  Text(actionLabel!,
                      style:
                          AppText.label.copyWith(color: AppColors.accentText)),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.accentText, size: 20),
              ],
            ),
          ),
      ],
    );
  }
}

/// A small status pill, e.g. "NEW", "WON", "ACTIVE".
class AppBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const AppBadge({
    super.key,
    required this.label,
    this.background = AppColors.ink,
    this.foreground = Colors.white,
  });

  const AppBadge.soft(
    this.label, {
    super.key,
    this.background = AppColors.accentSoft,
    this.foreground = AppColors.accentText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppText.overline.copyWith(color: foreground, letterSpacing: 0.5),
      ),
    );
  }
}

/// Wraps any child with subtle press-scale + haptic feedback.
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scale;

  const PressableScale({
    super.key,
    required this.child,
    required this.onTap,
    this.scale = 0.97,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _pressed ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

/// A single row in a grouped menu — pastel icon, title, optional subtitle,
/// trailing widget (defaults to a chevron), with a destructive variant.
class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final int chipIndex;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool destructive;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.chipIndex = 0,
    this.trailing,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final chip = AppColors.chipForIndex(chipIndex);
    final color = destructive ? AppColors.error : AppColors.textPrimary;
    return PressableScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        child: Row(
          children: [
            PastelIconBadge(
              icon: icon,
              background: destructive ? AppColors.errorSoft : chip[0],
              foreground: destructive ? AppColors.error : chip[1],
              size: 40,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.label.copyWith(color: color)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppText.caption, maxLines: 1),
                  ],
                ],
              ),
            ),
            trailing ??
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}

/// A titled group of [MenuTile]s inside a single [AppCard] with hairline
/// dividers between rows.
class MenuGroup extends StatelessWidget {
  final String? label;
  final List<MenuTile> tiles;

  const MenuGroup({super.key, this.label, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < tiles.length; i++) {
      children.add(tiles[i]);
      if (i != tiles.length - 1) {
        children.add(const Padding(
          padding: EdgeInsets.only(left: 68, right: AppSpacing.lg),
          child: Divider(height: 1),
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: AppSpacing.sm),
            child: Text(label!, style: AppText.overline),
          ),
        ],
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// A single value/label statistic cell used in stat rows.
class StatCell extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const StatCell(
      {super.key, required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: AppText.h2
                .copyWith(fontSize: 18, color: valueColor ?? AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label, style: AppText.caption),
      ],
    );
  }
}

/// Compact circular icon button used in headers.
class IconPillButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? background;
  final Color? foreground;
  final bool showDot;

  const IconPillButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.background,
    this.foreground,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: background ?? AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: AppColors.cardShadow,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: foreground ?? AppColors.textPrimary, size: 21),
            if (showDot)
              Positioned(
                top: 11,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
