import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/model/user_model.dart';
import 'package:moona/view/contractor/contractor_main_layout.dart';
import 'package:moona/view/supplier/supplier_main_layout.dart';
import 'package:moona/view/auth/login_screen.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  static const String routeName = "/pending_screen";

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late UserController userController;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    userController = Provider.of<UserController>(context, listen: false);
    _startCheckingAcceptance();
  }

  /// Poll every 3 seconds to check if admin accepted the user
  void _startCheckingAcceptance() async {
    while (_checking && mounted) {
      try {
        final freshUser = await userController.fetchUserDetails();

        if (freshUser == null) {
          // If user somehow disappeared, send to login
          _checking = false;
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          break;
        }

        if (freshUser.isAccepted) {
          _checking = false;
          _navigateToNextScreen(freshUser.role!, freshUser);
          break;
        }
      } catch (e) {
        debugPrint("Error checking acceptance: $e");
      }

      await Future.delayed(const Duration(seconds: 3));
    }
  }

  void _navigateToNextScreen(String role, UserModel user) {
    if (!mounted) return;

    if (role == "contractor") {
      Navigator.pushReplacementNamed(context, ContractorMainLayout.routeName);
    } else if (role == "supplier") {
      Navigator.pushReplacementNamed(context, SupplierMainLayout.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  void dispose() {
    _checking = false; // stop polling
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pending_actions,
                  size: 60.sp,
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.gold,
                ),
                SizedBox(height: 80.h),
                Text(
                  "Your account is being verified by admin.\nPlease wait...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                ),
                SizedBox(height: 40.h),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
