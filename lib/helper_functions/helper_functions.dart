import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

enum MessageType { success, failure }

void displayMessageToUser({
  required String message,
  required BuildContext context,
  required MessageType type, // Use an enum to specify the message type
}) {
  // Map message types to corresponding images
  final Map<MessageType, String> imagePaths = {
    MessageType.success: 'assets/icons/success.png',
    MessageType.failure: 'assets/icons/failure.png',
  };

  // Retrieve the image path based on the type
  String imagePath = imagePaths[type]!;

  // Determine the color of the strip based on the message type
  Color stripColor = type == MessageType.success ? colorAccent : Colors.red;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      contentPadding: EdgeInsets.zero, // Remove default padding
      content: Column(
        mainAxisSize: MainAxisSize.min, // Prevent dialog stretching
        children: [
          // Add a color strip at the top
          Container(
            height: 8, // Height of the color strip
            width: double.infinity,
            decoration: BoxDecoration(
              color: stripColor, // Use the determined color
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding for dialog content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagePath), // Use the image path from the map
                spacingHeight16,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: colorText,
                      fontWeight: FontWeight.bold),
                ),
                spacingHeight16,
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 17),
                      child: Center(
                        child: Text(
                          'Close',
                          style: TextStyle(color: colorText, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void newEventSnackBar(
    String message, BuildContext context, Color containerColor) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      backgroundColor: containerColor, // Use the provided color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      padding: const EdgeInsets.all(0), // Remove default padding
      content: Container(
        height: 60, // Customize height
        alignment: Alignment.center,
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center align the text
        ),
      ),
    ),
  );
}

Widget buildDialogButton({required String text, required Color color}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 17),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: colorText, fontSize: 18),
        ),
      ),
    ),
  );
}
