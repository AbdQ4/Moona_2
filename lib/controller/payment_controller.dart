import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moona/core/colors_manager.dart';

enum CardType { visa, mastercard, amex, discover, unknown }

class CardDetailsController extends ChangeNotifier {
  /// ================= Controllers =================
  final formKey = GlobalKey<FormState>();

  final cardNumberController = TextEditingController();
  final cardNameController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  CardType cardType = CardType.unknown;

  /// ================= Card Type Detection =================
  void onCardNumberChanged(String value) {
    cardType = detectCardType(value);
    cvvController.clear();
    notifyListeners();
  }

  CardType detectCardType(String input) {
    final number = input.replaceAll(' ', '');

    if (number.startsWith('4')) return CardType.visa;

    if (number.length >= 2) {
      final prefix2 = int.tryParse(number.substring(0, 2)) ?? 0;
      if (prefix2 >= 51 && prefix2 <= 55) return CardType.mastercard;
    }

    if (number.length >= 4) {
      final prefix4 = int.tryParse(number.substring(0, 4)) ?? 0;
      if (prefix4 >= 2221 && prefix4 <= 2720) return CardType.mastercard;
    }

    if (number.startsWith('34') || number.startsWith('37')) {
      return CardType.amex;
    }

    if (number.startsWith('6011') || number.startsWith('65')) {
      return CardType.discover;
    }

    return CardType.unknown;
  }

  /// ================= Luhn Algorithm =================
  bool isValidCardNumber(String input) {
    final digits = input.replaceAll(' ', '');
    if (digits.length < 13) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.parse(digits[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// ================= CVV Length =================
  int getCvvLength() {
    return cardType == CardType.amex ? 4 : 3;
  }

  /// ================= Card Image =================
  Widget getCardImage() {
    switch (cardType) {
      case CardType.visa:
        return Image.asset("assets/images/Visa_Logo.png", height: 32);
      case CardType.mastercard:
        return Image.asset("assets/images/MasterCard_Logo.png", height: 32);
      case CardType.amex:
        return Image.asset("assets/images/American_Express_logo.png", height: 32);
      case CardType.discover:
        return Image.asset("assets/images/Discover_Card_logo.png", height: 32);
      default:
        return const Icon(Icons.credit_card,
            color: ColorsManager.gold, size: 32);
    }
  }

  /// ================= Validation =================
  String? cardNumberValidator(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (!isValidCardNumber(value)) return "Invalid card number";
    return null;
  }

  String? cvvValidator(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (value.length != getCvvLength()) return "Invalid CVV";
    return null;
  }
}

/// ================= Formatters =================
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i != digits.length - 1) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection:
          TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll('/', '');

    if (digits.length >= 3) {
      final text = "${digits.substring(0, 2)}/${digits.substring(2)}";
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    return newValue;
  }
}
