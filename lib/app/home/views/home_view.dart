import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/home/view_models/home_viewmodel.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/app/home/widgets/bet_tile.dart';
import 'package:wager_app/app/home/widgets/make_bet_container.dart';

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
                const SizedBox(height: 20),
                MakeBetContainer(
                  onTap: () => model.openNewBetPage(context),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.betData.length,
                    itemBuilder: (context, index) {
                      return BetTile(
                        betTitle: model.betData[index][0],
                        betDescription: model.betData[index][1],
                        betAmount: model.betData[index][2],
                        selectedBet: () {
                          model.editBet(
                            model.betData[index][0],
                            model.betData[index][1],
                            model.betData[index][2],
                            context,
                          );
                        },
                        selectedDate: model.betDate,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
