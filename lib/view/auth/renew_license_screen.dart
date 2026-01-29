import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/widgets/custom_elevated_button.dart';

class RenewLicenseScreen extends StatelessWidget {
  const RenewLicenseScreen({super.key});

  static const String routeName = "/renew_license";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Renew License",
                  style: safeInter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 100.h),

              CustomElevatedButton(title: "Choose License", onTap: () {}),
              SizedBox(height: 40.h),
              CustomElevatedButton(title: "Done", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
