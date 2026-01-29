import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:provider/provider.dart';

import '../core/colors_manager.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({super.key,
    required this.controller
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return SizedBox(
      height: 300.h,
      width: 50.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 1,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              width: 2.w,
              color: themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.gold,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              width: 2.w,
              color: themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.gold,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              width: 2.w,
              color: themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.gold,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: ColorsManager.red, width: 2.w,),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
