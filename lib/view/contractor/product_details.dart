import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:provider/provider.dart';

class ProductsDetailsContractor extends StatefulWidget {
  const ProductsDetailsContractor({super.key});

  static const String routeName = '/products_details_contractor';

  @override
  State<ProductsDetailsContractor> createState() =>
      _ProductsDetailsContractorState();
}

class _ProductsDetailsContractorState extends State<ProductsDetailsContractor> {
  @override
  void initState() {
    final productController = Provider.of<AdditemProvider>(
      context,
      listen: false,
    );
    productController.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: REdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.gold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${product['name']} - ${product['company']}",
          style: TextStyle(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.gold,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Consumer<CartProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    product['name'] == 'cement'
                        ? 'assets/images/cement.jpg'
                        : product['name'].toString().toLowerCase() == 'steel'
                        ? 'assets/images/steel.jpg'
                        : product['name'].toString().toLowerCase() == 'bricks'
                        ? 'assets/images/brick.jpg'
                        : product['name'].toString().toLowerCase() == 'sand'
                        ? 'assets/images/sand.jpg'
                        : product['name'].toString().toLowerCase() == 'gravel'
                        ? 'assets/images/gravel.jpg'
                        : product['name'].toString().toLowerCase() == 'bulbs'
                        ? 'assets/images/bulbs.jpg'
                        : product['name'].toString().toLowerCase() == 'paint'
                        ? 'assets/images/paints.jpg'
                        : product['name'].toString().toLowerCase() == 'wires'
                        ? 'assets/images/wires.jpg'
                        : 'assets/images/default.jpg',
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),

                // Product Info
                Text(
                  "${product['company']} - ${product['name']}",
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 26,
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      product['location'] ?? "Unknown Location",
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
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 26.sp,
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.gold,
                        ),
                        SizedBox(width: 4),
                        Text(
                          product['price_per_ton']?.toString() ??
                              "Price not available",
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
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
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          product['stock']?.toString() ?? "0",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Description
                Text(
                  "Description",
                  style: TextStyle(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 96.h,
                  width: 350.w,
                  padding: REdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    product['description'] ?? "No description available",
                    style: TextStyle(
                      color: themeController.isLight
                          ? ColorsManager.black
                          : ColorsManager.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

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
                          ),
                        ),
                        Icon(
                          product['is_delivery'] == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: product['is_delivery'] == true
                              ? Colors.green
                              : Colors.red,
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
                          ),
                        ),
                        Icon(
                          product['is_credit'] == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: product['is_credit'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 80.h),

                // Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isLight
                        ? ColorsManager.gold
                        : ColorsManager.gold,
                    foregroundColor: ColorsManager.green,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await provider.addToCartTable(
                      context: context,
                      productId: product['id'],
                      stock: product['stock'],
                      price: product['price_per_ton'].toDouble(),
                      type: product['name'],
                      name: product['company'],

                      image: product['name'] == 'cement'
                          ? 'assets/images/cement.jpg'
                          : product['name'].toString().toLowerCase() == 'steel'
                          ? 'assets/images/steel.jpg'
                          : product['name'].toString().toLowerCase() == 'bricks'
                          ? 'assets/images/brick.jpg'
                          : product['name'].toString().toLowerCase() == 'sand'
                          ? 'assets/images/sand.jpg'
                          : product['name'].toString().toLowerCase() == 'gravel'
                          ? 'assets/images/gravel.jpg'
                          : product['name'].toString().toLowerCase() == 'bulbs'
                          ? 'assets/images/bulbs.jpg'
                          : product['name'].toString().toLowerCase() == 'paint'
                          ? 'assets/images/paints.jpg'
                          : product['name'].toString().toLowerCase() == 'wires'
                          ? 'assets/images/wires.jpg'
                          : 'assets/images/default.jpg',
                    );
                  },
                  child: const Text("Add to Cart"),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.grey,
                    foregroundColor: ColorsManager.white,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () async {},
                  child: const Text("Buy Now"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void setStateSB(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
  }
}
