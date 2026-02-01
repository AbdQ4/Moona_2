import 'package:flutter/material.dart';

import 'package:moona/controller/user_controller.dart';

import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PasswordTextField(
              label: "New Password",
              controller: _passwordController,
            ),
            PasswordTextField(
              label: "Confirm Password",
              controller: _confirmController,
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              title: "Update Password",
              onTap: () async {
                if (_passwordController.text != _confirmController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match")),
                  );
                  return;
                }

                try {
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
          ],
        ),
      ),
    );
  }
}
