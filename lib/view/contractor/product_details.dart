import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';

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
    return Scaffold(
      backgroundColor: ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsManager.gold,
            size: 42,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Cement - $company",
          style: const TextStyle(
            color: ColorsManager.gold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 16),

            // Product Info
            Text(
              "$company Cement",
              style: const TextStyle(
                color: ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 26,
                  color: ColorsManager.gold,
                ),
                SizedBox(width: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: ColorsManager.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      size: 26,
                      color: ColorsManager.gold,
                    ),
                    SizedBox(width: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        color: ColorsManager.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "In Stock :",
                      style: const TextStyle(
                        color: ColorsManager.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      stock,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Description
            const Text(
              "Description",
              style: TextStyle(
                color: ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 96,
              width: 350,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                description,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 24),

            // Delivery & Credit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Delivery ",
                      style: TextStyle(color: ColorsManager.white),
                    ),
                    Icon(
                      delivery ? Icons.check_circle : Icons.cancel,
                      color: delivery ? Colors.green : Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Sell on Credit ",
                      style: TextStyle(color: ColorsManager.white),
                    ),
                    Icon(
                      sellOnCredit ? Icons.check_circle : Icons.cancel,
                      color: sellOnCredit ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.grey,
                foregroundColor: ColorsManager.green,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text("Add to Cart"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.gold,
                foregroundColor: ColorsManager.green,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
