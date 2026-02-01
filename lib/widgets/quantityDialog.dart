import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:moona/core/colors_manager.dart';
import 'package:moona/controller/quantity_dialog_provider.dart';

class QuantityDialog extends StatelessWidget {
  const QuantityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<QuantityDialogProvider>();

    return Dialog(
      backgroundColor: ColorsManager.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: ColorsManager.white, width: 2.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(16..sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ================= Quantity =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title("Quantity / ton"),
                Row(
                  children: [
                    _qtyButton("-", p.decrease),
                    _qtyValue(p.quantity),
                    _qtyButton("+", p.increase),
                    SizedBox(width: 6.sp),
                    _maxButton(p.setMax),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.sp),

            /// ================= Delivery =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _radio(
                  title: "Pickup",
                  selected: p.method == DeliveryMethod.pickup,
                  onTap: () => p.setMethod(DeliveryMethod.pickup),
                ),
                _radio(
                  title: "Delivery +fees",
                  selected: p.method == DeliveryMethod.delivery,
                  onTap: () => p.setMethod(DeliveryMethod.delivery),
                ),
              ],
            ),

            SizedBox(height: 12.sp),

            /// ================= Disabled Credit =================
            Row(
              children: [
                Text(
                  "On credit",
                  style: TextStyle(
                    color: ColorsManager.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 6.sp),
                Icon(Icons.block, color: ColorsManager.grey, size: 18.sp),
              ],
            ),

            SizedBox(height: 16.sp),

            /// ================= Price =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title("Price"),
                Text(
                  "${p.totalPrice.toStringAsFixed(0)} \$",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.sp),

            /// ================= Button =================
            SizedBox(
              width: double.infinity,
              height: 48.sp,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.gold,
                  foregroundColor: ColorsManager.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    "quantity": p.quantity,
                    "delivery": p.method == DeliveryMethod.delivery,
                  });
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 22.sp,
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

  /// ================= Small Widgets =================
  Widget _title(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: ColorsManager.white,
    ),
  );

  Widget _qtyButton(String text, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.gold,
        ),
      ),
    ),
  );

  Widget _qtyValue(int value) => Container(
    width: 40.sp,
    alignment: Alignment.center,
    child: Text(
      value.toString(),
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.white,
      ),
    ),
  );

  Widget _maxButton(VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: ColorsManager.gold,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "Max",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorsManager.green,
        ),
      ),
    ),
  );

  Widget _radio({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 18.sp,
            height: 18.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorsManager.white, width: 2.sp),
            ),
            child: selected
                ? const Center(
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: ColorsManager.white,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 6.sp),
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: ColorsManager.white),
          ),
        ],
      ),
    );
  }
}
