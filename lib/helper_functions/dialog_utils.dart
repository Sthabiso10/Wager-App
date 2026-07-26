import 'package:flutter/material.dart';
import 'package:wager_app/app/global_widgets/app_feedback.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

/// A polished input dialog for naming something (e.g. a template), matching the
/// app's design system with a springy entrance.
Future<void> showTemplateNameDialog(
    BuildContext context, Function(String) onSave) async {
  final controller = TextEditingController();
  final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Template name',
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    transitionDuration:
        reduceMotion ? Duration.zero : const Duration(milliseconds: 260),
    pageBuilder: (context, _, __) => const SizedBox.shrink(),
    transitionBuilder: (context, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
      return Opacity(
        opacity: anim.value.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: reduceMotion ? 1.0 : (0.92 + 0.08 * curved.value),
          child: Dialog(
            backgroundColor: AppColors.surface,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.rXl),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Template name', style: AppText.h2),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Give this template a name so you can reuse it later.',
                      style: AppText.bodyMuted),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    cursorColor: AppColors.ink,
                    style: AppText.body.copyWith(fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(hintText: 'e.g. Weekend bet'),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    children: [
                      Expanded(
                        child: _pill(
                          label: 'Cancel',
                          bg: AppColors.surfaceMuted,
                          fg: AppColors.textPrimary,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _pill(
                          label: 'Save',
                          bg: AppColors.ink,
                          fg: Colors.white,
                          onTap: () {
                            final name = controller.text.trim();
                            if (name.isNotEmpty) {
                              Navigator.pop(context);
                              onSave(name);
                            } else {
                              AppToast.error(
                                  context, 'Please enter a name first.');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _pill({
  required String label,
  required Color bg,
  required Color fg,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, borderRadius: AppRadius.rMd),
      child: Text(label, style: AppText.label.copyWith(color: fg)),
    ),
  );
}
