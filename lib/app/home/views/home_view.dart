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
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () => model.openSettings(context),
                      icon: Icon(
                        Icons.settings,
                        color: colorAccent,
                        size: 35,
                      ))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Make a bet",
                        style: GoogleFonts.workSans(
                            color: colorText,
                            fontSize: 35,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
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
