import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/products.dart';
import 'package:provider/provider.dart';

class ContractorCategoryPage extends StatelessWidget {
  final String categoryName;
  final List<Map<String, String>> items;

  const ContractorCategoryPage({
    super.key,
    required this.categoryName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.gold,
        ),
        title: Text(
          categoryName,
          style: TextStyle(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
          ),
        ),
        backgroundColor: themeController.isLight
            ? ColorsManager.green
            : ColorsManager.green,
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                "No items in $categoryName",
                style: TextStyle(color: ColorsManager.grey, fontSize: 18.sp),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 42.sp, horizontal: 8.sp),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 25.sp,
                  crossAxisSpacing: 20.sp,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Products()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.gold,
                          width: 2.sp,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              item["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50.sp,
                              color: ColorsManager.black.withOpacity(0.7),
                              child: Center(
                                child: Text(
                                  item["name"]!,
                                  style: TextStyle(
                                    color: ColorsManager.gold,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
