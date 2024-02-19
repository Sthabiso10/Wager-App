import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/themes/colors.dart';
import 'package:wager_app/utils/bet_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void openSettings() {}
List betData = [
  [
    'UCL Winner',
    'Daniel says Arsenal will win the chanmpions league and Ethan does not',
    '200',
  ],
  ['Best out of 3', 'Ethab says he will have more than 2', '50'],
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          IconButton(
              onPressed: openSettings,
              icon: Icon(
                Icons.settings,
                color: MyAppColors.accentColor,
                size: 35,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyAppColors.containerColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 55,
                    color: MyAppColors.accentColor,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Bet",
                      style: GoogleFonts.workSans(
                          color: MyAppColors.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Text(
                      "Pick a topic, make a prediction",
                      style: GoogleFonts.workSans(
                          color: MyAppColors.textColor, fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
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
    );
  }
}
