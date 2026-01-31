import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String image;
  final String company;
  final String location;
  final double price;
  final int stock;
  final String description;
  final bool delivery;
  final bool sellOnCredit;

  ProductModel({
    required this.id,
    required this.image,
    required this.company,
    required this.location,
    required this.price,
    required this.stock,
    required this.description,
    required this.delivery,
    required this.sellOnCredit,
  });
}

class ProductsProvider extends ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel(
      id: "1",
      image: "assets/images/cement.jpg",
      company: "Tora",
      location: "Cairo",
      price: 4200,
      stock: 400,
      description: "High quality cement",
      delivery: true,
      sellOnCredit: false,
    ),
    ProductModel(
      id: "2",
      image: "assets/images/cement.jpg",
      company: "El Sues",
      location: "Dakahlia",
      price: 4500,
      stock: 350,
      description: "Strong cement for construction",
      delivery: true,
      sellOnCredit: true,
    ),
    ProductModel(
      id: "3",
      image: "assets/images/cement.jpg",
      company: "Portland",
      location: "Sues",
      price: 4000,
      stock: 500,
      description: "Premium cement",
      delivery: true,
      sellOnCredit: false,
    ),
  ];

  List<ProductModel> get products => _products;

  ProductModel findById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
