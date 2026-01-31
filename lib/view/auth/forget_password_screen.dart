import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/auth/update_password.dart';
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
                validator: (value) {
                  return ValidationMethods.validateEmail(value);
                },
              ),
              SizedBox(height: 32.h),
              Center(
                child: Column(
                  children: [
                    CustomElevatedButton(
                      title: "Send Reset Token",
                      onTap: () async {
                        if (_formKey.currentState != null &&
                            !_formKey.currentState!.validate()) {
                          return;
                        }
                        await userController.requestResetToken(
                          email: _emailController.text,
                          themeController: themeController,
                          context: context,
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Container(
                                height: 150.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  color: themeController.isLight
                                      ? ColorsManager.white
                                      : ColorsManager.green,
                                  border: Border.all(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.gold,
                                    width: 4.w,
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your token has been sent!",
                                      style: GoogleFonts.inter(
                                        color: themeController.isLight
                                            ? ColorsManager.green
                                            : ColorsManager.gold,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        backgroundColor: themeController.isLight
                                            ? ColorsManager.green
                                            : ColorsManager.gold,
                                        foregroundColor: ColorsManager.white,
                                        fixedSize: Size(150.w, 40.h),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context); // close dialog
                                        Navigator.pushNamed(
                                          context,
                                          UpdatePassword.routeName,
                                          arguments: _emailController.text
                                              .trim(),
                                        );
                                      },
                                      child: Text("Continue"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 100.h),
                    Container(
                      padding: REdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.gold,
                          width: 2.w,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 34.sp,
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.gold,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "What will happen next?",
                                style: GoogleFonts.inter(
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.gold,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "1. We will send a reset token to your email.",
                            style: GoogleFonts.inter(
                              color: themeController.isLight
                                  ? ColorsManager.green
                                  : ColorsManager.gold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            "2. Check your inbox and spam folder",
                            style: GoogleFonts.inter(
                              color: themeController.isLight
                                  ? ColorsManager.green
                                  : ColorsManager.gold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            "3. Copy the token and use it for the next screen",
                            style: GoogleFonts.inter(
                              color: themeController.isLight
                                  ? ColorsManager.green
                                  : ColorsManager.gold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
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
