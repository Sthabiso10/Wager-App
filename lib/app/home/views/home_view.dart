import 'package:cloud_firestore/cloud_firestore.dart';
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                future: model.getFirstName(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text(
                                      "Loading...",
                                      style: TextStyle(
                                          color: colorText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "Error: ${snapshot.error}",
                                      style: TextStyle(
                                          color: colorText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else if (snapshot.hasData &&
                                      snapshot.data?.data() != null) {
                                    Map<String, dynamic>? data = snapshot.data!
                                        .data(); // Extract data map
                                    String firstName = data?['firstName'] ??
                                        "No First Name"; // Handle null
                                    return Text(
                                      firstName,
                                      style: TextStyle(
                                          color: colorText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      "No data available",
                                      style: TextStyle(
                                          color: colorText,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("assets/noti.png",
                                  height: 35, color: Colors.white),
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
