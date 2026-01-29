class Product {
  final String type;
  final double stock;
  final double pricePerTon;
  final String company;
  final String description;
  final bool isDelivery;
  final bool isCredit;
  final String imagePath;

  Product({
    required this.type,
    required this.stock,
    required this.pricePerTon,
    required this.company,
    required this.description,
    required this.isDelivery,
    required this.isCredit,
    required this.imagePath,
  });
}
