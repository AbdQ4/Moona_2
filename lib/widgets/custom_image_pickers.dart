import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:provider/provider.dart';

class CustomImagePickers extends StatelessWidget {
  const CustomImagePickers({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final addItemProvider = Provider.of<AdditemProvider>(context);
    return Padding(
      padding: REdgeInsets.all(12),
      child: addItemProvider.image == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addItemProvider.pickImageFromGallery();
                  },
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.gold,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 30.sp,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addItemProvider.pickImageFromCamera();
                  },
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.gold,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 30.sp,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 100.h,
                      child: InkWell(
                        onTap: () {
                          addItemProvider.clearImage();
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.cancel,
                              color: ColorsManager.red,
                              size: 26.sp,
                            ),
                            Text(
                              S.of(context).clearImage,
                              style: GoogleFonts.inter(
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.gold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(addItemProvider.image!),
              ),
            ),
    );
  }
}
