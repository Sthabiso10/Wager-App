import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/views/home_view.dart';
import 'package:wager_app/app/navigation%20bar/view_models/navigation_view_model.dart';
import 'package:wager_app/app/profie/views/profile_view.dart';
import 'package:wager_app/app/wagers/wager_view/wager_view.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  final List<Widget> _pages = const [
    HomeView(),
    WagerView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationMenuViewModel>.reactive(
      viewModelBuilder: () => NavigationMenuViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: IndexedStack(
          index: model.selectedIndex,
          children: _pages,
        ),

        // ---- Floating light pill nav bar ----
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 22),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.ink.withValues(alpha: 0.10),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.md),
              child: GNav(
                backgroundColor: Colors.transparent,
                gap: 8,
                color: AppColors.textTertiary,
                activeColor: AppColors.goldOnDark,
                iconSize: 22,
                tabBackgroundColor: AppColors.ink,
                tabBorderRadius: AppRadius.pill,
                curve: Curves.easeOutCubic,
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                selectedIndex: model.selectedIndex,
                onTabChange: (index) {
                  HapticFeedback.selectionClick();
                  model.updateIndex(index);
                },
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    text: "Home",
                    textStyle: AppText.label.copyWith(color: AppColors.goldOnDark),
                  ),
                  GButton(
                    icon: Icons.receipt_long_rounded,
                    text: "Wagers",
                    textStyle: AppText.label.copyWith(color: AppColors.goldOnDark),
                  ),
                  GButton(
                    icon: Icons.person_rounded,
                    text: "Profile",
                    textStyle: AppText.label.copyWith(color: AppColors.goldOnDark),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
