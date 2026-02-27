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

class CategoryPage extends StatefulWidget {
  final String categoryKey; // used for filtering
  final String categoryTitle; // used for UI

  const CategoryPage({
    super.key,
    required this.categoryKey,
    required this.categoryTitle,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final addItemProvider = Provider.of<AdditemProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        title: Text(
          widget.categoryTitle,
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
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: addItemProvider.streamProducts(widget.categoryKey),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final filtered = snapshot.data!;

            if (filtered.isEmpty) {
              return Center(
                child: Text("${S.of(context).noItems} ${widget.categoryTitle}"),
              );
            }

            return GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.61,
              ),
              itemBuilder: (context, index) {
                final product = filtered[index];
                final imageUrl = product['image_url'] ?? '';

                return ProductCardSupplier(
                  imageAddress: imageUrl.isNotEmpty
                      ? imageUrl
                      : AssetsManager.defaultImage,

                  companyName: product['company'] ?? 'Unknown Company',
                  location: product['location'] ?? 'Unknown Location',
                  price: '\$${product['price_per_ton']} per ton',
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
