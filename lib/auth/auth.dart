import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wager_app/app/navigation%20bar/views/navigation_view.dart';
import 'package:wager_app/auth/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //Added this to the root of the project to prevent keyboard pushing widgets
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationMenu();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
