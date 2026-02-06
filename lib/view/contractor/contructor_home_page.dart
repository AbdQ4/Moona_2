import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/contractor_category_page.dart';
import 'package:moona/view/contractor/your_cart_page.dart';
import 'package:provider/provider.dart';

class ContructorHomePage extends StatefulWidget {
  const ContructorHomePage({super.key});

  @override
  State<ContructorHomePage> createState() => _ContructorHomePageState();
}

class _ContructorHomePageState extends State<ContructorHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    final List<Map<String, String>> categories = [
      {"title": "Building Materials", "image": "assets/images/1.jpg"},
      {"title": "Electrical & Lighting", "image": "assets/images/2.jpg"},
      {"title": "Finishing Materials", "image": "assets/images/3.jpg"},
      {"title": "Plumbing", "image": "assets/images/4.jpg"},
      {"title": "Construction Tools", "image": "assets/images/5.jpg"},
    ];

    final Map<String, List<Map<String, String>>> categoryItems = {
      "Building Materials": [
        {"name": "Bricks", "image": "assets/images/brick.jpg"},
        {"name": "Cement", "image": "assets/images/cement.jpg"},
        {"name": "Sand", "image": "assets/images/sand.jpg"},
        {"name": "Steel", "image": "assets/images/steel.jpg"},
      ],
      "Electrical & Lighting": [
        {"name": "Wires", "image": "assets/images/wires.jpg"},
        {"name": "Switches", "image": "assets/images/switches.jpg"},
        {"name": "Bulbs", "image": "assets/images/bulbs.jpg"},
        {"name": "Panels", "image": "assets/images/panels.jpg"},
      ],
      "Finishing Materials": [
        {"name": "Paint", "image": "assets/images/paint.png"},
        {"name": "Tiles", "image": "assets/images/tiles.png"},
        {"name": "Wallpaper", "image": "assets/images/wallpaper.png"},
      ],
      "Plumbing": [
        {"name": "Pipes", "image": "assets/images/pipes.png"},
        {"name": "Taps", "image": "assets/images/tap.png"},
        {"name": "Valves", "image": "assets/images/valve.png"},
      ],
      "Construction Tools": [
        {"name": "Hammer", "image": "assets/images/hammer.png"},
        {"name": "Drill", "image": "assets/images/drill.png"},
        {"name": "Saw", "image": "assets/images/saw.png"},
      ],
    };

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        toolbarHeight: 65.sp,
        backgroundColor: themeController.isLight
            ? ColorsManager.green
            : ColorsManager.green,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
          child: Icon(
            Icons.language,
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            size: 42.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, YourCartPage.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: themeController.isLight
                    ? ColorsManager.white
                    : ColorsManager.gold,
                size: 42.sp,
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 42.sp, horizontal: 12.sp),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25.sp,
            crossAxisSpacing: 20.sp,
          ),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            final title = category["title"]!;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContractorCategoryPage(categoryName: title),
                  ),
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
                        category["image"]!,
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
                            category["title"]!,
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
