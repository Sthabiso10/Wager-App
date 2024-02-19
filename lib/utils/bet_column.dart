import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class BetColumn extends StatelessWidget {
  const BetColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style:
              GoogleFonts.workSans(color: MyAppColors.textColor, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: MyAppColors.containerColor,
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: GoogleFonts.workSans(
                color: MyAppColors.accentColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Description',
          style:
              GoogleFonts.workSans(color: MyAppColors.textColor, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: MyAppColors.containerColor,
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'UCL Winner',
              hintStyle: GoogleFonts.workSans(
                color: MyAppColors.accentColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Amount',
          style:
              GoogleFonts.workSans(color: MyAppColors.textColor, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: MyAppColors.containerColor,
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'R200',
              hintStyle: GoogleFonts.workSans(
                color: MyAppColors.accentColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
