import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/controller/user_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LicencePage extends StatefulWidget {
  const LicencePage({super.key});

  static const String routeName = "/licence_page";

  @override
  State<LicencePage> createState() => _LicencePageState();
}

class _LicencePageState extends State<LicencePage> {
  late Future<dynamic> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    // Use listen: false because we only want to call the fetch once here.
    final userController = Provider.of<UserController>(context, listen: false);
    if (userController.user == null) {
      _loadUserFuture = userController.fetchUserDetails();
    } else {
      // already loaded
      _loadUserFuture = Future.value(userController.user);
    }
  }

  AppBar _buildAppBar(ThemeController themeController) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.green,
        ),
      ),
      backgroundColor: ColorsManager.green,
      title: Text(
        "Your License",
        style: GoogleFonts.inter(
          color: ColorsManager.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final userController = Provider.of<UserController>(
      context,
    ); // listen: true so UI updates when user is set
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

    return FutureBuilder<dynamic>(
      future: _loadUserFuture,
      builder: (context, snapshot) {
        // While fetching
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: _buildAppBar(themeController),
            backgroundColor: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // If fetch threw an error
        if (snapshot.hasError) {
          return Scaffold(
            appBar: _buildAppBar(themeController),
            backgroundColor: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
            body: Center(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "Failed to load user data.\n${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: themeController.isLight
                        ? ColorsManager.black
                        : ColorsManager.white,
                  ),
                ),
              ),
            ),
          );
        }

        // At this point either userController.user is set (fetchUserDetails set it)
        final UserModel curentUser = userController.user ?? snapshot.data;

        // If there's still no user object
        if (curentUser == null) {
          return Scaffold(
            appBar: _buildAppBar(themeController),
            backgroundColor: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 24.h,
                  ),
                  child: Text(
                    "No user profile found. Please log in again or contact support.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: themeController.isLight
                          ? ColorsManager.black
                          : ColorsManager.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Build main UI with the loaded user
        final licenseUrl = (curentUser.licenseUrl as String?)?.trim();
        final hasLicense = licenseUrl != null && licenseUrl.isNotEmpty;
        final renewDate = curentUser.renewDate;

        return Scaffold(
          appBar: _buildAppBar(themeController),
          backgroundColor: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.green,
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Your Renewal Date is : ${renewDate?.toLocal().toString().split(' ')[0] ?? "date"}",
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    color: themeController.isLight
                        ? ColorsManager.grey
                        : ColorsManager.white,
                    thickness: 1,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Your License is : Active",
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (!hasLicense)
                    Padding(
                      padding: REdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 16.w,
                      ),
                      child: Text(
                        "You don't have a license yet, please contact support to get one.",
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.black
                              : ColorsManager.white,
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    SizedBox(
                      height: 400.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: SfPdfViewer.network(
                          licenseUrl,
                          key: _pdfViewerKey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
