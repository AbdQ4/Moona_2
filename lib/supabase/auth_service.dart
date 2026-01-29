import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier{
  final SupabaseClient _supabase = Supabase.instance.client;

  // sign in with email and password
   Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }
  // sign up with email and password

   Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(password: password, email: email,);
  }

  // sign out

   Future<void> signOut() async {
    return await _supabase.auth.signOut();
  }

  // reset password
}
