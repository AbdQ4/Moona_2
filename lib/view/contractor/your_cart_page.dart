import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/checkout_page.dart';
import 'package:moona/view/contractor/product_details.dart';
import 'package:moona/widgets/custom_navBar.dart';
import 'package:provider/provider.dart';

class YourCartPage extends StatefulWidget {
  const YourCartPage({super.key});

  @override
  State<YourCartPage> createState() => _YourCartPageState();
}

class _YourCartPageState extends State<YourCartPage> {
  int quantity = 2;
  final int maxQuantity = 15;

  final TextEditingController quantityController = TextEditingController(
    text: '2',
  );

  void _updateQuantity(int newValue) {
    if (newValue < 1) newValue = 1;
    if (newValue > maxQuantity) newValue = maxQuantity;

    setState(() {
      quantity = newValue;
      quantityController.text = newValue.toString();
    });
  }

  double calculateTotal(double pricePerTon) {
    return pricePerTon * quantity;
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final themeController = Provider.of<ThemeController>(context);

    final List<Map<String, dynamic>> items = [
      {
        "image": "assets/images/cement.jpg",
        "company": "Tora",
        "location": "Cairo",
        "pricePerTon": 4200.0,
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "El Sues",
        "location": "Dakahlia",
        "pricePerTon": 4500.0,
      },
      {
        "image": "assets/images/cement.jpg",
        "company": "Portland",
        "location": "Sues",
        "pricePerTon": 4000.0,
      },
    ];

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
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
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Your Cart',
          style: TextStyle(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: cart.items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final item = cart.items[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.grey,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                          child: Image.asset(
                            item.image,
                            height: 100.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// -------- Quantity + Max + Remove --------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorsManager.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        _iconButton(
                                          text: '-',
                                          onTap: () =>
                                              cart.decreaseQuantity(item.id),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorsManager.green,
                                            ),
                                          ),
                                        ),
                                        _iconButton(
                                          text: '+',
                                          onTap: () =>
                                              cart.increaseQuantity(item.id),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 6),

                                  /// Max
                                  GestureDetector(
                                    onTap: () => cart.setMaxQuantity(item.id),
                                    child: Container(
                                      height: 36.h,
                                      width: 46.w,
                                      decoration: BoxDecoration(
                                        color: ColorsManager.gold,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Max',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorsManager.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.h),

                              /// -------- Price (calculated) --------
                              Text(
                                "\$ ${item.totalPrice.toStringAsFixed(0)} / ton",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.white,
                                ),
                              ),

                              SizedBox(height: 85.h),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 34.h,
                                    width: 130.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorsManager.gold,
                                        foregroundColor: ColorsManager.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        "Buy Now",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),

                                  /// 🗑 Remove
                                  GestureDetector(
                                    onTap: () => cart.removeItem(item.id),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),

                              /// -------- Buy Now --------
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutPage()),
                );
              },
              child: Text(
                "Proceed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _iconButton({required String text, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.green,
        ),
      ),
    ),
  );
}
