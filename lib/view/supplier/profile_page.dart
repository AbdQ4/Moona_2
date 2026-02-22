import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/lang_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/view/supplier/finance_page.dart';
import 'package:moona/view/supplier/licence_page.dart';
import 'package:moona/widgets/custom_drop_down_menu.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController newName = TextEditingController();
  TextEditingController newPhone = TextEditingController();

  @override
  void initState() {
    // Loading user details from cashe first then from database
    super.initState();
    final userController = Provider.of<UserController>(context, listen: false);
    userController.loadUserFromCache().then(
      (_) => userController.fetchUserDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final userController = Provider.of<UserController>(context);
    final langController = Provider.of<LangController>(context);
    final user = userController.user;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themeController.isLight
          ? ColorsManager.green
          : ColorsManager.gold,

      /// Menu section
      endDrawer: Drawer(
        backgroundColor: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.green,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    child: ClipOval(
                      child: user != null && user.imageUrl.isNotEmpty
                          ? Image.network(
                              user.imageUrl,
                              fit: BoxFit.cover,
                              width: 80.w,
                              height: 80.h,
                            )
                          : Icon(
                              Icons.person,
                              size: 60.sp,
                              color: themeController.isLight
                                  ? ColorsManager.white
                                  : ColorsManager.green,
                            ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      user?.name ?? S.of(context).error,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).changeName,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      child: Padding(
                        padding: REdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).changeName,
                                  style: GoogleFonts.inter(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: newName,
                              style: GoogleFonts.inter(
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.white,
                              ),
                              decoration: InputDecoration(
                                labelText: S.of(context).enterNewName,
                                labelStyle: GoogleFonts.inter(
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                              ),
                            ),
                            CustomElevatedButton(
                              title: S.of(context).save,
                              onTap: () {
                                userController.updateUserName(
                                  newName: newName.text,
                                  themeController: themeController,
                                );
                                newName.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).changePhoneNo,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      child: Padding(
                        padding: REdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).changePhoneNo,
                                  style: GoogleFonts.inter(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: newPhone,
                              style: GoogleFonts.inter(
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.white,
                              ),
                              decoration: InputDecoration(
                                labelText: S.of(context).enterNewPhoneNo,
                                labelStyle: GoogleFonts.inter(
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                  ),
                                ),
                              ),
                            ),
                            CustomElevatedButton(
                              title: S.of(context).save,
                              onTap: () {
                                userController.updateUserPhone(
                                  newPhone: newPhone.text,
                                  themeController: themeController,
                                );
                                newPhone.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).salesHistory,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, FinancePage.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).reviewLisense,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, SupplierLicencePage.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.book,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).termsAndConditions,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).privacyPolicy,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.help,
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
              ),
              title: Text(
                S.of(context).helpAndSupport,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: REdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () async {
                    await userController.pickProfileImage();
                    await userController.uploadProfileImage();
                  },
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.green,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: userController.pickedProfileImage != null
                          ? Image.file(
                              File(userController.pickedProfileImage!.path),
                              fit: BoxFit.cover,
                            )
                          : (user != null && user.imageUrl.isNotEmpty)
                          ? Image.network(user.imageUrl, fit: BoxFit.cover)
                          : Icon(
                              Icons.person,
                              size: 60.sp,
                              color: ColorsManager.white,
                            ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    user?.name ?? S.of(context).error,
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 30.sp,
                    color: themeController.isLight
                        ? ColorsManager.white
                        : ColorsManager.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: themeController.isLight
                    ? ColorsManager.white
                    : ColorsManager.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${S.of(context).accountDetails} : ",
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            height: 400.h,
                            padding: REdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: themeController.isLight
                                  ? ColorsManager.white
                                  : ColorsManager.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.r),
                                topRight: Radius.circular(24.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).accountDetails,
                                      style: GoogleFonts.inter(
                                        color: themeController.isLight
                                            ? ColorsManager.green
                                            : ColorsManager.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: themeController.isLight
                                            ? ColorsManager.green
                                            : ColorsManager.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.person,
                                  data: user?.name ?? S.of(context).error,
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.email,
                                  data: user?.email ?? S.of(context).error,
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.phone,
                                  data: user?.phoneNo ?? S.of(context).error,
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.credit_card,
                                  data: user?.tax ?? S.of(context).error,
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.badge,
                                  data: user?.role ?? S.of(context).error,
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 160.h,
                      padding: REdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.gold,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _cardBuilder(
                            icon: Icons.email,
                            data: user?.email ?? S.of(context).error,
                            themeController: themeController,
                            lightColor: ColorsManager.white,
                            darkColor: ColorsManager.green,
                            fontSize: 16,
                          ),
                          _cardBuilder(
                            icon: Icons.phone,
                            data: user?.phoneNo ?? S.of(context).error,
                            themeController: themeController,
                            lightColor: ColorsManager.white,
                            darkColor: ColorsManager.green,
                            fontSize: 16,
                          ),
                          _cardBuilder(
                            icon: Icons.credit_card,
                            data: user?.tax ?? S.of(context).error,
                            themeController: themeController,
                            lightColor: ColorsManager.white,
                            darkColor: ColorsManager.green,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomDropDownMenu(
                    title: S.of(context).selectTheme,
                    value1: S.of(context).light,
                    label1: S.of(context).lightTheme,
                    value2: S.of(context).dark,
                    label2: S.of(context).darkTheme,
                    initialValue: themeController.isLight
                        ? S.of(context).light
                        : S.of(context).dark,
                    onSelected: (value) {
                      if (value == S.of(context).light) {
                        themeController.switchToLight();
                      } else {
                        themeController.switchToDark();
                      }
                    },
                  ),
                  SizedBox(height: 40.h),
                  CustomDropDownMenu(
                    title: S.of(context).selectLanguage,
                    value1: "en",
                    label1: "English",
                    value2: "ar",
                    label2: "العربية",
                    onSelected: (value) {
                      langController.changeLanguage(value);
                    },
                    initialValue: "en",
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.red,
                      foregroundColor: ColorsManager.white,
                      fixedSize: Size(380.w, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16.r),
                      ),
                    ),
                    onPressed: () {
                      userController.logout(context);
                    },
                    child: Text(
                      S.of(context).logout,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardBuilder({
    required IconData icon,
    required String data,
    required ThemeController themeController,
    required Color lightColor,
    required Color darkColor,
    required int fontSize,
  }) {
    return Row(
      children: [
        Icon(icon, color: themeController.isLight ? lightColor : darkColor),
        SizedBox(width: 10.w),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              data,
              style: GoogleFonts.inter(
                color: themeController.isLight ? lightColor : darkColor,
                fontSize: fontSize.sp,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
