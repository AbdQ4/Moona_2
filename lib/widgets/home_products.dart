import 'package:flutter/material.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/supplier/category_page.dart';
import 'package:provider/provider.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({super.key});

  final List<Map<String, String>> categories = const [
    {"title": "Building Materials", "image": "assets/images/1.jpg"},
    {"title": "Electrical & Lighting", "image": "assets/images/2.jpg"},
    {"title": "Finishing Materials", "image": "assets/images/3.jpg"},
    {"title": "Plumbing", "image": "assets/images/4.jpg"},
    {"title": "Construction Tools", "image": "assets/images/5.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: height * 0.7,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: height * 0.04,
            crossAxisSpacing: width * 0.08,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryPage(categoryName: category["title"]!),
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
                    width: 2,
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
                        height: 50,
                        color: ColorsManager.black.withOpacity(0.7),
                        child: Center(
                          child: Text(
                            category["title"]!,
                            style: TextStyle(
                              color: themeController.isLight
                                  ? ColorsManager.white
                                  : ColorsManager.gold,
                              fontSize: 14,
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
