import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:provider/provider.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTab;

  const CustomNavbar({super.key, required this.currentIndex, required this.onTab});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return BottomNavigationBar(
      backgroundColor: themeController.isLight
          ? ColorsManager.green
          : ColorsManager.gold,
      currentIndex: currentIndex,
      selectedItemColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      selectedLabelStyle: GoogleFonts.inter(
        color: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.gold,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        color: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.gold,
        fontWeight: FontWeight.bold,
      ),
      unselectedItemColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      selectedIconTheme: IconThemeData(
        size: 30,
        color: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.green,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,

      onTap: onTab,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Sales'),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: 'License',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
