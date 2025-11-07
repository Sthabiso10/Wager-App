import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/login/view_models/login_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';

class LoginView extends StatefulWidget {
  final void Function()? onTap;
  const LoginView({super.key, this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/user.png',
                        height: 140,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: colorText,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const Text(
                        'Enter email and password to login.',
                        style: TextStyle(color: Colors.white60, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                          hintText: 'Email',
                          obscureText: false,
                          controller: model.emailController),
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
                          text: 'Login',
                          onPressed: () {
                            model.login(context);
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: colorText, fontSize: 16),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Register Here",
                              style: TextStyle(
                                  color: colorAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      spacingHeight16,
                      Divider(
                        color: colorText,
                        thickness: 1,
                      ),
                      spacingHeight16,
                      const Text(
                        'By continuing you agree to our Terms of Use and Privacy Policy.',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (model.isBusy) ...[
              const ModalBarrier(dismissible: false, color: Colors.black26),
              const Center(child: CircularProgressIndicator()),
            ]
          ],
        ),
      ),
    );
  }
}
