import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/colors.dart';

class BetTile extends StatelessWidget {
  final String betTitle;
  final String betDescription;
  final String betAmount;

  const BetTile(
      {super.key,
      required this.betTitle,
      required this.betDescription,
      required this.betAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: MyAppColors.containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    betTitle,
                    style: GoogleFonts.workSans(
                        color: MyAppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    betDescription,
                    style: GoogleFonts.workSans(
                        color: MyAppColors.textColor, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Row(
              children: [
                Text(
                  "R",
                  style: GoogleFonts.workSans(
                      color: MyAppColors.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  betAmount,
                  style: GoogleFonts.workSans(
                      color: MyAppColors.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
