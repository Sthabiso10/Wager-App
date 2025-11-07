import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/styles/colors.dart';

class EditBetPage extends StatelessWidget {
  const EditBetPage({
    super.key,
    required this.betTitle,
    required this.betDescription,
    required this.betAmount,
  });

  final String betTitle;
  final String betDescription;
  final String betAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colorAccent,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'R$betAmount',
                  style: GoogleFonts.workSans(
                      color: colorText,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: colorAccent,
              height: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              betDescription,
              style: GoogleFonts.workSans(
                  color: colorText,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
