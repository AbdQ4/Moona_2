import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';

import 'package:moona/controller/user_controller.dart';

// import 'package:moona/controller/validation_methods.dart';
// import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
// import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:moona/widgets/password_text_field.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_screen.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});
  static const String routeName = "/update_password";

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final themeController = Provider.of<ThemeController>(context);

    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Continue changing your password",
              style: GoogleFonts.inter(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.gold,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.h),
            TextFormField(
              controller: _tokenController,
              decoration: InputDecoration(
                label: Text(
                  "Token",
                  style: GoogleFonts.inter(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.key,
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.gold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsManager.red),
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            PasswordTextField(
              label: "New Password",
              controller: _passwordController,
            ),
            PasswordTextField(
              label: "Confirm Password",
              controller: _confirmController,
            ),
            const SizedBox(height: 24),
            Center(
              child: CustomElevatedButton(
                title: "Update Password",
                onTap: () async {
                  if (_passwordController.text != _confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }

                  try {
                    await Supabase.instance.client.auth.verifyOTP(
                      type: OtpType.recovery,
                      token: _tokenController.text.trim(),
                      email: email,
                    );

                    await userController.supabase.auth.updateUser(
                      UserAttributes(password: _passwordController.text),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password updated successfully"),
                      ),
                    );

                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
