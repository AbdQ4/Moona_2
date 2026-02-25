import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
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
      {
        "title": S.of(context).buildingMaterials,
        "image": AssetsManager.buildingMaterials,
      },
      {
        "title": S.of(context).electricalAndLightning,
        "image": AssetsManager.electricalAndLightning,
      },
      {
        "title": S.of(context).finishingMaterilas,
        "image": AssetsManager.finishingMaterials,
      },
      {
        "title": S.of(context).plumbing,
        "image": AssetsManager.plumbingMaterials,
      },
      {
        "title": S.of(context).constructionTools,
        "image": AssetsManager.constructionMaterials,
      },
    ];

    final Map<String, List<Map<String, String>>> categoryItems = {
      S.of(context).buildingMaterials: [
        {"name": S.of(context).bricks},
        {"name": S.of(context).cement},
        {"name": S.of(context).sand},
        {"name": S.of(context).steel},
      ],
      S.of(context).electricalAndLightning: [
        {"name": S.of(context).wires},
        {"name": S.of(context).switches},
        {"name": S.of(context).bulbs},
        {"name": S.of(context).panels},
      ],
      S.of(context).finishingMaterilas: [
        {"name": S.of(context).paints},
        {"name": S.of(context).tiles},
        {"name": S.of(context).wallpaper},
      ],
      S.of(context).plumbing: [
        {"name": S.of(context).pipes},
        {"name": S.of(context).taps},
        {"name": S.of(context).valves},
      ],
      S.of(context).constructionTools: [
        {"name": S.of(context).hummer},
        {"name": S.of(context).drill},
        {"name": S.of(context).saw},
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
