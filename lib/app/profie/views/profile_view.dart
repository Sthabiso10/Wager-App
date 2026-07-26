import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/global_widgets/app_feedback.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/app/profie/views/settings_view.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) => model.loadUserData(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screen, AppSpacing.md, AppSpacing.screen, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Profile', style: AppText.display),
                    IconPillButton(
                      icon: Icons.settings_outlined,
                      onTap: () => _openSettings(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Identity
                FadeSlideIn(child: _identity(context, model)),
                const SizedBox(height: AppSpacing.xxl),

                // Stats hero (dark)
                FadeSlideIn(
                  delay: const Duration(milliseconds: 80),
                  child: const _StatsHero(
                      wagers: 16, won: 12, lost: 4, winRate: 75),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Level progress
                FadeSlideIn(
                  delay: const Duration(milliseconds: 140),
                  child: const _LevelCard(
                      level: 3, title: 'Sharpshooter', xp: 120, xpMax: 200),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Account group
                FadeSlideIn(
                  delay: const Duration(milliseconds: 200),
                  child: MenuGroup(
                    label: 'ACCOUNT',
                    tiles: [
                      MenuTile(
                        icon: Icons.edit_outlined,
                        title: 'Edit profile',
                        subtitle: 'Name, username, photo',
                        chipIndex: 0,
                        onTap: () {},
                      ),
                      MenuTile(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        subtitle: 'Notifications, privacy, theme',
                        chipIndex: 1,
                        onTap: () => _openSettings(context),
                      ),
                      MenuTile(
                        icon: Icons.shield_outlined,
                        title: 'Password & security',
                        chipIndex: 3,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Support group
                FadeSlideIn(
                  delay: const Duration(milliseconds: 260),
                  child: MenuGroup(
                    label: 'SUPPORT',
                    tiles: [
                      MenuTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Help center',
                        chipIndex: 2,
                        onTap: () {},
                      ),
                      MenuTile(
                        icon: Icons.description_outlined,
                        title: 'Terms & conditions',
                        chipIndex: 4,
                        onTap: () => model.openTermsAndConditions(context),
                      ),
                      MenuTile(
                        icon: Icons.logout_rounded,
                        title: 'Log out',
                        chipIndex: 4,
                        destructive: true,
                        trailing: const SizedBox.shrink(),
                        onTap: () => _confirmLogout(context, model),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                Center(
                  child: Text('Watt · v1.0.0',
                      style: AppText.caption
                          .copyWith(color: AppColors.textTertiary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- Identity block ------------------------------------------------------
  Widget _identity(BuildContext context, ProfileViewModel model) {
    final username = (model.userData?["username"] as String?) ?? 'loading…';
    final email = (model.userData?["email"] as String?) ?? 'loading…';
    final initial = username.isNotEmpty && username != 'loading…'
        ? username[0].toUpperCase()
        : '?';

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Breathing(
              child: Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.lavender, AppColors.sky],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.onSky.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Text(initial,
                    style: AppText.display
                        .copyWith(color: AppColors.onLavender, fontSize: 38)),
              ),
            ),
            PressableScale(
              onTap: model.updateProfilePicture,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 3),
                ),
                child: const Icon(Icons.camera_alt_rounded,
                    color: Colors.white, size: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(username, style: AppText.h1),
            const SizedBox(width: 8),
            const AppBadge.soft('Pro'),
          ],
        ),
        const SizedBox(height: 4),
        Text(email, style: AppText.bodyMuted),
      ],
    );
  }

  void _openSettings(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsView()),
      );

  Future<void> _confirmLogout(
      BuildContext context, ProfileViewModel model) async {
    final shouldLogout = await showAppConfirmDialog(
      context,
      icon: Icons.logout_rounded,
      title: 'Log out?',
      message: 'You’ll need to sign in again to place wagers.',
      confirmLabel: 'Log out',
      destructive: true,
    );
    if (!context.mounted) return;
    if (shouldLogout == true) model.logout(context);
  }
}

/// Dark hero summarising the player's record, with counting numbers.
class _StatsHero extends StatelessWidget {
  final int wagers;
  final int won;
  final int lost;
  final int winRate;

  const _StatsHero({
    required this.wagers,
    required this.won,
    required this.lost,
    required this.winRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
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
      child: Row(
        children: [
          _cell('Wagers', wagers, Colors.white),
          _divider(),
          _cell('Won', won, AppColors.success),
          _divider(),
          _cell('Lost', lost, const Color(0xFFF87171)),
          _divider(),
          _cell('Win rate', winRate, AppColors.goldOnDark, suffix: '%'),
        ],
      ),
    );
  }

  Widget _divider() => Container(
      width: 1, height: 34, color: Colors.white.withValues(alpha: 0.1));

  Widget _cell(String label, int value, Color color, {String suffix = ''}) {
    return Expanded(
      child: Column(
        children: [
          AnimatedCount(
            value: value,
            style: AppText.h2.copyWith(color: color, fontSize: 20),
            builder: (v) => '${v.round()}$suffix',
          ),
          const SizedBox(height: 4),
          Text(label,
              style: AppText.caption
                  .copyWith(color: Colors.white.withValues(alpha: 0.55))),
        ],
      ),
    );
  }
}

/// Level + XP progress card with an animated bar.
class _LevelCard extends StatelessWidget {
  final int level;
  final String title;
  final int xp;
  final int xpMax;

  const _LevelCard({
    required this.level,
    required this.title,
    required this.xp,
    required this.xpMax,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (xp / xpMax).clamp(0.0, 1.0);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PastelIconBadge(
                icon: Icons.military_tech_outlined,
                background: AppColors.amber,
                foreground: AppColors.onAmber,
                size: 40,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Level $level · $title', style: AppText.label),
                    Text('$xp / $xpMax XP to level ${level + 1}',
                        style: AppText.caption),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: AppColors.surfaceMuted,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
