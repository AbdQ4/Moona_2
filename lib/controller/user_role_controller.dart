import 'package:flutter/material.dart';
import 'package:moona/model/user_model.dart';

class UserRoleController extends ChangeNotifier {
  UserRole? _selectedRole = UserRole.contractor;
  UserRole? get selectedRole => _selectedRole;

  void changeRole(UserRole? value) {
    if (value != null && value != _selectedRole) {
      _selectedRole = value;
      notifyListeners();
    }
  }
}
