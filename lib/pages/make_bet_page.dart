import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/themes/colors.dart';
import 'package:wager_app/utils/bet_column.dart';

class MakeBetPage extends StatefulWidget {
  const MakeBetPage({Key? key}) : super(key: key);

  @override
  State<MakeBetPage> createState() => _MakeBetPageState();
}

class _MakeBetPageState extends State<MakeBetPage> {
  void saveBet() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: MyAppColors.containerColor,
          title: Text(
            'Invalid Input',
            style: GoogleFonts.workSans(color: MyAppColors.textColor),
          ),
          content: Text(
            'Please make sure all fields are entered',
            style: GoogleFonts.workSans(color: MyAppColors.textColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.workSans(color: MyAppColors.textColor),
                ))
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyAppColors.accentColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BetColumn(), // Assuming BetColumn is a widget that displays some content
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: saveBet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Save Bet',
                        style: GoogleFonts.workSans(
                            color: MyAppColors.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
