import 'dart:ui';

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
        backgroundColor: Colors.transparent, // CHANGED: Red to transparent
        resizeToAvoidBottomInset: false,
        extendBody: true, // CRITICAL: Extends body behind nav bar

        body: Stack(
          children: [
            // Your main content pages
            IndexedStack(
              index: model.selectedIndex,
              children: _pages,
            ),

            // Optional: Gradient overlay at bottom to enhance pill visibility
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  height: 100, // Height of gradient overlay
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black
                            .withOpacity(0.05), // Very subtle dark overlay
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5], // Only bottom half has overlay
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ---- FLOATING PILL NAV BAR ----
        bottomNavigationBar: Container(
          // Pill container with margins
          margin: const EdgeInsets.only(
            bottom: 20, // Distance from bottom of screen
            left: 24, // Left margin
            right: 24, // Right margin
          ),

          // Visual styling for the pill
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), // Pill shape
            color: containerColor.withOpacity(0.92), // Slightly transparent
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15), // Shadow color
                blurRadius: 12, // Shadow blur
                spreadRadius: 1, // Shadow spread
                offset: const Offset(0, 4), // Shadow position
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.25), // Subtle white border
              width: 1,
            ),
          ),

          // Clip to maintain pill shape
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8, // Horizontal blur
                sigmaY: 8, // Vertical blur
              ),
              child: Container(
                // Inner container for the navigation items
                decoration: BoxDecoration(
                  color: containerColor
                      .withOpacity(0.85), // More transparent inner
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16, // Horizontal padding
                    vertical: 10, // Vertical padding
                  ),
                  child: GNav(
                    // GNav configuration
                    backgroundColor: Colors.transparent,
                    gap: 8, // Space between icon and text
                    activeColor: Colors.white,
                    iconSize: 24, // Icon size
                    tabBackgroundColor:
                        Colors.white.withOpacity(0.2), // Active tab background
                    tabBorderRadius: 30, // Active tab border radius
                    tabActiveBorder: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                    curve: Curves.easeOutCubic, // Animation curve
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    duration: const Duration(milliseconds: 300),
                    selectedIndex: model.selectedIndex,
                    onTabChange: model.updateIndex,

                    // Navigation tabs
                    tabs: [
                      GButton(
                        icon: Icons.home_outlined,
                        leading: Image.asset(
                          'assets/home.png',
                          height: 22,
                          color: model.selectedIndex == 0
                              ? Colors.white // Active color
                              : Colors.white
                                  .withOpacity(0.85), // Inactive color
                        ),
                        text: "Home",
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11, // Smaller font for pill
                          letterSpacing: 0.3,
                        ),
                      ),
                      GButton(
                        icon: Icons.person_outlined,
                        leading: Image.asset(
                          'assets/user.png',
                          height: 22,
                          color: model.selectedIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.85),
                        ),
                        text: "Wagers",
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          letterSpacing: 0.3,
                        ),
                      ),
                      GButton(
                        icon: Icons.person_outlined,
                        leading: Image.asset(
                          'assets/user.png',
                          height: 22,
                          color: model.selectedIndex == 2
                              ? Colors.white
                              : Colors.white.withOpacity(0.85),
                        ),
                        text: "Profile",
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          letterSpacing: 0.3,
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
    );
  }
}
