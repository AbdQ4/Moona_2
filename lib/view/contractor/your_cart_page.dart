import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/model/cart_item_model.dart';
import 'package:provider/provider.dart';

import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/view/contractor/checkout_page.dart';

class YourCartPage extends StatelessWidget {
  const YourCartPage({super.key});

  static const routeName = "/your_cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final theme = Provider.of<ThemeController>(context);

    return Scaffold(
      backgroundColor: theme.isLight
          ? ColorsManager.white
          : ColorsManager.green,

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: theme.isLight ? ColorsManager.white : ColorsManager.gold,
        ),
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: theme.isLight ? ColorsManager.white : ColorsManager.gold,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      /// ================= Body =================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            StreamBuilder<List<CartItem>>(
              stream: context.read<CartProvider>().cartStream(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: theme.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Cart is empty",
                      style: GoogleFonts.inter(
                        color: theme.isLight
                            ? ColorsManager.green
                            : ColorsManager.gold,
                      ),
                    ),
                  );
                }

                final items = snapshot.data!;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Text(item.productId);
                  },
                );
              },
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
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.green,
        ),
      ),
    ),
  );
}
