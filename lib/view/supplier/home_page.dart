import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/theme_controller.dart';

import 'package:moona/core/colors_manager.dart';

import 'package:moona/widgets/custom_addItem.dart';
import 'package:moona/widgets/home_products.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AdditemProvider>(context, listen: false);
    provider.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final addItemProvider = Provider.of<AdditemProvider>(context);

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
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
      floatingActionButton: SizedBox(
        height: 60.h,
        width: 60.w,
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.gold,
          child: Icon(
            Icons.add,
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
            size: 48.sp,
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding: REdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomAdditem(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: addItemProvider.products.isEmpty
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 8, horizontal: 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'No Items Added',
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tap the button below to add an item.',
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
