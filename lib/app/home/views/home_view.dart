import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/home/view_models/home_viewmodel.dart';
import 'package:wager_app/app/home/widgets/active_bets_widget.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning";
    if (hour < 17) return "Good afternoon";
    return "Good evening";
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.loadUserData(),
      builder: (context, model, child) {
        final firstName = model.userData?['firstName'] as String?;

        return Scaffold(
          backgroundColor: AppColors.background,
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- Header --------------------------------------------
                FadeSlideIn(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.screen,
                        AppSpacing.md, AppSpacing.screen, AppSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_greeting(), style: AppText.bodyMuted),
                              const SizedBox(height: 2),
                              Text(
                                firstName != null
                                    ? "$firstName 👋"
                                    : "Welcome",
                                style: AppText.display,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconPillButton(
                          icon: Icons.group_outlined,
                          onTap: () =>
                              Navigator.pushNamed(context, '/friends'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        IconPillButton(
                          icon: Icons.notifications_none_rounded,
                          showDot: true,
                          onTap: () => Navigator.pushNamed(context, '/inbox'),
                        ),
                      ],
                    ),
                  ),
                ),

                // ---- Hero: total at stake ------------------------------
                FadeSlideIn(
                  delay: const Duration(milliseconds: 90),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.screen),
                    child: _StakeHeroCard(
                      total: 130,
                      active: 3,
                      won: 12,
                      lost: 4,
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // ---- Section header ------------------------------------
                FadeSlideIn(
                  delay: const Duration(milliseconds: 160),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screen),
                    child: SectionHeader(
                      title: "Active wagers",
                      actionLabel: "See all",
                      onAction: () =>
                          Navigator.pushNamed(context, '/createBet'),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ---- Active bets list ----------------------------------
                const Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.screen),
                    child: ActiveBetsWidget(),
                  ),
                ),
              ],
            ),
          ),
          // Lifted above the floating nav pill (which lives on the outer
          // NavigationMenu Scaffold and would otherwise overlap the FAB).
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 78),
            child: _buildSpeedDial(context),
          ),
        );
      },
    );
  }

  SpeedDial _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      backgroundColor: AppColors.ink,
      foregroundColor: AppColors.goldOnDark,
      overlayColor: AppColors.ink,
      overlayOpacity: 0.35,
      spacing: 12,
      spaceBetweenChildren: 10,
      icon: Icons.add_rounded,
      activeIcon: Icons.close_rounded,
      elevation: 2,
      shape: const CircleBorder(),
      childrenButtonSize: const Size(58, 58),
      children: [
        _dialChild(context, Icons.group_add_outlined, 'Friend bet',
            '/friend-bet', AppColors.lavender, AppColors.onLavender),
        _dialChild(context, Icons.bolt_outlined, 'Quick bet', '/quick-bet',
            AppColors.sky, AppColors.onSky),
        _dialChild(context, Icons.emoji_events_outlined, 'Challenge',
            '/challenge', AppColors.peach, AppColors.onPeach),
      ],
    );
  }

  SpeedDialChild _dialChild(BuildContext context, IconData icon, String label,
      String route, Color bg, Color fg) {
    return SpeedDialChild(
      child: Icon(icon, color: fg),
      backgroundColor: bg,
      elevation: 1,
      shape: const CircleBorder(),
      label: label,
      labelStyle: AppText.label,
      labelBackgroundColor: AppColors.surface,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.pushNamed(context, route);
      },
    );
  }
}

/// The dark, premium focal card summarising the user's wagers.
class _StakeHeroCard extends StatelessWidget {
  final int total;
  final int active;
  final int won;
  final int lost;

  const _StakeHeroCard({
    required this.total,
    required this.active,
    required this.won,
    required this.lost,
  });

  int get _winRate => (won + lost) == 0 ? 0 : ((won / (won + lost)) * 100).round();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL AT STAKE",
                style: AppText.overline.copyWith(
                    color: Colors.white.withValues(alpha: 0.55),
                    letterSpacing: 1),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                          color: AppColors.success, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text("$active active",
                        style: AppText.overline.copyWith(
                            color: Colors.white, letterSpacing: 0.3)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AnimatedCount(
            value: total,
            style: AppText.money.copyWith(
                color: AppColors.goldOnDark, fontSize: 40, letterSpacing: -1),
            builder: (v) => "R${v.round()}",
          ),
          const SizedBox(height: AppSpacing.xl),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: AppRadius.rMd,
            ),
            child: Row(
              children: [
                _stat("Won", won, AppColors.success),
                _divider(),
                _stat("Lost", lost, const Color(0xFFF87171)),
                _divider(),
                _stat("Win rate", _winRate, AppColors.goldOnDark, suffix: "%"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 26, color: Colors.white.withValues(alpha: 0.1));

  Widget _stat(String label, int value, Color valueColor,
      {String suffix = ""}) {
    return Expanded(
      child: Column(
        children: [
          AnimatedCount(
            value: value,
            style: AppText.h3.copyWith(color: valueColor, fontSize: 18),
            builder: (v) => "${v.round()}$suffix",
          ),
          const SizedBox(height: 2),
          Text(label,
              style: AppText.caption
                  .copyWith(color: Colors.white.withValues(alpha: 0.55))),
        ],
      ),
    );
  }
}
