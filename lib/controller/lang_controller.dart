import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangController extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  static const String _langKey = 'cached_lang';

  LangController() {
    _loadSavedLanguage();
  }

  /// Change language and save it
  Future<void> changeLanguage(String? langCode) async {
    if (langCode == null) return;

    _locale = Locale(langCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  /// Load saved language from cache
  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_langKey);

    if (savedLang != null) {
      _locale = Locale(savedLang);
      notifyListeners();
    }
  }
}
