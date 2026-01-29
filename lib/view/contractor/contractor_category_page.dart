import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/products.dart';

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
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: ColorsManager.green,
      appBar: AppBar(
        title: Text(categoryName, style: TextStyle(color: ColorsManager.gold)),
        backgroundColor: ColorsManager.green,
        iconTheme: IconThemeData(color: ColorsManager.gold),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                "No items in $categoryName",
                style: TextStyle(color: ColorsManager.grey, fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 8),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: height * 0.04,
                  crossAxisSpacing: width * 0.08,
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
                        border: Border.all(color: ColorsManager.gold, width: 2),
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
                              height: 50,
                              color: ColorsManager.black.withOpacity(0.7),
                              child: Center(
                                child: Text(
                                  item["name"]!,
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
    );
  }
}
