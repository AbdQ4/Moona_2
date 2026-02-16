import 'package:flutter/material.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final String image;
  final String company;
  final String location;
  final double price;
  final int stock;
  final String description;
  final bool delivery;
  final bool sellOnCredit;

  ProductDetailsProvider({
    required this.image,
    required this.company,
    required this.location,
    required this.price,
    required this.stock,
    required this.description,
    required this.delivery,
    required this.sellOnCredit,
  });

  int quantity = 1;

  void increaseQuantity() {
    if (quantity < stock) {
      quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  /// 🔥 هنا الربط الحقيقي
  // void addToCart(BuildContext context) {
  //   final cart = Provider.of<CartProvider>(context, listen: false);

  //   cart.addToCart(
  //     ProductModel(
  //       id: "2121",
  //       image: image,
  //       company: company,
  //       location: location,
  //       price: price,
  //       stock: stock,
  //       description: description,
  //       delivery: delivery,
  //       sellOnCredit: sellOnCredit,
  //     ),
  //     quantity,
  //   );
  // }
}
