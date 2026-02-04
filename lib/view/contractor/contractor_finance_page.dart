import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';

class ContractorFinancePage extends StatelessWidget {
  const ContractorFinancePage({super.key});

  static String routeName = "/contractor_finance_page";

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    final List<Map<String, dynamic>> orders = [
      {
        "image": "assets/images/cement.jpg",
        "title": "Cement",
        "qty": "x 40 tons",
        "from": "El Mansoura",
        "project": "Mohsen Karika",
        "price": "\$ 40,000",
        "paid": true,
      },
      {
        "image": "assets/images/brick.jpg",
        "title": "Bricks",
        "qty": "x 1200 tons",
        "from": "El Mansoura",
        "project": "Mohsen Karika",
        "price": "\$ 40,000",
        "paid": false,
      },
      {
        "image": "assets/images/cement.jpg",
        "title": "Cement",
        "qty": "x 40 tons",
        "from": "El Mansoura",
        "project": "Mohsen Karika",
        "price": "\$ 40,000",
        "paid": true,
      },
    ];

    return Scaffold(
      backgroundColor: themeController.isLight
          ? ColorsManager.white
          : ColorsManager.green,

      appBar: AppBar(
        backgroundColor: ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: themeController.isLight? ColorsManager.gold: ColorsManager.gold,),

        title: Text(
          "Dashboard",
          style: TextStyle(
            color: ColorsManager.gold,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= Stats =================
            Row(
              children: [
                _statBox(
                  themeController,
                  icon: Icons.attach_money,
                  title: "Total Spent",
                  value: "1,250,000 \$",
                ),
                SizedBox(width: 12.sp),
                _statBox(
                  themeController,
                  icon: Icons.shopping_bag,
                  title: " Total Orders",
                  value: "42",
                ),
              ],
            ),

            SizedBox(height: 18.sp),

            /// ================= Filters =================
            Row(
              children: [
                _filterChip(themeController, "Project"),
                SizedBox(width: 8.sp),
                _filterChip(themeController, "Date"),
                const Spacer(),
                _filterChip(
                  themeController,
                  "All Items",
                  icon: Icons.swap_vert,
                ),
              ],
            ),

            SizedBox(height: 16.sp),

            Text(
              "Feb 1, 2026",
              style: TextStyle(
                color: themeController.isLight
                    ? ColorsManager.green
                    : ColorsManager.grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12.sp),

            /// ================= Orders =================
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 14.sp),
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      borderRadius: BorderRadius.circular(16),
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
                                order["image"],
                                height: 50.sp,
                                width: 50.sp,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.sp),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order["title"],
                                    style: TextStyle(
                                      color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.gold,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    order["qty"],
                                    style: TextStyle(
                                      color: themeController.isLight
                                          ? ColorsManager.green
                                          : ColorsManager.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.sp,
                                vertical: 4.sp,
                              ),
                              decoration: BoxDecoration(
                                color: order["paid"]
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order["paid"] ? "Paid" : "Unpaid",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.sp),

                        Text(
                          "From: ${order["from"]}",
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          "Project: ${order["project"]}",
                          style: TextStyle(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                            fontSize: 12.sp,
                          ),
                        ),

                        SizedBox(height: 10.sp),
                       

                        Row(
                          children: [
                            Spacer(),
                            Text(
                              order["price"],
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

                         Divider(color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,),

                                SizedBox(height: 8.sp),

                        /// ---------- Actions ----------
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 18.sp,
                              color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                            ),
                            SizedBox(width: 6.sp),
                            Text(
                              "Show Invoice",
                              style: TextStyle(
                                color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.download,
                              size: 18.sp,
                              color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                            ),
                            SizedBox(width: 6.sp),
                            Text(
                              "Download PDF",
                              style: TextStyle(
                                color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
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
    );
  }

  /// ================= Widgets =================

  Widget _statBox(
    ThemeController themeController, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        height: 100.sp,
        width: 150.sp,
        
        decoration: BoxDecoration(
          color: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.green,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: themeController.isLight
                ? ColorsManager.green
                : ColorsManager.gold,
            width: 2,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.all(14.sp),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: themeController.isLight
                        ? ColorsManager.gold
                        : ColorsManager.gold,
                  ),
                  // SizedBox(height: 8.sp),
                  Text(
                    title,
                    style: TextStyle(
                      color: themeController.isLight
                          ? ColorsManager.gold
                          : ColorsManager.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 8.sp),
              Text(
                value,
                style: TextStyle(
                  color: themeController.isLight
                      ? ColorsManager.white
                      : ColorsManager.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterChip(
    ThemeController themeController,
    String title, {
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: ColorsManager.green,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: themeController.isLight
              ? ColorsManager.green
              : ColorsManager.gold,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: themeController.isLight
                  ? ColorsManager.white
                  : ColorsManager.gold,
              fontSize: 12.sp,
            ),
          ),
          if (icon != null) ...[
            SizedBox(width: 6.sp),
            Icon(
              icon,
              size: 16.sp,
              color: themeController.isLight
                  ? ColorsManager.green
                  : ColorsManager.gold,
            ),
          ],
        ],
      ),
    );
  }
}
