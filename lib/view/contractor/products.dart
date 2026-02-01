import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/product_details.dart';
import 'package:moona/widgets/custom_navBar.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    final List<Map<String, dynamic>> items = [
      {
        "image": "assets/images/cement.jpg",
        "company": "Tora",
        "location": "Cairo",
        "price": "4200 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "El Sues",
        "location": "Dakahlia",
        "price": "4500 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Portland",
        "location": "Sues",
        "price": "4000 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Tora",
        "location": "Cairo",
        "price": "3900 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Local",
        "location": "Aswan",
        "price": "3700 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Imported",
        "location": "Alexandria",
        "price": "4800 / ton",
      },
    ];

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        backgroundColor: themeController.isLight
            ? ColorsManager.green
            : ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.filter_list,
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.gold,
              size: 42,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Icon(
              Icons.shopping_cart,
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.gold,
              size: 42.sp,
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: BackButton(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Cement",
              style: TextStyle(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.grey,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.sp),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    height: 240.sp,
                    width: 160.sp,
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
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          child: Image.asset(
                            item["image"],
                            height: 100.sp,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.sp,
                            vertical: 18.sp,
                          ),
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
                                  SizedBox(width: 6.sp),
                                  Text(
                                    item["company"],
                                    style: TextStyle(
                                      color: themeController.isLight
                                          ? ColorsManager.green
                                          : ColorsManager.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.sp),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 6.sp),
                                  Text(
                                    item["location"],
                                    style: TextStyle(
                                      color: themeController.isLight
                                          ? ColorsManager.green
                                          : ColorsManager.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.sp),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.white,
                                    fontWeight: FontWeight.w500,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 6.sp),
                                  Text(
                                    item["price"],
                                    style: TextStyle(
                                      color: themeController.isLight
                                          ? ColorsManager.green
                                          : ColorsManager.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.sp),
                              Center(
                                child: SizedBox(
                                  width: 120.sp,
                                  height: 20.sp,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorsManager.gold,
                                      foregroundColor: ColorsManager.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetailsPage(
                                            image: item["image"],
                                            company: item["company"],
                                            location: item["location"],
                                            price: item["price"],
                                            stock: "400 ton",
                                            description:
                                                "klam klam klam klam kteeeer",
                                            delivery: true,
                                            sellOnCredit: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "More Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 0, onTab: (int p1) {}),
    );
  }
}
