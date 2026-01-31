import 'package:flutter/material.dart';


class CheckoutController extends ChangeNotifier {
  /// ================= Payment =================
  int selectedPayment = 0; // 0 = card , 1 = cash

  /// ================= Location =================
  String? selectedAddress;
  double? lat;
  double? lng;

  /// ================= Constants =================
  final double taxRate = 0.05;
  final double shippingFees = 255;

  /// ================= Calculations =================
  double tax(double subTotal) => subTotal * taxRate;

  double total(double subTotal) =>
      subTotal + tax(subTotal) + shippingFees;

  /// ================= Payment =================
  void selectPayment(int value) {
    selectedPayment = value;
    notifyListeners();
  }

  /// ================= Location =================
  void setLocation({
    required String address,
    required double latitude,
    required double longitude,
  }) {
    selectedAddress = address;
    lat = latitude;
    lng = longitude;
    notifyListeners();
  }

  /// ================= Validation =================
  bool canProceed(BuildContext context) {
    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select delivery location"),
        ),
      );
      return false;
    }
    return true;
  }
}
