import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/core/assets_manager.dart';

import '../core/colors_manager.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({super.key, required this.label, this.validator, this.controller});

  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        style: GoogleFonts.inter(color: ColorsManager.green),
        obscureText: _obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorsManager.white,
          prefixIcon: ImageIcon(
            AssetImage(AssetsManager.passwordIcon),
            color: ColorsManager.green,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _obscure = !_obscure;
              setState(() {});
            },
            icon: _obscure
                ? Icon(Icons.visibility_off, color: ColorsManager.green)
                : Icon(Icons.visibility, color: ColorsManager.green),
          ),
          label: Text(widget.label),
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
