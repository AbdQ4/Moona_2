import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/checkbox_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/license_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/controller/user_role_controller.dart';
import 'package:moona/controller/validation_methods.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/model/user_model.dart';
import 'package:moona/widgets/custom_text_form_field.dart';
import 'package:moona/widgets/password_text_field.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "/sign_up";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _taxController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _taxController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final userController = Provider.of<UserController>(context, listen: false);
    final userRoleController = Provider.of<UserRoleController>(
      context,
      listen: false,
    );

    await userController.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _companyController.text,
      phoneNo: _phoneController.text,
      tax: _taxController.text,
      role: userRoleController.selectedRole!,
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final userRoleController = Provider.of<UserRoleController>(context);
    final checkboxController = Provider.of<CheckboxController>(context);
    final licenseController = Provider.of<LicenseController>(context);
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    S.of(context).signUp,
                    style: safeInter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 9.h),
                CustomTextFormField(
                  label: S.of(context).companyName,
                  prefixIconPath: AssetsManager.companyIcon,
                  controller: _companyController,
                  validator: ValidationMethods.validateCompanyName,
                ),
                CustomTextFormField(
                  label: S.of(context).email,
                  prefixIconPath: AssetsManager.emailIcon,
                  controller: _emailController,
                  validator: ValidationMethods.validateEmail,
                ),
                CustomTextFormField(
                  label: S.of(context).phoneNo,
                  prefixIconPath: AssetsManager.phoneIcon,
                  controller: _phoneController,
                  // validator: ValidationMethods.validatePhone,
                ),
                CustomTextFormField(
                  label: S.of(context).tax,
                  prefixIconPath: AssetsManager.taxIcon,
                  controller: _taxController,
                  validator: ValidationMethods.validateTax,
                ),
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.white,
                      foregroundColor: ColorsManager.green,
                      fixedSize: Size(355.w, 55.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(color: ColorsManager.green),
                      ),
                    ),
                    onPressed: () {
                      licenseController.uploadLicense(context);
                    },
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage(AssetsManager.uploadIcon),
                          color: ColorsManager.green,
                          size: 24.sp,
                        ),
                        SizedBox(width: 14.w),
                        Text(
                          S.of(context).uploadPDFLicense,
                          style: safeInter(
                            color: ColorsManager.green,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PasswordTextField(
                  label: S.of(context).password,
                  controller: _passwordController,
                  validator: ValidationMethods.validatePassword,
                ),
                PasswordTextField(
                  label: S.of(context).rePassword,
                  controller: _confirmPasswordController,
                  validator: (value) =>
                      ValidationMethods.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                ),
                Row(
                  children: [
                    Radio<UserRole>(
                      value: UserRole.contractor,
                      groupValue: userRoleController.selectedRole,
                      onChanged: userRoleController.changeRole,
                      fillColor: themeController.isLight
                          ? WidgetStateProperty.all(ColorsManager.green)
                          : WidgetStateProperty.all(ColorsManager.white),
                    ),
                    Text(
                      S.of(context).contractor,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Radio<UserRole>(
                      value: UserRole.supplier,
                      groupValue: userRoleController.selectedRole,
                      onChanged: userRoleController.changeRole,
                      fillColor: themeController.isLight
                          ? WidgetStateProperty.all(ColorsManager.green)
                          : WidgetStateProperty.all(ColorsManager.white),
                    ),
                    Text(
                      S.of(context).supplier,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: checkboxController.isChecked,
                  onChanged: checkboxController.check,
                  activeColor: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  checkColor: themeController.isLight
                      ? ColorsManager.white
                      : ColorsManager.green,
                  side: BorderSide(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  title: Row(
                    children: [
                      Text(
                        S.of(context).accept,
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        S.of(context).terms,
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        S.of(context).and,
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        S.of(context).conditions,
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    backgroundColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    foregroundColor: themeController.isLight
                        ? ColorsManager.white
                        : ColorsManager.green,
                    fixedSize: Size(343.w, 48.h),
                  ),
                  onPressed: () {
                    if (checkboxController.isChecked == true) {
                      _signUp();
                    } else {
                      SnackBar(
                        backgroundColor: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        content: Text(
                          S.of(context).needToAcceptTerms,
                          style: GoogleFonts.inter(
                            color: themeController.isLight
                                ? ColorsManager.white
                                : ColorsManager.green,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    S.of(context).signUp,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
