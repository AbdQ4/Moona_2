import 'package:flutter/material.dart';

class LangController extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String? langCode) {
    _locale = Locale(langCode!);
    notifyListeners();
  }
}
