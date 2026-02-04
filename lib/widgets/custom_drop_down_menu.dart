import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:provider/provider.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.value1,
    required this.label1,
    required this.value2,
    required this.label2,
    required this.onSelected,
    required this.initialValue,
    required this.title,
  });

  final String value1;
  final String label1;
  final String value2;
  final String label2;
  final void Function(String?)? onSelected;
  final String initialValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return DropdownMenu(
      label: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          color: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.white,
        ),
      ),
      width: 360.w,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: value1,
          label: label1,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.white,
            ),
          ),
        ),
        DropdownMenuEntry(
          value: value2,
          label: label2,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.white,
            ),
          ),
        ),
      ],
      onSelected: onSelected,
      initialSelection: initialValue,
      textStyle: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: themeController.isLight
            ? ColorsManager.green
            : ColorsManager.white,
      ),
      
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          themeController.isLight ? ColorsManager.white : ColorsManager.green,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: themeController.isLight
            ? ColorsManager.green
            : ColorsManager.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: themeController.isLight
                ? ColorsManager.green
                : ColorsManager.white,
            width: 2.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: themeController.isLight
                ? ColorsManager.green
                : ColorsManager.white,
            width: 2.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: themeController.isLight
                ? ColorsManager.green
                : ColorsManager.white,
            width: 2.w,
          ),
        ),
      ),
    );
  }
}
