import 'package:flutter/material.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

/// A single wager, rendered as a clean light card with a pastel icon,
/// a soft status pill, a "you vs opponent" row and a muted stake/date footer.
class NewBetCard extends StatelessWidget {
  final String title;
  final String description;
  final String player1;
  final String player2;
  final String stake;
  final String status;
  final String date;
  final VoidCallback? onTap;

  const NewBetCard({
    super.key,
    required this.title,
    required this.description,
    required this.player1,
    required this.player2,
    required this.stake,
    required this.status,
    required this.date,
    this.onTap,
  });

  /// [background, foreground] soft pair for the status pill.
  List<Color> _statusColors() {
    switch (status.toLowerCase()) {
      case "won":
        return [AppColors.successSoft, AppColors.success];
      case "lost":
        return [AppColors.errorSoft, AppColors.error];
      case "pending":
        return [AppColors.warningSoft, AppColors.warning];
      case "accepted":
      case "active":
        return [AppColors.accentSoft, AppColors.accent];
      default:
        return [AppColors.surfaceMuted, AppColors.textSecondary];
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColors = _statusColors();
    final chip = AppColors.chipForIndex(title.length);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: icon + title + status pill
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PastelIconBadge(
                icon: Icons.emoji_events_outlined,
                background: chip[0],
                foreground: chip[1],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.replaceFirst(RegExp(r'^#\s*'), ''),
                      style: AppText.h3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: AppText.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppBadge(
                label: status,
                background: statusColors[0],
                foreground: statusColors[1],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Players row
          Row(
            children: [
              Expanded(child: _player(player1, "You", AppColors.onSky)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    "VS",
                    style: AppText.overline
                        .copyWith(color: AppColors.onInk, letterSpacing: 0.5),
                  ),
                ),
              ),
              Expanded(
                child: _player(player2, "Opponent", AppColors.onRose,
                    alignEnd: true),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Footer well: stake + date
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.rMd,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _footerItem(Icons.account_balance_wallet_outlined, "STAKE",
                    stake, AppColors.textPrimary),
                Container(width: 1, height: 28, color: AppColors.border),
                _footerItem(Icons.calendar_today_outlined, "DATE", date,
                    AppColors.textSecondary,
                    alignEnd: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _player(String name, String role, Color accent,
      {bool alignEnd = false}) {
    final avatar = Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : "?",
        style: AppText.label.copyWith(color: accent),
      ),
    );

    final texts = Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(name,
            style: AppText.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        Text(role, style: AppText.caption),
      ],
    );

    final children = alignEnd
        ? [Flexible(child: texts), const SizedBox(width: 10), avatar]
        : [avatar, const SizedBox(width: 10), Flexible(child: texts)];

    return Row(
      mainAxisAlignment:
          alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: children,
    );
  }

  Widget _footerItem(
      IconData icon, String label, String value, Color valueColor,
      {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.overline),
        const SizedBox(height: 4),
        Row(
          children: [
            if (!alignEnd) ...[
              Icon(icon, size: 15, color: valueColor),
              const SizedBox(width: 6),
            ],
            Text(value, style: AppText.moneySmall.copyWith(color: valueColor)),
            if (alignEnd) ...[
              const SizedBox(width: 6),
              Icon(icon, size: 15, color: valueColor),
            ],
          ],
        ),
      ],
    );
  }
}
