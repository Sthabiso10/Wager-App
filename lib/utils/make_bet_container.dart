import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class MakeBetContainer extends StatelessWidget {
  final VoidCallback onTap;

  const MakeBetContainer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
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
    );
  }
}
