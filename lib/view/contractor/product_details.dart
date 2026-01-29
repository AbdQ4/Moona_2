import 'package:flutter/material.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/your_cart_page.dart';
import 'package:moona/widgets/quantityDialog.dart';

import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final String image;
  final String company;
  final String location;
  final String price;
  final String stock;
  final String description;
  final bool delivery;
  final bool sellOnCredit;

  const ProductDetailsPage({
    super.key,
    required this.image,
    required this.company,
    required this.location,
    required this.price,
    required this.stock,
    required this.description,
    this.delivery = true,
    this.sellOnCredit = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            size: 42,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Cement - $company",
          style: TextStyle(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Icon(
              Icons.shopping_cart,
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.gold,
              size: 42,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Product Info
            Text(
              "$company Cement",
              style: TextStyle(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 26,
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                ),
                SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 26,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                    ),
                    SizedBox(width: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "In Stock :",
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      stock,
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            // Description
            Text(
              "Description",
              style: TextStyle(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 96,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                description,
                style: TextStyle(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Delivery & Credit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Delivery ",
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      delivery ? Icons.check_circle : Icons.cancel,
                      color: delivery ? Colors.green : Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Sell on Credit ",
                      style: TextStyle(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      sellOnCredit ? Icons.check_circle : Icons.cancel,
                      color: sellOnCredit ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 130),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeController.isLight
                    ? ColorsManager.gold
                    : ColorsManager.grey,
                foregroundColor: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.green,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const QuantityDialog(),
                );
              },
              child: Text(
                "Add to Cart",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.gold,
                foregroundColor: themeController.isLight
                    ? ColorsManager.white
                    : ColorsManager.green,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YourCartPage()),
                );
              },
              child: Text(
                "Buy Now",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
