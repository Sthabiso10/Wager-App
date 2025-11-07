import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../styles/colors.dart';

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
              color: containerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.add,
              size: 55,
              color: colorAccent,
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
                  color: colorText, fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              "Pick a topic, make a prediction",
              style: GoogleFonts.workSans(color: colorText, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
