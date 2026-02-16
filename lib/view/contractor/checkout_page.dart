// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:moona/controller/chekout_controller.dart';
// import 'package:provider/provider.dart';

// import 'package:moona/controller/cart_provider.dart';
// import 'package:moona/controller/theme_controller.dart';

// import 'package:moona/core/colors_manager.dart';
// import 'package:moona/core/text_style.dart';
// import 'package:moona/view/contractor/card_detailes_page.dart';
// import 'package:moona/view/contractor/location_picker.dart';

// class CheckoutPage extends StatelessWidget {
//   const CheckoutPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     final theme = Provider.of<ThemeController>(context);
//     final controller = Provider.of<CheckoutController>(context);

//     final bgColor = theme.isLight ? ColorsManager.white : ColorsManager.green;
//     final mainTextColor = theme.isLight
//         ? ColorsManager.green
//         : ColorsManager.white;
//     final accentColor = ColorsManager.gold;

//     return Scaffold(
//       backgroundColor: bgColor,
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: IconThemeData(
//           color: theme.isLight ? ColorsManager.white : ColorsManager.gold,
//         ),
//         title: Text(
//           "Checkout",
//           style: safeInter(
//             color: theme.isLight ? ColorsManager.green : ColorsManager.gold,
//             fontSize: 32.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: REdgeInsets.symmetric(horizontal: 16, vertical: 68),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// ================= Summary =================
//               Container(
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: accentColor, width: 2),
//                 ),
//                 child: Column(
//                   children: [
//                     _summaryRow(
//                       "Items",
//                       "Cement x${cart.totalItems}",
//                       mainTextColor,
//                     ),
//                     _summaryRow(
//                       "Tax",
//                       "${controller.tax(cart.subTotal).toStringAsFixed(0)} \$",
//                       mainTextColor,
//                     ),
//                     _summaryRow(
//                       "Shipping",
//                       "${controller.shippingFees.toStringAsFixed(0)} \$",
//                       mainTextColor,
//                     ),
//                     Divider(color: accentColor),
//                     _summaryRow(
//                       "Total",
//                       "${controller.total(cart.subTotal).toStringAsFixed(0)} \$",
//                       mainTextColor,
//                       isBold: true,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 32.h),

//               /// ================= Location =================
//               Text(
//                 "Delivery Location",
//                 style: safeInter(
//                   color: mainTextColor,
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),

//               SizedBox(height: 12.h),

//               GestureDetector(
//                 onTap: () async {
//                   final result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const LocationPickerPage(),
//                     ),
//                   );

//                   if (result != null) {
//                     controller.setLocation(
//                       address: result["address"],
//                       latitude: result["lat"],
//                       longitude: result["lng"],
//                     );
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 12.h,
//                     horizontal: 14.w,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: accentColor),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(Icons.location_on, color: accentColor),
//                       SizedBox(width: 8.w),
//                       Expanded(
//                         child: Text(
//                           controller.selectedAddress ??
//                               "Choose delivery location",
//                           style: safeInter(
//                             color: mainTextColor,
//                             fontSize: 14.sp,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 32.h),

//               /// ================= Payment =================
//               Text(
//                 "Payment Method",
//                 style: safeInter(
//                   color: mainTextColor,
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),

//               SizedBox(height: 12.h),

//               Row(
//                 children: [
//                   _paymentOption(
//                     title: "Pay with card",
//                     value: 0,
//                     controller: controller,
//                     theme: theme,
//                   ),
//                   SizedBox(width: 24.w),
//                   _paymentOption(
//                     title: "Pay with cash",
//                     value: 1,
//                     controller: controller,
//                     theme: theme,
//                   ),
//                 ],
//               ),

//               SizedBox(height: 24.h),

//               /// ================= Card Button =================
//               if (controller.selectedPayment == 0)
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: accentColor,
//                       foregroundColor: ColorsManager.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     icon: const Icon(Icons.credit_card),
//                     label: Text(
//                       "Enter your card details",
//                       style: safeInter(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const CardDetailesPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//               SizedBox(height: 40.h),

//               /// ================= Proceed =================
//               SizedBox(
//                 width: double.infinity,
//                 height: 54.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: accentColor,
//                     foregroundColor: ColorsManager.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (!controller.canProceed(context)) return;

//                     // lat , lng , selectedAddress
//                     // ابعتهم للـ backend
//                   },
//                   child: Text(
//                     "Proceed",
//                     style: safeInter(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ================= Components =================

//   Widget _summaryRow(
//     String title,
//     String value,
//     Color color, {
//     bool isBold = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "$title:",
//             style: safeInter(
//               color: color,
//               fontSize: 16.sp,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             value,
//             style: safeInter(
//               color: color,
//               fontSize: 16.sp,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _paymentOption({
//     required String title,
//     required int value,
//     required CheckoutController controller,
//     required ThemeController theme,
//   }) {
//     return GestureDetector(
//       onTap: () => controller.selectPayment(value),
//       child: Row(
//         children: [
//           Icon(
//             controller.selectedPayment == value
//                 ? Icons.radio_button_checked
//                 : Icons.radio_button_off,
//             color: ColorsManager.gold,
//           ),
//           SizedBox(width: 6.w),
//           Text(
//             title,
//             style: safeInter(
//               color: theme.isLight ? ColorsManager.green : ColorsManager.white,
//               fontSize: 14.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
