import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/view_models/home_viewmodel.dart';
import 'package:wager_app/app/home/widgets/active_bets_widget.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) {
        model.loadUserData();
      },
      builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            top: true,
            right: true,
            left: true,
            bottom: true,
            minimum:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: GoogleFonts.workSans(
                            color: colorText,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          model.userData?['firstName'] ?? 'loading...',
                          style: TextStyle(
                            color: colorText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/friends');
                          },
                          child: Image.asset("assets/plus.png",
                              height: 35, color: Colors.white),
                        ),
                        spacingWidth16,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/inbox');
                          },
                          child: Image.asset("assets/noti.png",
                              height: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                spacingHeight16,
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    model.userData != null &&
                            model.userData!['firstName'] != null
                        ? model.userData!['firstName'][0]
                        : '',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Active Bets",
                  style: TextStyle(
                    color: colorText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Expanded(
                  child: ActiveBetsWidget(),
                ),
              ],
            ),
          )),
    );
  }
}
