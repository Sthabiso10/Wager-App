import 'package:flutter/material.dart';
import 'package:wager_app/styles/colors.dart';

Future<void> showTemplateNameDialog(
    BuildContext context, Function(String) onSave) async {
  final TextEditingController templateNameController = TextEditingController();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: containerColor,
        title: Text('Template Name', style: TextStyle(color: colorText)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: buildDialogButton(
                        text: 'Cancel', color: backgroundColor),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final templateName = templateNameController.text;
                      if (templateName.isNotEmpty) {
                        Navigator.pop(context);
                        onSave(templateName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter a name for the template.'),
                          ),
                        );
                      }
                    },
                    child: buildDialogButton(text: 'Save', color: colorAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// Button widget (stays in this file)
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
