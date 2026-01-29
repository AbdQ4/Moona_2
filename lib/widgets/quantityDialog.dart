import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moona/core/colors_manager.dart';

class QuantityDialog extends StatefulWidget {
  const QuantityDialog({super.key});

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  int quantity = 2;
  int selectedMethod = 0; // 0 = Pickup, 1 = Delivery

  final double pricePerTon = 4200;
  final double deliveryFees = 300;

  final int maxQuantity = 15;

  final TextEditingController quantityController =
      TextEditingController(text: '2');

  double get totalPrice {
    double price = quantity * pricePerTon;
    if (selectedMethod == 1) {
      price += deliveryFees;
    }
    return price;
  }

  void _updateQuantity(int newValue) {
    if (newValue < 1) newValue = 1;
    if (newValue > maxQuantity) newValue = maxQuantity;

    setState(() {
      quantity = newValue;
      quantityController.text = newValue.toString();
    });
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsManager.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: ColorsManager.white, width: 3),
      ),
      child: SizedBox(
        width: 302.w,
        height: 280.h,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity / ton',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: ColorsManager.white,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.grey,
                          border: Border.all(color: ColorsManager.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            _iconButton(
                              text: '-',
                              onTap: () =>
                                  _updateQuantity(quantity - 1),
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.green,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (value) {
                                  final parsed =
                                      int.tryParse(value);
                                  if (parsed != null) {
                                    _updateQuantity(parsed);
                                  }
                                },
                              ),
                            ),
                            _iconButton(
                              text: '+',
                              onTap: () =>
                                  _updateQuantity(quantity + 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      TextButton(
                        onPressed: () =>
                            _updateQuantity(maxQuantity),
                        child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.gold,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text(
                              'Max',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// Pickup / Delivery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _radioItem(title: 'Pickup', value: 0),
                  Row(
                    children: [
                      _radioItem(title: 'Delivery', value: 1),
                      const SizedBox(width: 4),
                      const Text(
                        '+fees',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// On credit (Disabled)
              Row(
                children: const [
                  Text(
                    'On credit',
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorsManager.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.block,
                      size: 18, color: ColorsManager.grey),
                ],
              ),

              const SizedBox(height: 16),

              /// Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: ColorsManager.white,
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)}\$',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: ColorsManager.white,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// Add to Cart
              Center(
                child: SizedBox(
                  width: 258.w,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.gold,
                      foregroundColor: ColorsManager.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.green,
          ),
        ),
      ),
    );
  }

  Widget _radioItem({
    required String title,
    required int value,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => selectedMethod = value);
          },
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsManager.white,
                width: 2,
              ),
            ),
            child: selectedMethod == value
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.white,
                      ),
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: ColorsManager.white,
          ),
        ),
      ],
    );
  }
}
