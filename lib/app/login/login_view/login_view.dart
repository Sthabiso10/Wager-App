import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/login/view_models/login_view_model.dart';
import 'package:wager_app/styles/colors.dart';

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
        body: Stack(
          children: [
            // 🔥 Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wager_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔥 Dark overlay to make the UI readable
            Container(
              color: Colors.black,
            ),

            // 🔥 Main content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        'assets/user.png',
                        height: 120,
                        color: Colors.white,
                      ),

                      const SizedBox(height: 20),

                      // Title
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      const Text(
                        'Enter your email and password to continue.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 35),

                      // Email
                      MyTextField(
                        hintText: 'Email',
                        obscureText: false,
                        controller: model.emailController,
                      ),

                      const SizedBox(height: 14),

                      // Password
                      MyTextField(
                        hintText: 'Password',
                        obscureText: true,
                        controller: model.passwordController,
                      ),

                      const SizedBox(height: 10),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: colorAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          isGradient: true,
                          isGlass: false,
                          text: 'Login',
                          onPressed: () {
                            model.login(context);
                          },
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Register Here",
                              style: TextStyle(
                                color: colorAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Divider
                      const Divider(
                        color: Colors.white24,
                        thickness: 1,
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'By continuing you agree to our Terms of Use\nand Privacy Policy.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🔥 Loading overlay
            if (model.isBusy) ...[
              const ModalBarrier(dismissible: false, color: Colors.black38),
              const Center(child: CircularProgressIndicator()),
            ]
          ],
        ),
      ),
    );
  }
}
