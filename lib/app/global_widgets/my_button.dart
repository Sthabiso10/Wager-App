import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isGlass;
  final bool isGradient;
  final bool neonGlow;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isGlass = false,
    this.isGradient = false,
    this.neonGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    final borderRadius = BorderRadius.circular(12);

    if (isGlass) {
      // Glass button using Color.fromRGBO instead of .withOpacity
      decoration = BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: borderRadius,
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.1),
          width: 1,
        ),
        boxShadow: [
          if (neonGlow)
            const BoxShadow(
              color: Color.fromRGBO(0, 217, 255, 0.4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
        ],
      );
    } else if (isGradient) {
      decoration = BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF02C697), Color(0xFF00FF00)], // primary → secondary
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius,
        boxShadow: [
          if (neonGlow)
            const BoxShadow(
              color: Color.fromRGBO(0, 217, 255, 0.4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          const BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      );
    } else {
      // Default solid button
      decoration = BoxDecoration(
        color: colorAccent,
        borderRadius: borderRadius,
        boxShadow: [
          if (neonGlow)
            const BoxShadow(
              color: Color.fromRGBO(0, 217, 255, 0.4),
              blurRadius: 20,
              spreadRadius: 1,
            ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: isGlass
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
