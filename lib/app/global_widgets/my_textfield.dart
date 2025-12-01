import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: colorText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: colorText,
          fontSize: 15,
        ),
        filled: true,
        fillColor: colorText, // subtle background
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),

        // Normal border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorText,
            width: 1.2,
          ),
        ),

        // When focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorAccent,
            width: 1.8,
          ),
        ),
      ),
    );
  }
}
