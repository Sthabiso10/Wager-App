import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/register/register_view_model/register_view_model.dart';
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
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wager_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Dark overlay
            Container(
              color: Colors.black,
            ),

            // Content
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
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      const Text(
                        'Fill in your details to get started.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 35),

                      // Username
                      MyTextField(
                        hintText: 'Username',
                        obscureText: false,
                        controller: model.userNameController,
                      ),
                      const SizedBox(height: 14),

                      // Email
                      MyTextField(
                        hintText: 'Email',
                        obscureText: false,
                        controller: model.emailController,
                      ),
                      const SizedBox(height: 14),

                      // First Name
                      MyTextField(
                        hintText: 'First Name',
                        obscureText: false,
                        controller: model.firstNameController,
                      ),
                      const SizedBox(height: 14),

                      // Password
                      MyTextField(
                        hintText: 'Password',
                        obscureText: true,
                        controller: model.passwordController,
                      ),
                      const SizedBox(height: 14),

                      // Confirm Password
                      MyTextField(
                        hintText: 'Confirm Password',
                        obscureText: true,
                        controller: model.confirmPasswordController,
                      ),

                      const SizedBox(height: 28),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          isGlass: false,
                          isGradient: true,
                          text: 'Register',
                          onPressed: () {
                            model.registerUser(context);
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Login Here",
                              style: TextStyle(
                                color: colorAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
