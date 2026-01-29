import 'package:flutter/material.dart';
import 'package:moona/view/auth/login_screen.dart';
import 'package:moona/view/auth/pending_screen.dart';
import 'package:moona/view/contractor/contractor_main_layout.dart';
import 'package:moona/view/supplier/supplier_main_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRedirect extends StatefulWidget {
  const AuthRedirect({super.key});

  static const String routeName = "/auth-redirect";

  @override
  State<AuthRedirect> createState() => _AuthRedirectState();
}

class _AuthRedirectState extends State<AuthRedirect> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final session = supabase.auth.currentSession;

      if (session == null) {
        debugPrint("No session found → Go to Login");
        _goTo(LoginScreen.routeName);
        return;
      }

      // 🔄 Always try to get fresh user from Supabase
      final response = await supabase.auth.getUser();
      final user = response.user;

      if (user == null) {
        debugPrint(
          "No user in response → likely expired/invalid session, signing out",
        );
        await supabase.auth.signOut();
        _goTo(LoginScreen.routeName);
        return;
      }

      // 🔹 Check email verification
      if (user.emailConfirmedAt == null) {
        debugPrint("User not verified → PendingScreen");
        _goTo(PendingScreen.routeName);
        return;
      }

      // 🔹 Fetch role & acceptance status from DB
      final userData = await supabase
          .from("users")
          .select("role, is_accepted")
          .eq("id", user.id)
          .maybeSingle();

      if (userData == null) {
        debugPrint("No user row in DB → Login");
        await supabase.auth.signOut();
        _goTo(LoginScreen.routeName);
        return;
      }

      final role = userData['role'] as String?;
      final isAccepted = userData['is_accepted'] as bool? ?? false;

      if (!isAccepted) {
        debugPrint("User not accepted → PendingScreen");
        _goTo(PendingScreen.routeName);
        return;
      }

      // 🔹 Navigate by role
      if (role == 'contractor') {
        debugPrint("Role = contractor → ContractorMainLayout");
        _goTo(ContractorMainLayout.routeName);
      } else if (role == 'supplier') {
        debugPrint("Role = supplier → SupplierMainLayout");
        _goTo(SupplierMainLayout.routeName);
      } else {
        debugPrint("Unknown role → Login");
        await supabase.auth.signOut();
        _goTo(LoginScreen.routeName);
      }
    } catch (e) {
      debugPrint("Auth redirect error: $e");
      try {
        await supabase.auth.signOut();
      } catch (_) {
        debugPrint("Sign out failed (ignored)");
      }
      _goTo(LoginScreen.routeName);
    }
  }

  void _goTo(String routeName) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
