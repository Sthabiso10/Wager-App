import 'package:flutter/material.dart';
import 'package:wager_app/app/global_widgets/app_feedback.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

enum MessageType { success, failure }

/// Shows a modern, non-blocking toast. Kept with its original signature so all
/// existing call sites keep working — it now renders the new [AppToast] instead
/// of a blocking image dialog.
void displayMessageToUser({
  required String message,
  required BuildContext context,
  required MessageType type,
}) {
  AppToast.show(
    context,
    message: message,
    kind: type == MessageType.success ? ToastKind.success : ToastKind.error,
  );
}

/// A clean floating snackbar (kept for callers that use it directly).
void newEventSnackBar(
    String message, BuildContext context, Color containerColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.ink,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rMd),
      content: Text(
        message,
        style: AppText.body.copyWith(color: AppColors.onInk),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/// A pill-style dialog button used by the legacy dialogs.
Widget buildDialogButton({required String text, required Color color}) {
  final onColor =
      color == AppColors.surfaceMuted ? AppColors.textPrimary : Colors.white;
  return Container(
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(color: color, borderRadius: AppRadius.rMd),
    child: Text(text, style: AppText.label.copyWith(color: onColor)),
  );
}
