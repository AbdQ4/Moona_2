import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,
    appBarTheme: AppBarTheme(backgroundColor: ColorsManager.white),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.green,
    appBarTheme: AppBarTheme(backgroundColor: ColorsManager.green),
  );
}
