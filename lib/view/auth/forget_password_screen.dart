import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/widgets/code_text_field.dart';
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
        leading: BackButton(
          color: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.gold,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forget Your Password?",
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
                "Enter your email address below to receive a password reset token.",
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green.withAlpha(150)
                      : ColorsManager.white,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                label: "Email",
                prefixIconPath: AssetsManager.emailIcon,
                controller: _emailController,
              ),
              SizedBox(height: 32.h),
              Center(
                child: Column(
                  children: [
                    CustomElevatedButton(
                      title: "Send Reset Token",
                      onTap: () {},
                    ),
                    Container(height: 60.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
