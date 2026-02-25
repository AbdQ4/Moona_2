import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/assets_manager.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/widgets/custom_image_pickers.dart';
import 'package:provider/provider.dart';

class ProductsDetailsSupplier extends StatefulWidget {
  const ProductsDetailsSupplier({super.key});

  static const String routeName = '/products_details_supplier';

  @override
  State<ProductsDetailsSupplier> createState() =>
      _ProductsDetailsSupplierState();
}

class _ProductsDetailsSupplierState extends State<ProductsDetailsSupplier> {
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

    final companyController = TextEditingController(text: product['company']);
    final priceController = TextEditingController(
      text: product['price_per_ton'].toString(),
    );
    final descriptionController = TextEditingController(
      text: product['description'],
    );
    final stockController = TextEditingController(
      text: product['stock'].toString(),
    );

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
        child: Consumer<AdditemProvider>(
          builder: (context, provider, child) {
            final updatedProduct = provider.products.firstWhere(
              (p) => p['id'] == product['id'],
              orElse: () => product, // fallback if not found
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    product['image_url'],
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),

                // Product Info
                Text(
                  "${updatedProduct['company']} - ${updatedProduct['name']}",
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
                      updatedProduct['location'] ?? "Unknown Location",
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
                          updatedProduct['price_per_ton']?.toString() ??
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
                          "${S.of(context).stock} :",
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
                          updatedProduct['stock']?.toString() ?? "0",
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
                  S.of(context).description,
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
                    updatedProduct['description'] ?? "No description available",
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
                          "${S.of(context).delivery} :",
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        Icon(
                          updatedProduct['is_delivery'] == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: updatedProduct['is_delivery'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${S.of(context).sellOnCredit} :",
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        Icon(
                          updatedProduct['is_credit'] == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: updatedProduct['is_credit'] == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isLight
                        ? ColorsManager.gold
                        : ColorsManager.grey,
                    foregroundColor: ColorsManager.green,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    bool delivery = product['is_delivery'] ?? false;
                    bool credit = product['is_credit'] ?? false;

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: themeController.isLight
                                ? ColorsManager.white
                                : ColorsManager.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                          ),

                          child: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Padding(
                                padding: REdgeInsets.all(16).copyWith(
                                  bottom: MediaQuery.of(
                                    context,
                                  ).viewInsets.bottom,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${S.of(context).editProduct} - ${product['company']}",
                                        style: TextStyle(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        S.of(context).chooseImage,
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      CustomImagePickers(),
                                      SizedBox(height: 10.h),
                                      TextFormField(
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                        ),
                                        controller: companyController,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.inter(
                                            color: themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.white,
                                          ),
                                          labelText: S.of(context).productName,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFormField(
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                        ),
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.inter(
                                            color: themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.white,
                                          ),
                                          labelText: S.of(context).pricePerTon,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFormField(
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                        ),
                                        controller: descriptionController,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.inter(
                                            color: themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.white,
                                          ),
                                          labelText: S.of(context).description,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.h),
                                      TextFormField(
                                        style: GoogleFonts.inter(
                                          color: themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.white,
                                        ),
                                        controller: stockController,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.inter(
                                            color: themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.white,
                                          ),
                                          labelText: S.of(context).stock,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            borderSide: BorderSide(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.gold,
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${S.of(context).delivery}?",
                                            style: TextStyle(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.white,
                                            ),
                                          ),
                                          Switch(
                                            value: delivery,
                                            activeThumbColor:
                                                themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.gold,
                                            onChanged: (val) {
                                              setState(() {
                                                delivery = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),

                                      // Credit Switch
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${S.of(context).sellOnCredit}?",
                                            style: TextStyle(
                                              color: themeController.isLight
                                                  ? ColorsManager.green
                                                  : ColorsManager.white,
                                            ),
                                          ),
                                          Switch(
                                            value: credit,
                                            activeThumbColor:
                                                themeController.isLight
                                                ? ColorsManager.green
                                                : ColorsManager.gold,
                                            onChanged: (val) {
                                              setState(() {
                                                credit = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 20.h),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              themeController.isLight
                                              ? ColorsManager.green
                                              : ColorsManager.gold,
                                          foregroundColor:
                                              themeController.isLight
                                              ? ColorsManager.white
                                              : ColorsManager.green,
                                          minimumSize: Size(
                                            double.infinity,
                                            48.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          final confirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              backgroundColor:
                                                  themeController.isLight
                                                  ? ColorsManager.white
                                                  : ColorsManager.green,
                                              title: Text(
                                                S.of(context).confirm,
                                                style: GoogleFonts.inter(
                                                  color: themeController.isLight
                                                      ? ColorsManager.green
                                                      : ColorsManager.white,
                                                ),
                                              ),
                                              content: Text(
                                                S
                                                    .of(context)
                                                    .updateConfirmation,
                                                style: GoogleFonts.inter(
                                                  color: themeController.isLight
                                                      ? ColorsManager.green
                                                      : ColorsManager.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(ctx, false),
                                                  child: Text(
                                                    S.of(context).no,
                                                    style: GoogleFonts.inter(
                                                      color:
                                                          themeController
                                                              .isLight
                                                          ? ColorsManager.green
                                                          : ColorsManager.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    provider.updateProduct(
                                                      productId: product['id'],
                                                      company: companyController
                                                          .text,
                                                      price: double.tryParse(
                                                        priceController.text,
                                                      ),
                                                      stock: double.tryParse(
                                                        stockController.text,
                                                      ),
                                                      description:
                                                          descriptionController
                                                              .text,
                                                      isDelivery: delivery,
                                                      isCredit: credit,
                                                    );
                                                    Navigator.pop(ctx, true);
                                                    setState(() {});
                                                  },
                                                  child: Text(
                                                    S.of(context).yes,
                                                    style: GoogleFonts.inter(
                                                      color: ColorsManager.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirmed == true) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  S.of(context).productUpdated,
                                                  style: GoogleFonts.inter(
                                                    color:
                                                        themeController.isLight
                                                        ? ColorsManager.white
                                                        : ColorsManager.green,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    themeController.isLight
                                                    ? ColorsManager.green
                                                    : ColorsManager.white,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  S.of(context).productDeleted,
                                                  style: GoogleFonts.inter(
                                                    color:
                                                        themeController.isLight
                                                        ? ColorsManager.white
                                                        : ColorsManager.green,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    themeController.isLight
                                                    ? ColorsManager.green
                                                    : ColorsManager.white,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          S.of(context).updateProduct,
                                          style: GoogleFonts.inter(
                                            color: themeController.isLight
                                                ? ColorsManager.white
                                                : ColorsManager.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 40.h),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    S.of(context).editProduct,
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.red,
                    foregroundColor: ColorsManager.white,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        title: Text(
                          S.of(context).confirm,
                          style: GoogleFonts.inter(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        content: Text(
                          S.of(context).deleteProductConfirmation,
                          style: GoogleFonts.inter(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(
                              S.of(context).no,
                              style: GoogleFonts.inter(
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(
                              S.of(context).yes,
                              style: GoogleFonts.inter(
                                color: ColorsManager.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirmed != true) return;

                    // call delete
                    final success = await provider.deleteProduct(product['id']);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).productDeleted,
                            style: GoogleFonts.inter(
                              color: themeController.isLight
                                  ? ColorsManager.white
                                  : ColorsManager.green,
                            ),
                          ),
                          backgroundColor: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).deleteFailed,
                            style: GoogleFonts.inter(
                              color: themeController.isLight
                                  ? ColorsManager.white
                                  : ColorsManager.green,
                            ),
                          ),
                          backgroundColor: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                      );
                    }
                    setState(() {});
                  },
                  child: Text(
                    S.of(context).deleteProduct,
                    style: GoogleFonts.inter(
                      color: ColorsManager.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
