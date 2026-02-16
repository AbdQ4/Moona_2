import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/checkbox_controller.dart';
import 'package:moona/controller/chekout_controller.dart';
import 'package:moona/controller/payment_controller.dart';
import 'package:moona/controller/quantity_dialog_provider.dart';
import 'package:moona/controller/supplier_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/license_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/user_role_controller.dart';
import 'package:moona/moona.dart';
import 'package:moona/supabase/auth_service.dart';
import 'package:moona/supabase/deep_links_service.dart';
import 'package:moona/view/auth/update_password.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String publishable_key =
    "pk_test_51Sxsb5I7gTKKDGgsML2Z3luBUWrh9h8U4DVyCoZkddGeYW6cbhH4BKR7QIdTlN0zgvNRj3DGtJ8IbXwadbgPzp8q005Low5Xy7";

String secret_key =
    "sk_test_51Sxsb5I7gTKKDGgsSx8LF3uFyFQDX0W30jcsza1iUhE2FuOjFwQNAG8jmJNg0MilHvi41PENbOOez0N186ugVoRI00uLhBrNQt";
void main() async {
  Stripe.publishableKey = publishable_key;
  Stripe.instance.applySettings();

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ixxvyhwmysedbjvwxvnn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4eHZ5aHdteXNlZGJqdnd4dm5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU0MTA0NDgsImV4cCI6MjA3MDk4NjQ0OH0.lZ1_5eJve9eywMoV0hCVT1Cj4gd6tWamg2wrCKt4w4k',
  );
  await DeepLinkService().initAppLinks();
  final navigatorKey = Moona.navigatorKey;

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;

    if (event == AuthChangeEvent.passwordRecovery) {
      navigatorKey.currentState?.pushNamed(UpdatePassword.routeName);
    }
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => UserRoleController()),
        ChangeNotifierProvider(create: (_) => CheckboxController()),
        ChangeNotifierProvider(create: (_) => LicenseController()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserController(navigatorKey)),
        ChangeNotifierProvider(create: (_) => SupplierController()),
        ChangeNotifierProvider(create: (_) => AdditemProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CardDetailsController()),
        ChangeNotifierProvider(create: (_) => CheckoutController()),
        ChangeNotifierProvider(
          create: (_) => QuantityDialogProvider(pricePerTon: 1000),
        ),
      ],
      child: Moona(),
    ),
  );
}
