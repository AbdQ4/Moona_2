import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:moona/controller/cart_provider.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPayment = 0; // 0 = card , 1 = cash

  final double taxRate = 0.05;
  final double shippingFees = 255;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final theme = Provider.of<ThemeController>(context);

    final double tax = cart.subTotal * taxRate;
    final double total = cart.subTotal + tax + shippingFees;

    final bgColor = theme.isLight ? ColorsManager.white : ColorsManager.green;
    final mainTextColor = theme.isLight
        ? ColorsManager.green
        : ColorsManager.white;
    final accentColor = ColorsManager.gold;

    return Scaffold(
      backgroundColor: bgColor,

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: theme.isLight
            ? ColorsManager.green
            : ColorsManager.green,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            color: accentColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      /// ================= Body =================
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= Summary =================
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.isLight
                    ? ColorsManager.white
                    : ColorsManager.green,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.isLight
                      ? ColorsManager.green
                      : ColorsManager.gold,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _summaryRow(
                    title: "Items",
                    value: "Cement x${cart.totalItems}",
                    color: mainTextColor,
                  ),
                  _summaryRow(
                    title: "Tax",
                    value: "${tax.toStringAsFixed(0)} \$",
                    color: mainTextColor,
                  ),
                  _summaryRow(
                    title: "Shipping",
                    value: "${shippingFees.toStringAsFixed(0)} \$",
                    color: mainTextColor,
                  ),
                  Divider(color: accentColor),
                  _summaryRow(
                    title: "Total",
                    value: "${total.toStringAsFixed(0)} \$",
                    color: mainTextColor,
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            /// ================= Location =================
            Row(
              children: [
                Text(
                  "Tap to add location :",
                  style: TextStyle(color: mainTextColor, fontSize: 16),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: theme.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            /// ================= Payment =================
            Row(
              children: [
                _paymentOption(title: "Pay with card", value: 0, theme: theme),
                SizedBox(width: 20.w),
                _paymentOption(title: "Pay with cash", value: 1, theme: theme),
              ],
            ),

            SizedBox(height: 20.h),

            /// ================= Card Button =================
            if (selectedPayment == 0)
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: ColorsManager.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.credit_card),
                  label: Text(
                    "Enter your card details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

            const Spacer(),

            /// ================= Proceed =================
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: ColorsManager.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Place order
                },
                child: const Text(
                  "Proceed",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= Components =================

  Widget _summaryRow({
    required String title,
    required String value,
    required Color color,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title :",
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption({
    required String title,
    required int value,
    required ThemeController theme,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Row(
        children: [
          Icon(
            selectedPayment == value
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: ColorsManager.gold,
          ),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: theme.isLight ? ColorsManager.green : ColorsManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
