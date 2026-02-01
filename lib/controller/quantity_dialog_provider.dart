import 'package:flutter/material.dart';

enum DeliveryMethod { pickup, delivery }

class QuantityDialogProvider extends ChangeNotifier {
  int _quantity = 1;
  DeliveryMethod _method = DeliveryMethod.pickup;

  final double pricePerTon;
  final double deliveryFees;
  final int maxQuantity;

  QuantityDialogProvider({
    required this.pricePerTon,
    this.deliveryFees = 300,
    this.maxQuantity = 15,
  });

  int get quantity => _quantity;
  DeliveryMethod get method => _method;

  double get totalPrice {
    double total = _quantity * pricePerTon;
    if (_method == DeliveryMethod.delivery) {
      total += deliveryFees;
    }
    return total;
  }

  void increase() {
    if (_quantity < maxQuantity) {
      _quantity++;
      notifyListeners();
    }
  }

  void decrease() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void setQuantity(int value) {
    if (value < 1) value = 1;
    if (value > maxQuantity) value = maxQuantity;
    _quantity = value;
    notifyListeners();
  }

  void setMax() {
    _quantity = maxQuantity;
    notifyListeners();
  }

  void setMethod(DeliveryMethod value) {
    _method = value;
    notifyListeners();
  }
}
