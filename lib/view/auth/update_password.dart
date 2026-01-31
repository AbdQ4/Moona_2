import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:moona/widgets/password_text_field.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';
import '../../core/colors_manager.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});
  static const String routeName = "/update_password";

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (ModalRoute.of(context) != null) {
      final userEmail = ModalRoute.of(context)!.settings.arguments as String?;
      if (userEmail != null) {
        _emailController.text = userEmail;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final userController = Provider.of<UserController>(context);
    final userEmail =
        ModalRoute.of(context)!.settings.arguments as TextEditingController?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isLight
                ? ColorsManager.green
                : ColorsManager.gold,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create New Password",
              style: GoogleFonts.inter(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.gold,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Enter the token from your email and set your new password",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: themeController.isLight
                    ? ColorsManager.green.withAlpha(150)
                    : ColorsManager.white,
              ),
            ),
            SizedBox(height: 32.h),
            CustomTextFormField(
              label: "Token",
              prefixIconPath: AssetsManager.taxIcon,
              controller: _tokenController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            CustomTextFormField(
              label: "Email",
              prefixIconPath: AssetsManager.emailIcon,
              controller: userEmail ?? _emailController,
              validator: (value) => ValidationMethods.validateEmail(value),
            ),
            PasswordTextField(
              label: "Password",
              controller: _passwordController,
              validator: (value) => ValidationMethods.validatePassword(value),
            ),
            PasswordTextField(
              label: "Confirm Password",
              controller: _confirmPasswordController,
              validator: (value) => ValidationMethods.validateConfirmPassword(
                value,
                _passwordController.text,
              ),
            ),
            SizedBox(height: 32.h),
            Center(
              child: Column(
                children: [
                  CustomElevatedButton(title: "Update Password", onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
