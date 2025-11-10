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
        builder: (context, model, child) => Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                left: true,
                right: true,
                top: true,
                bottom: true,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back,",
                                style: GoogleFonts.workSans(
                                  color: colorText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text('Sthabiso Damini',
                                  style: GoogleFonts.workSans(
                                      color: colorText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.local_fire_department,
                                color: Colors.red.shade400,
                                size: 35,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MakeBetContainer(onTap: () => model.openNewBetPage),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.betData.length,
                            itemBuilder: (BuildContext context, int index) {
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
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
