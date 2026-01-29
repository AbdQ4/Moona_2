import 'package:flutter/material.dart';
import 'package:moona/model/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [
    CartItem(
      id: '1',
      image: 'assets/images/cement.jpg',
      name: 'Cement A',
      pricePerTon: 4200,
      quantity: 2,
    ),
    CartItem(
      id: '2',
      image: 'assets/images/cement.jpg',
      name: 'Cement B',
      pricePerTon: 4000,
      quantity: 1,
    ),
    CartItem(
      id: '3',
      image: 'assets/images/cement.jpg',
      name: 'Cement C',
      pricePerTon: 4300,
      quantity: 2,
    ),
  ];

  List<CartItem> get items => _items;

  void increaseQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  double get totalCartPrice {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void setMaxQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    item.quantity = 15;
    notifyListeners();
  }

  double get subTotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
