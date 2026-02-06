class CartItem {
  final String id;
  final String productId;
  final String userId;
  final double price;
  final String image;
  int quantity;
  final int stock;

  CartItem({
    required this.id,
    this.quantity = 1,
    required this.productId,
    required this.userId,
    required this.price,
    required this.image,
    required this.stock,
  });

  double get totalPrice => price * quantity;

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['product_id'],
      userId: map['user_id'],
      price: (map['price'] as num).toDouble(),
      stock: map['stock'],
      image: map['image'],
    );
  }
}
