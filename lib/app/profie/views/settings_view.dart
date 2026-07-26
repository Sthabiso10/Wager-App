import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/animations.dart';
import 'package:wager_app/app/global_widgets/app_components.dart';
import 'package:wager_app/app/global_widgets/app_feedback.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (model) => model.loadUserData(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppSpacing.screen, AppSpacing.sm,
                AppSpacing.screen, AppSpacing.xxxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Account card
                FadeSlideIn(
                  child: AppCard(
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.lavender,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            _initial(model),
                            style: AppText.h1.copyWith(
                                color: AppColors.onLavender, fontSize: 22),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(model.userData?["username"] ?? 'loading…',
                                  style: AppText.h3),
                              Text(model.userData?["email"] ?? 'loading…',
                                  style: AppText.caption, maxLines: 1),
                            ],
                          ),
                        ),
                        const AppBadge.soft('Pro'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                FadeSlideIn(
                  delay: const Duration(milliseconds: 80),
                  child: MenuGroup(
                    label: 'PREFERENCES',
                    tiles: [
                      MenuTile(
                        icon: Icons.notifications_none_rounded,
                        title: 'Notifications',
                        chipIndex: 0,
                        onTap: () {},
                      ),
                      MenuTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'Privacy',
                        chipIndex: 1,
                        onTap: () {},
                      ),
                      MenuTile(
                        icon: Icons.palette_outlined,
                        title: 'Theme',
                        subtitle: 'Light',
                        chipIndex: 2,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                FadeSlideIn(
                  delay: const Duration(milliseconds: 140),
                  child: MenuGroup(
                    label: 'ABOUT',
                    tiles: [
                      MenuTile(
                        icon: Icons.info_outline_rounded,
                        title: 'About Wager',
                        chipIndex: 3,
                        onTap: () {},
                      ),
                      MenuTile(
                        icon: Icons.logout_rounded,
                        title: 'Log out',
                        chipIndex: 4,
                        destructive: true,
                        trailing: const SizedBox.shrink(),
                        onTap: () async {
                          final ok = await showAppConfirmDialog(
                            context,
                            icon: Icons.logout_rounded,
                            title: 'Log out?',
                            message:
                                'You’ll need to sign in again to place wagers.',
                            confirmLabel: 'Log out',
                            destructive: true,
                          );
                          if (!context.mounted) return;
                          if (ok == true) model.logout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _initial(ProfileViewModel model) {
    final name = (model.userData?["username"] as String?) ?? '';
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
