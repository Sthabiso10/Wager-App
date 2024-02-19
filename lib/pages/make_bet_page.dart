import 'package:flutter/material.dart';
import 'package:wager_app/themes/colors.dart';

class MakeBetPage extends StatelessWidget {
  const MakeBetPage({super.key});

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
            )),
      ),
    );
  }
}
