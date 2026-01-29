import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:provider/provider.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,required this.onTap, required this.title});

  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return TextButton(onPressed: onTap, child: Text(title, style: GoogleFonts.inter(
      color: themeController.isLight ? ColorsManager.green : ColorsManager.gold,
      decoration: TextDecoration.underline,
      fontSize: 14.sp,
    ),));
  }
}
