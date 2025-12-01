import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/views/home_view.dart';
import 'package:wager_app/app/navigation%20bar/view_models/navigation_view_model.dart';
import 'package:wager_app/app/profie/views/profile_view.dart';
import 'package:wager_app/app/wagers/wager_view/wager_view.dart';
import 'package:wager_app/styles/colors.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  final List<Widget> _pages = [
    const HomeView(),
    const WagerView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationMenuViewModel>.reactive(
      viewModelBuilder: () => NavigationMenuViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: model.selectedIndex,
          children: _pages,
        ),

        // ---- FLOATING PILL NAV BAR ----
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Material(
            elevation: 12, // shadow
            borderRadius: BorderRadius.circular(50), // pill shape
            color: containerColor, // nav background color
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: GNav(
                backgroundColor: Colors.transparent, // let Material show
                gap: 10,
                activeColor: Colors.white,
                iconSize: 26,
                tabBackgroundColor: Colors.white.withOpacity(0.08),
                tabActiveBorder: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(milliseconds: 350),
                selectedIndex: model.selectedIndex,
                onTabChange: model.updateIndex,
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    leading: Image.asset(
                      'assets/home.png',
                      height: 24,
                      color: model.selectedIndex == 0
                          ? Colors.white
                          : Colors.white70,
                    ),
                    text: "Home",
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GButton(
                    icon: Icons.person_outlined,
                    leading: Image.asset(
                      'assets/user.png',
                      height: 24,
                      color: model.selectedIndex == 1
                          ? Colors.white
                          : Colors.white70,
                    ),
                    text: "Wagers",
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GButton(
                    icon: Icons.person_outlined,
                    leading: Image.asset(
                      'assets/user.png',
                      height: 24,
                      color: model.selectedIndex == 2
                          ? Colors.white
                          : Colors.white70,
                    ),
                    text: "Profile",
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
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
