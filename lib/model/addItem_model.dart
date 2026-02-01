class ProductModel {
  final String id;
  final DateTime? soldAt;
  final String seller;
  final double price;
  final String type;
  final String name;
  final bool delivery;
  final bool onCredit;
  final int stock;
  final String locationLink;

  ProductModel({
    required this.id,
    this.soldAt,
    required this.seller,
    required this.price,
    required this.type,
    required this.name,
    required this.delivery,
    required this.onCredit,
    required this.stock,
    required this.locationLink,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toString(),
      soldAt: map['sold_at'] != null
          ? DateTime.parse(map['sold_at'])
          : null,
      seller: map['seller'],
      price: (map['price'] as num).toDouble(),
      type: map['type'],
      name: map['name'],
      delivery: map['delivery'],
      onCredit: map['on_credit'],
      stock: map['stock'],
      locationLink: map['location_link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'seller': seller,
      'price': price,
      'type': type,
      'name': name,
      'delivery': delivery,
      'on_credit': onCredit,
      'stock': stock,
      'location_link': locationLink,
    };
  }
}
