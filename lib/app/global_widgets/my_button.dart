import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: colorAccent,
      child: Text(text),
    );
  }
}
