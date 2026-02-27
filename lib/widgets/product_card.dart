import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/supplier/products_details_supplier.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  static const String routeName = '/productCard_page';
  const ProductCard({
    super.key,
    required this.imageAddress,
    required this.companyName,
    required this.location,
    required this.price,
    required this.itemsCount,
    required this.currentProduct,
  });

  final String imageAddress;
  final String companyName;
  final String location;
  final String price;
  final int itemsCount;
  final Map<String, dynamic> currentProduct;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Container(
      decoration: BoxDecoration(
        color: themeController.isLight
            ? ColorsManager.white
            : ColorsManager.green,
        border: Border.all(
          color: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.gold,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
            ),
            child: Image.asset(
              imageAddress,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.factory,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      companyName,
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      location,
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      price,
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                      foregroundColor: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ProductsDetailsSupplier.routeName,
                        arguments: currentProduct,
                      );
                    },
                    child: const Text(
                      "More Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
