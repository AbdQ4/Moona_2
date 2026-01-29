import 'package:flutter/material.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/product_details.dart';
import 'package:moona/widgets/custom_navBar.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "image": "assets/images/cement.jpg",
        "company": "Tora",
        "location": "Cairo",
        "price": "4200 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "El Sues",
        "location": "Dakahlia",
        "price": "4500 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Portland",
        "location": "Sues",
        "price": "4000 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Tora",
        "location": "Cairo",
        "price": "3900 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Local",
        "location": "Aswan",
        "price": "3700 / ton",
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Imported",
        "location": "Alexandria",
        "price": "4800 / ton",
      },
    ];

    return Scaffold(
      backgroundColor: ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.filter_list, color: ColorsManager.gold, size: 42),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.shopping_cart,
              color: ColorsManager.gold,
              size: 42,
            ),
          ),
        ],
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(Icons.search, color: ColorsManager.gold, size: 42),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Cement",
              style: TextStyle(
                color: ColorsManager.grey,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.green,
                      border: Border.all(color: ColorsManager.gold, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          child: Image.asset(
                            item["image"],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.factory,
                                    color: ColorsManager.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item["company"],
                                    style: const TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: ColorsManager.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item["location"],
                                    style: const TextStyle(
                                      color: ColorsManager.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.attach_money,
                                    color: ColorsManager.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item["price"],
                                    style: const TextStyle(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.gold,
                                    foregroundColor: ColorsManager.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailsPage(
                                          image: item["image"],
                                          company: item["company"],
                                          location: item["location"],
                                          price: item["price"],
                                          stock: "400 ton",
                                          description:
                                              "klam klam klam klam kteeeer",
                                          delivery: true,
                                          sellOnCredit: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "More Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavbar(currentIndex: 0, onTab: (int p1) {}),
    );
  }
}
