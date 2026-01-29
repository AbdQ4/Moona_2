import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_role_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/auth/email_verification_screen.dart';
import 'package:moona/view/auth/pending_screen.dart';
import 'package:moona/view/auth/update_password.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../view/auth/login_screen.dart';
import '../view/contractor/contractor_main_layout.dart';
import '../view/supplier/supplier_main_layout.dart';
import 'license_controller.dart';

class UserController extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey;

  UserModel? user;
  final supabase = Supabase.instance.client;

  static const _userCacheKey = 'cached_user';

  File? pickedProfileImage;
  String? profileImageUrl;

  final ImagePicker _picker = ImagePicker();

  UserController(this.navigatorKey) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.passwordRecovery) {
        // Navigate when recovery is triggered
        navigatorKey.currentState?.pushNamed(UpdatePassword.routeName);
      }

      if (event == AuthChangeEvent.signedIn && session != null) {
        debugPrint("Signed in as: ${session.user.email}");
      }
    });
  }

  Future<void> _saveUserToCache(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(user.toMap());
      await prefs.setString(_userCacheKey, jsonString);
    } catch (e) {
      debugPrint("Error saving user to cache: $e");
    }
  }

  Future<UserModel?> loadUserFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userCacheKey);
      if (jsonString == null) return null;

      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      user = UserModel.fromMap(map);
      notifyListeners();
      return user;
    } catch (e) {
      debugPrint("Error loading user from cache: $e");
      return null;
    }
  }

  Future<void> clearUserCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userCacheKey);
    } catch (e) {
      debugPrint("Error clearing user cache: $e");
    }
  }

  /// =======================
  /// SIGN UP
  /// =======================

  Future<AuthResponse?> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNo,
    required String tax,
    required UserRole role,
  }) async {
    try {
      // Step 1: Sign up in auth
      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user == null) {
        throw Exception(
          "Signup failed: User is null (maybe email already exists).",
        );
      }

      if (response.user != null) {
        final licenseController = Provider.of<LicenseController>(
          context,
          listen: false,
        );
        final userRoleController = Provider.of<UserRoleController>(
          context,
          listen: false,
        );

        user = UserModel(
          id: response.user!.id,
          name: name,
          email: email,
          phoneNo: phoneNo,
          tax: tax,
          licenseUrl: licenseController.licenseUrl,
          password: password,
          role: userRoleController.selectedRole!.name,
          isAccepted: false,
          imageUrl: profileImageUrl ?? '',
        );

        // Step 2: Insert user profile into "users" table
        await supabase.from("users").insert({
          'id': response.user!.id, // link to auth.users
          'name': user!.name!.trim(),
          'email': user!.email!.trim(),
          'phone_no': user!.phoneNo!.trim(),
          'tax': user!.tax!.trim(),
          'license_url': user!.licenseUrl ?? '',
          'role': user!.role!.trim(),
        });

        // Step 3: Success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up successful! Please check your email."),
          ),
        );

        // Step 4: Navigate based on role
        Navigator.pushReplacementNamed(
          context,
          EmailVerificationScreen.routeName,
        );
      }

      return response;
    } catch (e) {
      debugPrint("Error : $e");
      return null;
    }
  }

  /// =======================
  /// SIGN IN
  /// =======================

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Try to refresh (this should not fail for just-signed-in sessions but it's safe)
      try {
        await supabase.auth.refreshSession();
      } catch (_) {}

      // fetch user details
      await fetchUserDetails();

      if (user == null) {
        debugPrint("⚠️ User is null after fetch");
        return;
      }

      if (response.session != null) {
        debugPrint('Login successful: ${response.session!.user.email}');
        final userData = await supabase
            .from("users")
            .select("role")
            .eq("id", response.session!.user.id)
            .single();

        final role = userData?["role"] as String? ?? user!.role;

        if (role == "contractor") {
          Navigator.pushReplacementNamed(
            context,
            user!.isAccepted == true
                ? ContractorMainLayout.routeName
                : PendingScreen.routeName,
            arguments: user,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            user!.isAccepted == true
                ? SupplierMainLayout.routeName
                : PendingScreen.routeName,
            arguments: user,
          );
        }
      } else {
        debugPrint('Login failed: No session returned');
      }
    } catch (e) {
      debugPrint('Exception during sign-in: $e');
    }
  }

  /// =======================
  /// EMAIL VERIFICATION
  /// =======================

  Future<AuthResponse?> emailVerification({
    required BuildContext context,
    required String otpCode,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      // 2. Verify OTP
      final response = await supabase.auth.verifyOTP(
        type: OtpType.signup,
        token: otpCode,
        email: supabase.auth.currentUser?.email ?? "",
      );

      if (response.user != null) {
        // ✅ Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email verified successfully!")),
        );

        // Navigate (based on role, like in your UserController)
        final user = await supabase
            .from("users")
            .select("role, is_accepted")
            .eq("id", response.user!.id)
            .single();

        if (user["role"] == "contractor") {
          Navigator.pushReplacementNamed(
            context,
            user["is_accepted"] == true
                ? ContractorMainLayout.routeName
                : PendingScreen.routeName,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            user["is_accepted"] == true
                ? SupplierMainLayout.routeName
                : PendingScreen.routeName,
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Verification failed: $e")));
    }
    return null;
  }

  /// =======================
  /// RESET PASSWORD
  /// =======================

  Future<AuthResponse?> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: "moona://update_password",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reset link sent to your email")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    return null;
  }

  /// =======================
  /// UPDATE PASSWORD (after reset)
  /// =======================
  Future<void> updatePassword({
    required BuildContext context,
    required String newPassword,
  }) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  /// =======================
  /// Resend Verification Email
  /// =======================
  Future<void> resendEmail(BuildContext context, String email) async {
    try {
      await supabase.auth.resend(type: OtpType.signup, email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification email sent again")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error sending email: $e")));
    }
  }

  /// =======================
  /// Logout
  /// =======================
  Future<void> logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      user = null;
      await clearUserCache();
      notifyListeners();

      // 🔹 Go to login page after logout
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }

  /// =======================
  /// Get User Details
  /// =======================

  Future<UserModel?> fetchUserDetails() async {
    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) return null;

      final userData = await supabase
          .from("users")
          .select()
          .eq("id", currentUser.id)
          .single();

      user = UserModel.fromMap(userData);
      await _saveUserToCache(user!);
      notifyListeners();
      return user;
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      return null;
    }
  }

  /// =======================
  /// Change User Name
  /// =======================

  Future<void> updateUserName({
    required String newName,
    required ThemeController themeController,
  }) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase.from('users').update({'name': newName}).eq('id', userId);

      print("Name updated successfully!");
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text("Name updated successfully!"),
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
        ),
      );
      await fetchUserDetails();
    } catch (e) {
      print("Error updating name: $e");
    }
  }

  /// ===========================
  /// Change User Phone Number
  /// ===========================

  Future<void> updateUserPhone({
    required String newPhone,
    required ThemeController themeController,
  }) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('users')
          .update({'phone_no': newPhone})
          .eq('id', userId);

      print("Phone number updated successfully!");
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text("Phone number updated successfully!"),
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
        ),
      );
      await fetchUserDetails();
    } catch (e) {
      print("Error updating phone number: $e");
    }
  }

  /// ===========================
  /// Profile Image Handling
  /// ===========================

  /// Pick image from gallery
  Future<void> pickProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        pickedProfileImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  /// Upload picked profile image to Supabase Storage
  Future<void> uploadProfileImage() async {
    if (pickedProfileImage == null || user == null) return;

    try {
      final String path = 'profile-pictures/${user!.id}.png';

      // ✅ Upload File to Supabase bucket
      await supabase.storage
          .from('users_profile_image')
          .upload(
            path,
            pickedProfileImage!,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true, // overwrite existing file if exists
            ),
          );

      // ✅ Get the public URL
      final String url = supabase.storage
          .from('users_profile_image')
          .getPublicUrl(path);

      profileImageUrl = url;

      // ✅ Update user table in Supabase
      await supabase
          .from('users')
          .update({'image_url': url})
          .eq('id', user!.id!);

      // ✅ Update local user model & cache
      user!.imageUrl = url;
      await _saveUserToCache(user!);

      // ✅ Refresh UI
      notifyListeners();

      debugPrint("Profile image uploaded successfully: $url");
    } catch (e) {
      debugPrint("Error uploading profile image: $e");
    }
  }

  /// Load cached profile image on app start
  Future<void> loadProfileFromCache() async {
    final cachedUser = await loadUserFromCache();
    if (cachedUser != null) {
      profileImageUrl = cachedUser.imageUrl;
      notifyListeners();
    }
  }

  /// ===========================
  /// Get Password Token
  /// =========================

  Future<void> requestResetToken({
    required String email,
    required ThemeController themeController,
    required BuildContext context,
  }) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      debugPrint("Error requesting reset token: $e");
    }
  }
}
