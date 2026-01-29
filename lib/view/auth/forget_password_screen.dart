import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  static const String routeName = "/forget_password";

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final themeController = Provider.of<ThemeController>(context);
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
            Form(
              key: _formKey,
              child: Center(
                child: Text(
                  "Forget Password",
                  style: safeInter(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.h),
            CustomTextFormField(
              label: "E-mail",
              prefixIconPath: AssetsManager.emailIcon,
              validator: ValidationMethods.validateEmail,
              controller: _emailController,
            ),
            SizedBox(height: 40.h),
            CustomElevatedButton(
              title: "Reset Password",
              onTap: () {
                String email = _emailController.text;
                userController.resetPassword(email: email, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// After the user clicks the link, they’ll be redirected back to your app. You need to handle onAuthStateChange or supabase.auth.onAuthStateChange to let the user set a new password (using supabase.auth.updateUser).
