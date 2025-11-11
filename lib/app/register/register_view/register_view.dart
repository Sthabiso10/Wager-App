import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/profie/views/register/register_view_model/register_view_model.dart';
import 'package:wager_app/styles/colors.dart';

class RegisterView extends StatefulWidget {
  final void Function()? onTap;

  const RegisterView({super.key, this.onTap});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/user.png',
                    height: 140,
                    color: Colors.white,
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                        color: colorText,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const Text(
                    'Please create a new account to continue.',
                    style: TextStyle(color: Colors.white60, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MyTextField(
                      hintText: 'Username',
                      obscureText: false,
                      controller: model.userNameController),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      hintText: 'Email',
                      obscureText: false,
                      controller: model.emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hintText: 'First Name ',
                    obscureText: false,
                    controller: model.firstNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: model.passwordController),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    hintText: 'Confirm Password',
                    obscureText: true,
                    controller: model.confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: colorText, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    text: 'Register',
                    onPressed: () {
                      model.registerUser(context);
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: colorText, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Here",
                        style: TextStyle(
                            color: colorAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
