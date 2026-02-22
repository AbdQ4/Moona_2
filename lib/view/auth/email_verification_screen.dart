import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/view/auth/login_screen.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String routeName = "/email_verification";

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    final userController = Provider.of<UserController>(context, listen: false);
    userController.fetchUserDetails();
    super.initState();
  }

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
            color: themeController.isLight ? Colors.white : Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Center(
                child: Text(
                  S.of(context).emailVerification,
                  style: GoogleFonts.inter(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                S.of(context).verificationEmailSent,
                textAlign: TextAlign.center,
                style: safeInter(
                  fontSize: 16.sp,
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.gold,
                ),
              ),
              SizedBox(height: 100.h),

              // Resend email
              CustomElevatedButton(
                title: S.of(context).resendVerificationEmail,
                onTap: () async {
                  final email = userController.user?.email;
                  if (email != null) {
                    await userController.resendEmail(context, email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        content: Text(S.of(context).verificationEmailResent),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 40.h),
              // Continue button
              CustomElevatedButton(
                title: S.of(context).continueText,
                onTap: () =>
                    _checkVerification(themeController, userController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkVerification(
    ThemeController themeController,
    UserController userController,
  ) async {
    try {
      final auth = Supabase.instance.client.auth;

      // Attempt to refresh the session first
      try {
        await auth.refreshSession();
      } catch (e) {
        // Refresh failed (likely expired refresh token)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).sessionExpiredMessage)),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        return;
      }

      final session = auth.currentSession;
      if (session == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).sessionExpiredMessage)),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        return;
      }

      final response = await auth.getUser();
      final refreshedUser = response.user;

      if (refreshedUser == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).sessionExpiredMessage)),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
        return;
      }

      if (refreshedUser.emailConfirmedAt != null) {
        debugPrint("✅ Email verified at: ${refreshedUser.emailConfirmedAt}");

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).verificationSuccess)),
          );

          await auth.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      } else {
        debugPrint("❌ Email not verified yet");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).emailNotVerified)),
          );
        }
      }
    } catch (e, st) {
      debugPrint("❌ Verification error: $e\n$st");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(S.of(context).error)));
      }
    }
  }
}
