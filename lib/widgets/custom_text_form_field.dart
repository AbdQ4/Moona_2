import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.prefixIconPath,
    this.validator,
    this.controller,
  });

  final String label;
  final String prefixIconPath;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        style: GoogleFonts.inter(color: ColorsManager.green),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorsManager.white,
          prefixIcon: ImageIcon(
            AssetImage(prefixIconPath),
            color: ColorsManager.green,
          ),
          label: Text(label),
          labelStyle: GoogleFonts.inter(color: ColorsManager.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: ColorsManager.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: ColorsManager.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: ColorsManager.green),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: ColorsManager.red),
          ),
        ),
      ),
    );
  }
}
