import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:moona/widgets/password_text_field.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';
import '../../core/colors_manager.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({super.key});
  static const String routeName = "/update_password";

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Center(
              child: Text(
                "Update Password",
                style: safeInter(
                  fontSize: 30.sp,
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 80.h),
            PasswordTextField(
              label: "Password",
              controller: _passwordController,
              validator: ValidationMethods.validatePassword,
            ),
            SizedBox(height: 30.h),
            CustomElevatedButton(
              title: "Update password",
              onTap: () {
                userController.updatePassword(
                  context: context,
                  newPassword: _passwordController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
