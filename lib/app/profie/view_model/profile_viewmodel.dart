import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/helper_functions/helper_functions.dart';

class ProfileViewModel extends BaseViewModel {
  final TextEditingController updateUsernameController =
      TextEditingController();
  User? get currentUser => FirebaseAuth.instance.currentUser;

  void openTermsAndConditions(BuildContext context) {
    displayMessageToUser(
        message: 'Terms and Conditions not available',
        context: context,
        type: MessageType.failure);
  }

  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // Check if the widget is still mounted before using the context
      if (!context.mounted) return;

      displayMessageToUser(
          message: 'You have successfully logged out.',
          context: context,
          type: MessageType.success);

      // Optional: Navigate to a login page or clear the state

      notifyListeners();
    } catch (e) {
      // Safely handle errors
      if (context.mounted) {
        displayMessageToUser(
            message: 'Logout failed: $e',
            context: context,
            type: MessageType.failure);
      }
    }
  }

  Map<String, dynamic>? userData;

  Future<void> loadUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    userData = doc.data();
    notifyListeners();
  }

  void updateProfilePicture() {}
}
