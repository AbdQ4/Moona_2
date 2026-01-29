import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool _isLight = true;
  bool get isLight => _isLight;

  ThemeController() {
    _loadTheme(); // Load saved theme on start
  }

  // Load theme from cache
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isLight = prefs.getBool('isLight') ?? true; // default = light
    notifyListeners();
  }

  // Save theme to cache
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLight', _isLight);
  }

  void switchThemes() {
    _isLight = !_isLight;
    _saveTheme();
    notifyListeners();
  }

  void switchToDark() {
    _isLight = false;
    _saveTheme();
    notifyListeners();
  }

  void switchToLight() {
    _isLight = true;
    _saveTheme();
    notifyListeners();
  }
}
