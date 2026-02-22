import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/widgets/product_card_supplier.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final String categoryKey; // used for filtering
  final String categoryTitle; // used for UI

  const CategoryPage({
    super.key,
    required this.categoryKey,
    required this.categoryTitle,
  });

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
        title: Text(
          categoryTitle, // translated title
          style: GoogleFonts.inter(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.gold,
        ),
      ),
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: FutureBuilder(
          future: addItemProvider.getProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!;

            // Filter products based on the categoryKey
            final filtered = products.where((p) {
              return p['type'].toString().toLowerCase().trim() ==
                  categoryKey.toLowerCase();
            }).toList();

            if (filtered.isEmpty) {
              return Center(
                child: Text(
                  "${S.of(context).noItems} $categoryTitle",
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final product = filtered[index];

                final Map<String, String> productImages = {
                  "cement": AssetsManager.cement,
                  "steel": AssetsManager.steel,
                  "bricks": AssetsManager.bricks,
                  "sand": AssetsManager.sand,
                  "gravel": "assets/images/gravel.jpg",
                  "bulbs": AssetsManager.bulbs,
                  "paints": AssetsManager.paints,
                  "wires": AssetsManager.wires,
                };

                final imagePath =
                    productImages[product['name'].toLowerCase()] ??
                    AssetsManager.defaultImage;

                return ProductCardSupplier(
                  imageAddress: imagePath,
                  companyName: product['company'] ?? 'Unknown Company',
                  location: product['location'] ?? 'Unknown Location',
                  price: product['price_per_ton'] != null
                      ? '\$${product['price_per_ton']} per ton'
                      : 'Price not available',
                  itemsCount: product['stock'] ?? 0,
                  currentProduct: product,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
