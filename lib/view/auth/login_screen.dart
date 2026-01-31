import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/view/auth/forget_password_screen.dart';
import 'package:moona/view/auth/signup_screen.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:moona/widgets/custom_text_button.dart';
import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:moona/widgets/password_text_field.dart';
import 'package:provider/provider.dart';

import '../../controller/user_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "/log_in";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    if (!_formKey.currentState!.validate()) return;

    try {
      await Provider.of<UserController>(context, listen: false).signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
          content: Text(
            "Invalid email or password",
            style: safeInter(
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.green,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 68),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Sign In",
                    style: safeInter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 150.h),
                CustomTextFormField(
                  label: "E-mail",
                  prefixIconPath: AssetsManager.emailIcon,
                  controller: _emailController,
                ),
                PasswordTextField(
                  label: "Password",
                  controller: _passwordController,
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      title: "Forget password?",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ForgetPasswordScreen.routeName,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                CustomElevatedButton(
                  title: "Sign In",
                  onTap: () {
                    _login();
                  },
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                      title: "Don't have an account?",
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
