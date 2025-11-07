import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../styles/colors.dart';

class BetTile extends StatelessWidget {
  final String betTitle;
  final String betDescription;
  final String betAmount;
  final DateTime selectedDate; // Add this property

  const BetTile({
    Key? key,
    required this.betTitle,
    required this.betDescription,
    required this.betAmount,
    required this.selectedDate, // Update constructor
    required this.selectedBet,
  }) : super(key: key);

  final void Function() selectedBet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        splashColor: colorAccent,
        borderRadius: BorderRadius.circular(10),
        onTap: selectedBet,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: containerColor,
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
                          color: colorText,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      betDescription,
                      style:
                          GoogleFonts.workSans(color: colorText, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      'Date: ${DateFormat.yMd().format(selectedDate)}', // Display the date
                      style: TextStyle(
                        color: colorText,
                        fontSize: 16,
                      ),
                    ),
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
                        color: colorText,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    betAmount,
                    style: GoogleFonts.workSans(
                        color: colorText,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
