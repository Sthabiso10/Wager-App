import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: colorText),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: hintText),
      obscureText: obscureText,
      style: TextStyle(color: colorText),
    );
  }
}
