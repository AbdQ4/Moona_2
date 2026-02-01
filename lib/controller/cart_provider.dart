import 'package:flutter/material.dart';
import 'package:moona/model/cart_item_model.dart';
import 'products_provider.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  /// ================= Add =================
  void addToCart(ProductModel product, int quantity) {
    final index = _items.indexWhere((e) => e.id == product.id);

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: product.id,
          name: product.company,
          image: product.image,
          price: product.price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  /// ================= Remove =================
  void removeItem(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  /// ================= Increase =================
  void increaseQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    if (item.quantity < 15) {
      item.quantity++;
      notifyListeners();
    }
  }

  /// ================= Decrease =================
  void decreaseQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  /// ================= Max =================
  void setMaxQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    item.quantity = 15;
    notifyListeners();
  }

  /// ================= Calculations =================
  double get subTotal =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  /// ================= Clear =================
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
