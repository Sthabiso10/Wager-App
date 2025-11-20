import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/helper_functions/helper_functions.dart';

class RegisterViewModel extends BaseViewModel {
  // Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

  // User registration method
  Future<void> registerUser(BuildContext context) async {
    listUserDocuments();
    if (!_validateInputs(context)) return;

    // Set the ViewModel to busy state
    setBusy(true);

    try {
      // Create a new user with FirebaseAuth
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Add user data to Firestore
      await _createUserDocument(userCredential);

      if (!context.mounted) return;

      displayMessageToUser(
          message: 'User created successfully!',
          context: context,
          type: MessageType.success);

      // Navigate to login or home screen
      await Navigator.pushNamed(context, '/auth'); // Adjust route as needed
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      if (context.mounted) {
        _handleAuthError(e, context);
      }
    } catch (e) {
      // Handle unexpected errors
      if (context.mounted) {
        displayMessageToUser(
            message: 'An unexpected error occurred. Please try again.',
            context: context,
            type: MessageType.failure);
      }
    } finally {
      // Set the ViewModel to idle state
      setBusy(false);
    }
  }

  // Input validation
  bool _validateInputs(BuildContext context) {
    if (userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        firstNameController.text.isEmpty) {
      displayMessageToUser(
          message: 'Please fill in all fields.',
          context: context,
          type: MessageType.failure);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      displayMessageToUser(
          message: "Passwords don't match.",
          context: context,
          type: MessageType.failure);
      return false;
    }
    return true;
  }

  Future<void> _createUserDocument(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) {
      throw Exception("User is null after registration.");
    }

    try {
      final userDocRef = FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid); // Use email as doc ID
      await userDocRef.set({
        'email': user.email,
        'username': userNameController.text.trim(),
        'firstName': firstNameController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint('User document created successfully.');
    } catch (e) {
      debugPrint('Error creating user document: $e');
    }
  }

  // Handle FirebaseAuth exceptions
  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage;
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'This email is already in use.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'weak-password':
        errorMessage = 'The password is too weak.';
        break;
      default:
        errorMessage = 'Registration failed. Please try again.';
        break;
    }
    displayMessageToUser(
        message: errorMessage, context: context, type: MessageType.failure);
  }

  @override
  void dispose() {
    // Dispose controllers when ViewModel is disposed
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();

    super.dispose();
  }

  Future<void> listUserDocuments() async {
    try {
      // Query the Users collection
      final querySnapshot =
          await FirebaseFirestore.instance.collection("Users").get();

      // Print the number of documents in the Users collection
      debugPrint(
          'Number of documents in Users collection: ${querySnapshot.size}');
    } catch (e) {
      debugPrint('Error getting documents: $e');
    }
  }
}
