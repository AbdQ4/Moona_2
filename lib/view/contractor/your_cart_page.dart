import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/checkout_page.dart';

class YourCartPage extends StatelessWidget {
  const YourCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final theme = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor:
          theme.isLight ? ColorsManager.white : ColorsManager.green,

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            size: 36,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: theme.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      /// ================= Body =================
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// ================= Grid =================
            Expanded(
              child: cart.items.isEmpty
                  ? const Center(
                      child: Text(
                        "Cart is empty",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : GridView.builder(
                      itemCount: cart.items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: theme.isLight
                                ? ColorsManager.white
                                : ColorsManager.green,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 2,
                              color: theme.isLight
                                  ? ColorsManager.green
                                  : ColorsManager.grey,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Image
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    /// Quantity
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorsManager.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              _iconButton(
                                                '-',
                                                () => cart.decreaseQuantity(
                                                  item.id,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Text(
                                                  item.quantity.toString(),
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color:
                                                        ColorsManager.green,
                                                  ),
                                                ),
                                              ),
                                              _iconButton(
                                                '+',
                                                () => cart.increaseQuantity(
                                                  item.id,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// Max
                                        GestureDetector(
                                          onTap: () => cart.setMaxQuantity(
                                            item.id,
                                          ),
                                          child: Container(
                                            height: 36.h,
                                            width: 46.w,
                                            decoration: BoxDecoration(
                                              color: ColorsManager.gold,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Max',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorsManager.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10.h),

                                    /// Price
                                    Text(
                                      "\$ ${item.totalPrice.toStringAsFixed(0)} / ton",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: theme.isLight
                                            ? ColorsManager.green
                                            : ColorsManager.white,
                                      ),
                                    ),

                                    SizedBox(height: 70.h),

                                    /// Buy + Remove
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 34.h,
                                          width: 120.w,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorsManager.gold,
                                              foregroundColor:
                                                  ColorsManager.green,
                                              shape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                        GestureDetector(
                                          onTap: () =>
                                              cart.removeItem(item.id),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                        ),
                                      ],
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

            /// ================= Proceed =================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.isLight
                      ? ColorsManager.green
                      : ColorsManager.gold,
                  foregroundColor: theme.isLight
                      ? ColorsManager.white
                      : ColorsManager.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: cart.items.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutPage(),
                          ),
                        );
                      },
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= Icon Button =================
Widget _iconButton(String text, VoidCallback onTap) {
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
