import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/helper_functions/helper_functions.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Method to handle login
  Future<void> login(BuildContext context) async {
    if (!_validateInputs(context)) return;

    setBusy(true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!context.mounted) return;

      setBusy(false);

      await Navigator.pushNamed(context, '/auth'); // Adjust route as needed
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        setBusy(false);
        _handleAuthError(e, context);
      }
    } catch (e) {
      if (context.mounted) {
        setBusy(false);
      }
    }
  }

  // Input validation
  bool _validateInputs(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      displayMessageToUser(
          message: 'Please fill in all fields.',
          context: context,
          type: MessageType.failure);
      return false;
    }
    return true;
  }

  // Handle FirebaseAuth exceptions
  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email format.';
        break;
      case 'user-disabled':
        errorMessage = 'This account has been disabled.';
        break;
      default:
        errorMessage = 'Authentication failed. Please try again.';
        break;
    }
    displayMessageToUser(
        message: errorMessage, context: context, type: MessageType.failure);
  }

  // Loading handled via setBusy/isBusy overlay in the view

  @override
  void dispose() {
    // Clean up controllers when ViewModel is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
