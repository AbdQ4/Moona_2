import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/widgets/product_card_supplier.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    final addItemProvider = Provider.of<AdditemProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        leading: BackButton(
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.gold,
        ),
        title: Text(
          categoryName,
          style: GoogleFonts.inter(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: FutureBuilder(
          future: addItemProvider.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No items yet in $categoryName",
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.black
                        : ColorsManager.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            final categoryProducts = snapshot.data!
                .where(
                  (p) =>
                      p['type'].toString().toLowerCase() ==
                      categoryName.toLowerCase(),
                )
                .toList();

            if (categoryProducts.isEmpty) {
              return Center(
                child: Text(
                  "No items yet in $categoryName",
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.black
                        : ColorsManager.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return GridView.builder(
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                final productName = categoryProducts[index]['name']
                    .toString()
                    .toLowerCase();
                final product = categoryProducts[index];
                return ProductCardSupplier(
                  imageAddress: productName == 'cement'
                      ? 'assets/images/cement.jpg'
                      : productName == 'steel'
                      ? 'assets/images/steel.jpg'
                      : productName == 'bricks'
                      ? 'assets/images/brick.jpg'
                      : productName == 'sand'
                      ? 'assets/images/sand.jpg'
                      : productName == 'gravel'
                      ? 'assets/images/gravel.jpg'
                      : productName == 'bulbs'
                      ? 'assets/images/bulbs.jpg'
                      : productName == 'paint'
                      ? 'assets/images/paints.jpg'
                      : productName == 'wires'
                      ? 'assets/images/wires.jpg'
                      : 'assets/images/default.jpg',
                  companyName: product['company'] ?? 'Unknown Company',
                  location: product['location'] ?? 'Unknown Location',
                  price: product['price_per_ton'] != null
                      ? '\$${product['price_per_ton']} per ton'
                      : 'Price not available',
                  itemsCount: product['stock'] ?? 0,
                  currentProduct: product,
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
            );
          },
        ),
      ),
    );
  }
}
