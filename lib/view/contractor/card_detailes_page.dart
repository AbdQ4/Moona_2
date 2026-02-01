import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/controller/payment_controller.dart';
import 'package:provider/provider.dart';

import 'package:moona/controller/theme_controller.dart';

import 'package:moona/core/colors_manager.dart';
import 'package:moona/core/text_style.dart';
import 'package:moona/widgets/custom_elevated_button.dart';

class CardDetailesPage extends StatelessWidget {
  const CardDetailesPage({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    final controller = Provider.of<CardDetailsController>(context);

    return Scaffold(
      backgroundColor: theme.isLight
          ? ColorsManager.white
          : ColorsManager.green,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.isLight ? ColorsManager.white : ColorsManager.gold,
        ),
        title: Text(
          "Card Details",
          style: safeInter(
            color: theme.isLight ? ColorsManager.green : ColorsManager.gold,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 68),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ================= Card Preview =================
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.green,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: ColorsManager.gold, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.getCardImage(),
                      SizedBox(height: 20.h),
                      Text(
                        controller.cardNumberController.text.isEmpty
                            ? "**** **** **** ****"
                            : controller.cardNumberController.text,
                        style: safeInter(
                          color: ColorsManager.white,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.cardNameController.text.isEmpty
                                ? "CARD HOLDER"
                                : controller.cardNameController.text
                                      .toUpperCase(),
                            style: safeInter(
                              color: ColorsManager.white,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            controller.expiryController.text.isEmpty
                                ? "MM/YY"
                                : controller.expiryController.text,
                            style: safeInter(
                              color: ColorsManager.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                /// ================= Card Number =================
                _inputField(
                  theme: theme,
                  controller: controller.cardNumberController,
                  hint: "Card Number",
                  keyboard: TextInputType.number,
                  maxLength: 19,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ],
                  onChanged: controller.onCardNumberChanged,
                  validator: controller.cardNumberValidator,
                ),

                SizedBox(height: 16.h),

                /// ================= Card Holder =================
                _inputField(
                  theme: theme,
                  controller: controller.cardNameController,
                  hint: "Card Holder Name",
                  onChanged: (_) => controller.notifyListeners(),
                ),

                SizedBox(height: 16.h),

                /// ================= Expiry + CVV =================
                Row(
                  children: [
                    Expanded(
                      child: _inputField(
                        theme: theme,
                        controller: controller.expiryController,
                        hint: "MM/YY",
                        keyboard: TextInputType.number,
                        maxLength: 5,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          ExpiryDateFormatter(),
                        ],
                        onChanged: (_) => controller.notifyListeners(),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _inputField(
                        theme: theme,
                        controller: controller.cvvController,
                        hint: "CVV",
                        keyboard: TextInputType.number,
                        obscure: true,
                        maxLength: controller.getCvvLength(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: controller.cvvValidator,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                /// ================= Confirm =================
                CustomElevatedButton(
                  title: "Confirm Payment",
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      // Confirm payment
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= Input Field =================
  Widget _inputField({
    required ThemeController theme,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator:
          validator ??
          (value) => value == null || value.isEmpty ? "Required field" : null,
      style: safeInter(
        color: theme.isLight ? ColorsManager.green : ColorsManager.white,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        counterText: "",
        hintText: hint,
        filled: true,
        fillColor: theme.isLight ? ColorsManager.white : ColorsManager.green,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.gold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.gold, width: 2),
        ),
      ),
    );
  }
}
