import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/pages/make_bet_page.dart';
import 'package:wager_app/themes/colors.dart';
import 'package:wager_app/utils/bet_tile.dart';
import 'package:wager_app/utils/make_bet_container.dart';

import 'pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List betData = [
  [
    'UCL Winner',
    'Daniel says Arsenal will win the chanmpions league and Ethan does not',
    '200',
  ],
  [
    'Best out of 3',
    'Ethab says he will have more than 2',
    '50',
  ],
];

class _HomePageState extends State<HomePage> {
  void openSettings() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    });
  }

  void openNewBetPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MakeBetPage(
          onSaveBet: (newBet) {
            setState(() {
              betData.add(newBet); // Add the new bet data to betData list
            });
          },
        ),
      ),
    );
  }

  void addNewBet(List<String> newBet) {
    setState(() {
      betData.add(newBet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: openSettings,
              icon: const Icon(
                Icons.settings,
                color: MyAppColors.accentColor,
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
                    color: MyAppColors.textColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 30,
              ),
              MakeBetContainer(onTap: openNewBetPage),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: betData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BetTile(
                          betTitle: betData[index][0],
                          betDescription: betData[index][1],
                          betAmount: betData[index][2]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
