class CartItem {
  final String id;
  final String image;
  final String name;
  final double pricePerTon;

  int quantity;

  CartItem({
    required this.id,
    required this.image,
    required this.name,
    required this.pricePerTon,
    this.quantity = 1,
  });

  double get totalPrice => pricePerTon * quantity;
}
