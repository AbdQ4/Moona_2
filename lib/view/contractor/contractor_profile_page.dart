import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/contractor_finance_page.dart';
import 'package:moona/widgets/custom_drop_down_menu.dart';
import 'package:moona/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class ContractorProfilePage extends StatefulWidget {
  const ContractorProfilePage({super.key});

  @override
  State<ContractorProfilePage> createState() => _ContractorProfilePageState();
}

class _ContractorProfilePageState extends State<ContractorProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController newName = TextEditingController();
  TextEditingController newPhone = TextEditingController();

  @override
  void initState() {
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
    final user = userController.user;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themeController.isLight
          ? ColorsManager.green
          : ColorsManager.gold,
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
                      user?.name ?? "Error",
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
                "Change Name",
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
                                  "Change Name",
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
                                labelText: "Enter New Name",
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
                              title: "Save",
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
                "Change Phone Number",
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
                                  "Change Phone Number",
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
                                labelText: "Enter New Phone Number",
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
                              title: "Save",
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
                "Sales History",
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, ContractorFinancePage.routeName);
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
                "Review License",
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, ContractorFinancePage.routeName);
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
                "Our Terms and Conditions",
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
                "Privacy Policy",
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
                "Help & Support",
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
                    user?.name ?? "Error",
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
                    "Account details : ",
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
                                      "Account Details",
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
                                  data: user?.name ?? "Error",
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.email,
                                  data: user?.email ?? "Error",
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.phone,
                                  data: user?.phoneNo ?? "Error",
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.credit_card,
                                  data: user?.tax ?? "Error",
                                  themeController: themeController,
                                  lightColor: ColorsManager.green,
                                  darkColor: ColorsManager.white,
                                  fontSize: 20,
                                ),
                                SizedBox(height: 20.h),
                                _cardBuilder(
                                  icon: Icons.badge,
                                  data: user?.role ?? "Error",
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
                            data: user?.email ?? "Error",
                            themeController: themeController,
                            lightColor: ColorsManager.white,
                            darkColor: ColorsManager.green,
                            fontSize: 16,
                          ),
                          _cardBuilder(
                            icon: Icons.phone,
                            data: user?.phoneNo ?? "Error",
                            themeController: themeController,
                            lightColor: ColorsManager.white,
                            darkColor: ColorsManager.green,
                            fontSize: 16,
                          ),
                          _cardBuilder(
                            icon: Icons.credit_card,
                            data: user?.tax ?? "Error",
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
                    title: "Select Theme",
                    value1: "light",
                    label1: "Light Theme",
                    value2: "dark",
                    label2: "Dark Theme",
                    initialValue: themeController.isLight ? "light" : "dark",
                    onSelected: (value) {
                      if (value == "light") {
                        themeController.switchToLight();
                      } else {
                        themeController.switchToDark();
                      }
                    },
                  ),
                  SizedBox(height: 40.h),
                  CustomDropDownMenu(
                    title: "Select Language",
                    value1: "en",
                    label1: "English",
                    value2: "ar",
                    label2: "العربية",
                    onSelected: (value) {},
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
                      "Logout",
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
