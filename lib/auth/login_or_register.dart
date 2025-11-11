import 'package:flutter/material.dart';
import 'package:wager_app/app/login/login_view/login_view.dart';
import 'package:wager_app/app/profie/views/register/register_view/register_view.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // show login page first
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginView(
        onTap: togglePages,
      );
    } else {
      return RegisterView(
        onTap: togglePages,
      );
    }
  }
}
