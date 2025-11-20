import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/add_friends/add_friends_view_model/add_friends_view_model.dart';
import 'package:wager_app/styles/colors.dart';

class AddFriendsSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const AddFriendsSearchField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddFriendsViewModel>.reactive(
        viewModelBuilder: () => AddFriendsViewModel(),
        builder: (context, model, child) => Container(
              height: 60,
              width: double.infinity, // Apply width to the Container
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ));
  }
}
