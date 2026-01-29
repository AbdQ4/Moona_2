import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:provider/provider.dart';

import '../core/colors_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.title,required this.onTap});

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        backgroundColor:themeController.isLight
            ? ColorsManager.green
            : ColorsManager.gold,
        foregroundColor: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.green,
        fixedSize: Size(343.w, 48.h),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
