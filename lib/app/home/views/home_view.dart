import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/view_models/home_viewmodel.dart';
import 'package:wager_app/app/home/widgets/actions_widget.dart';
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
          minimum: const EdgeInsets.all(16),
          child: SingleChildScrollView(
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

                    // Notification icon

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/friends');
                          },
                          child: Image.asset(
                            "assets/plus.png",
                            height: 40,
                            color: Colors.white,
                          ),
                        ),
                        spacingWidth16,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/inbox');
                          },
                          child: Image.asset(
                            "assets/noti.png",
                            height: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const ActionsWidget(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Friends ',
                      style: GoogleFonts.workSans(
                        color: colorText,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const ActiveBetsWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
