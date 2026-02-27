import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:moona/widgets/home_products.dart';
import 'package:provider/provider.dart';

class SupplierHomePage extends StatefulWidget {
  const SupplierHomePage({super.key});

  static const String routeName = '/home_screen';

  @override
  State<SupplierHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<SupplierHomePage> {
  @override
  void initState() {
    /// This method uploads the products from the database
    super.initState();
    final provider = Provider.of<AdditemProvider>(context, listen: false);
    provider.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final addItemProvider = Provider.of<AdditemProvider>(context);
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,

        /// Logo section
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Moona X",
              style: GoogleFonts.inter(
                color: themeController.isLight
                    ? ColorsManager.white
                    : ColorsManager.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600.h,
          child: Center(
            child: addItemProvider.products.isEmpty
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 8, horizontal: 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).noItemsAdded,
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          S.of(context).addItems,
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : HomeProducts(),
          ),
        ),
      ),
    );
  }
}
