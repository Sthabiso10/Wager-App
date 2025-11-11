import 'package:flutter/material.dart';
import 'package:wager_app/app/profie/view_model/profile_viewmodel.dart';
import 'package:wager_app/styles/colors.dart';

class ProfileTile extends StatelessWidget {
  final ProfileViewModel model;
  final String title;
  final void Function()? onTap;

  const ProfileTile(
      {super.key, required this.model, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerColor,
        ),
        padding: const EdgeInsets.all(5),
        height: 65,
        child: Center(
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18, color: colorText),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
