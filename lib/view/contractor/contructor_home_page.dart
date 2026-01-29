import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/contractor_category_page.dart';

class ContructorHomePage extends StatefulWidget {
  const ContructorHomePage({super.key});

  @override
  State<ContructorHomePage> createState() => _ContructorHomePageState();
}

class _ContructorHomePageState extends State<ContructorHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

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
      backgroundColor: ColorsManager.green,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Icon(Icons.language, color: ColorsManager.gold, size: 42),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Icon(
              Icons.shopping_cart,
              color: ColorsManager.gold,
              size: 42,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 12),
        child: SizedBox(
          height: height * 0.7,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: height * 0.04,
              crossAxisSpacing: width * 0.08,
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
                      builder: (_) => ContractorCategoryPage(
                        categoryName: title,
                        items: categoryItems[title] ?? [],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorsManager.gold, width: 2),
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
                                color: ColorsManager.gold,
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
      ),
    );
  }
}
