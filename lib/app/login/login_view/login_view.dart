import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/login/view_models/login_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

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
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl, vertical: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _BrandMark(),
                  const SizedBox(height: AppSpacing.xxl),
                  Text('Welcome back', style: AppText.display),
                  const SizedBox(height: 6),
                  Text('Sign in to pick up where you left off.',
                      style: AppText.bodyMuted),
                  const SizedBox(height: AppSpacing.xxxl),

                  MyTextField(
                    label: 'Email',
                    hintText: 'you@example.com',
                    obscureText: false,
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    controller: model.emailController,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  MyTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    icon: Icons.lock_outline_rounded,
                    controller: model.passwordController,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forgot password?',
                          style: AppText.label
                              .copyWith(color: AppColors.accentText)),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  MyButton(
                    text: 'Sign in',
                    isLoading: model.isBusy,
                    onPressed: () => model.login(context),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: AppText.bodyMuted),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text('Register',
                            style: AppText.label
                                .copyWith(color: AppColors.accentText)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'By continuing you agree to our Terms of Use\nand Privacy Policy.',
                    style: AppText.caption.copyWith(color: AppColors.textTertiary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The Watt logo lockup — the brand mark on a dark "app-icon" tile (the logo
/// artwork is black-backed, so the ink tile lets it read cleanly on the light
/// canvas).
class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: 0.28),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Image.asset('assets/watt_logo.png', fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Watt', style: AppText.h3.copyWith(letterSpacing: 0.2)),
      ],
    );
  }
}
