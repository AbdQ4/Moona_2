class CartItem {
  final String id;
  final String name;
  final double price;
   final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1, required this.image, 
  });

  double get totalPrice => price * quantity;
}



