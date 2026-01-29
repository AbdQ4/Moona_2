import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/routes_manager.dart';
import 'package:moona/core/theme_manager.dart';
import 'package:moona/view/auth/auth_redirect.dart';
import 'package:moona/view/auth/login_screen.dart';
import 'package:moona/view/auth/signup_screen.dart';
import 'package:moona/view/auth/update_password.dart';
import 'package:provider/provider.dart';

class Moona extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const Moona({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: LoginScreen.routeName, //AuthRedirect.routeName,
        routes: RoutesManager.appRoutes,
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.darkTheme,
        themeMode: themeController.isLight ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}

/// logic el auth
/// UI signIn - emailVerification - forgetPassword
