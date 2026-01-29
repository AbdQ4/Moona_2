import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle safeInter({double? fontSize, FontWeight? fontWeight, Color? color}) {
  try {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  } catch (e) {
    // fallback to default font
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }
}
