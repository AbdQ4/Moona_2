import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/model/cart_item_model.dart';
import 'package:moona/view/contractor/product_details.dart';
import 'package:provider/provider.dart';

import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';

class YourCartPage extends StatelessWidget {
  YourCartPage({super.key});

  static const routeName = "/your_cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.gold,
        ),
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => cart.clearCart(context),
        backgroundColor: ColorsManager.red,
        child: Icon(Icons.delete, color: ColorsManager.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,

      /// ================= Body =================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<List<CartItem>>(
                stream: context.read<CartProvider>().cartStream(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Cart is empty",
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.gold,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  final items = snapshot.data!;

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductsDetailsContractor.routeName,
                                arguments: {
                                  'id': item.productId,
                                  'name': item.name,
                                  'type': item.type,
                                  'price_per_ton': item.price,
                                  'stock': item.stock,
                                  'image': item.image,
                                },
                              );
                            },
                            child: Container(
                              margin: REdgeInsets.only(bottom: 14),
                              padding: REdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: themeController.isLight
                                    ? ColorsManager.white
                                    : ColorsManager.green,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.gold,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// ---------- Header ----------
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          item.image,
                                          height: 80.sp,
                                          width: 80.sp,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 12.sp),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                color: themeController.isLight
                                                    ? ColorsManager.green
                                                    : ColorsManager.gold,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 12.sp),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Type: ${item.type}",
                                        style: TextStyle(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),

                                      Text(
                                        "\$${item.price * item.quantity}",
                                        style: TextStyle(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.sp),

                                  Divider(
                                    color: themeController.isLight
                                        ? ColorsManager.green
                                        : ColorsManager.gold,
                                  ),

                                  SizedBox(height: 8.sp),

                                  /// ---------- Actions ----------
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cartProvider.increaseQuantity(item);
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          size: 28.sp,
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                        ),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                          fontSize: 28.sp,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cartProvider.decreaseQuantity(item);
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          size: 28.sp,
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                        ),
                                      ),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorsManager.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          foregroundColor: ColorsManager.white,
                                        ),
                                        onPressed: () {
                                          cart.removeFromCartByProductId(
                                            productId: item.productId,
                                            context: context,
                                          );
                                        },
                                        child: Text("Remove"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          foregroundColor: ColorsManager.white,
                                        ),
                                        onPressed: () {
                                          cartProvider.setMaxQuantity(item);
                                        },
                                        child: Text("Max"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: themeController.isLight
                    ? ColorsManager.white
                    : ColorsManager.green,
                fixedSize: Size(280.w, 50.h),
              ),
              onPressed: () {},
              child: Text(
                "Checkout",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
