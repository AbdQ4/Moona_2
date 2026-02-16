class CartItem {
  final String id;
  final String productId;
  final String userId;
  final double price;
  final int stock;
  final String image;
  final String type;
  final String name;
  int finalPrice;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.userId,
    required this.price,
    required this.stock,
    this.quantity = 1,
    this.finalPrice = 0,
    required this.image,
    required this.type,
    required this.name,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['product_id'] as String,
      userId: map['user_id'] as String,
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int,
      quantity: map['quantity'] ?? 1,
      finalPrice: map['final_price'] ?? 0,
      image: map['image'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
    );
  }
}
