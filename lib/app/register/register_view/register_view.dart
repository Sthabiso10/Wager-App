import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:wager_app/app/global_widgets/my_button.dart';
import 'package:wager_app/app/global_widgets/my_textfield.dart';
import 'package:wager_app/app/register/register_view_model/register_view_model.dart';
import 'package:wager_app/styles/colors.dart';
import 'package:wager_app/styles/dimensions.dart';
import 'package:wager_app/styles/text_styles.dart';

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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: widget.onTap != null
              ? IconButton(
                  onPressed: widget.onTap,
                  icon: const Icon(Icons.arrow_back_rounded),
                )
              : null,
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(AppSpacing.xxl, AppSpacing.sm,
                AppSpacing.xxl, AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Create account', style: AppText.display),
                const SizedBox(height: 6),
                Text('A few details and you’re ready to wager.',
                    style: AppText.bodyMuted),
                const SizedBox(height: AppSpacing.xxl),

                MyTextField(
                  label: 'Username',
                  hintText: 'Choose a username',
                  obscureText: false,
                  icon: Icons.alternate_email_rounded,
                  controller: model.userNameController,
                ),
                const SizedBox(height: AppSpacing.lg),
                MyTextField(
                  label: 'First name',
                  hintText: 'Your first name',
                  obscureText: false,
                  icon: Icons.person_outline_rounded,
                  controller: model.firstNameController,
                ),
                const SizedBox(height: AppSpacing.lg),
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
                  hintText: 'Create a password',
                  obscureText: true,
                  icon: Icons.lock_outline_rounded,
                  controller: model.passwordController,
                ),
                const SizedBox(height: AppSpacing.lg),
                MyTextField(
                  label: 'Confirm password',
                  hintText: 'Re-enter your password',
                  obscureText: true,
                  icon: Icons.lock_outline_rounded,
                  controller: model.confirmPasswordController,
                ),
                const SizedBox(height: AppSpacing.xxl),

                MyButton(
                  text: 'Create account',
                  isLoading: model.isBusy,
                  onPressed: () => model.registerUser(context),
                ),
                const SizedBox(height: AppSpacing.xl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: AppText.bodyMuted),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Sign in',
                          style:
                              AppText.label.copyWith(color: AppColors.accentText)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
