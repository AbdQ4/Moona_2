import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'update_password.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  static const String routeName = "/forget_password";

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final theme = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: theme.isLight ? ColorsManager.green : ColorsManager.gold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password?",
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: theme.isLight ? ColorsManager.green : ColorsManager.gold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Enter your email to receive a verification Link.",
              style: GoogleFonts.inter(fontSize: 14.sp),
            ),
            SizedBox(height: 30.h),

            CustomTextFormField(
              label: "Email",
              prefixIconPath: AssetsManager.emailIcon,
              controller: _emailController,
            ),

            SizedBox(height: 40.h),

            Center(
              child: CustomElevatedButton(
                title: "Send Link",
                onTap: () async {
                  if (_emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter your email.")),
                    );
                    return;
                  }
                  try {
                    await Supabase.instance.client.auth.resetPasswordForEmail(
                      _emailController.text.toLowerCase().trim(),
                    );
                  } catch (e) {
                    debugPrint("Error sending link: $e");
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
