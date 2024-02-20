import 'package:flutter/material.dart';
import 'package:wager_app/themes/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: MyAppColors.accentColor,
      child: Text(text),
    );
  }
}
