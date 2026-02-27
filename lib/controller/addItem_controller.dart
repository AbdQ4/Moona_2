import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AdditemProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  bool _isDelivery = false;
  bool _isCredit = false;

  bool get isDelivery => _isDelivery;
  bool get isCredit => _isCredit;

  File? _image;
  File? get image => _image;

  final ImagePicker _picker = ImagePicker();

  /// Fetch all products from Supabase
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _supabase
          .from('products')
          .select(
            'id, price_per_ton, description, image_url, type, company, stock, is_delivery, is_credit, name, longitude, latitude',
          );

      _products = List<Map<String, dynamic>>.from(response);
      notifyListeners();
      return _products;
    } catch (e) {
      debugPrint("Error fetching products: $e");
      return [];
    }
  }

  /// Stream data from Supabase
  Stream<List<Map<String, dynamic>>> streamProducts(String type) {
    return _supabase
        .from('products')
        .stream(primaryKey: ['id'])
        .eq('type', type)
        .map((rows) => List<Map<String, dynamic>>.from(rows));
  }

  /// Add a new product and return the inserted row with ID
  Future<Map<String, dynamic>?> addProduct({
    required double price,
    required String description,
    required String type,
    required String company,
    required double stock,
    required bool isDelivery,
    required bool isCredit,
    required String name,
    required double lng,
    required double lat,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToSupabase(imageFile);
      }

      final response = await _supabase
          .from('products')
          .insert({
            'price_per_ton': price,
            'description': description,
            'image_url': imageUrl,
            'type': type,
            'company': company,
            'stock': stock,
            'is_delivery': isDelivery,
            'is_credit': isCredit,
            'name': name,
            'longitude': lng,
            'latitude': lat,
          })
          .select(
            'id, price_per_ton, description, image_url, type, company, stock, is_delivery, is_credit, name, longitude, latitude',
          );

      if (response.isNotEmpty) {
        final newProduct = response.first;
        _products.add(newProduct);
        notifyListeners();
        debugPrint("✅ New product added with ID: ${newProduct['id']}");
        return newProduct;
      }
    } catch (e) {
      debugPrint("❌ Error adding product: $e");
    }
    return null;
  }

  /// Update product details
  Future<Map<String, dynamic>?> updateProduct({
    required String productId,
    double? price,
    String? description,
    String? type,
    String? company,
    double? stock,
    bool? isDelivery,
    bool? isCredit,
    File? imageFile,
    String? name,
    double? lng,
    double? lat,
  }) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToSupabase(imageFile);
      }

      final updatedData = {
        if (price != null) 'price_per_ton': price,
        if (description != null) 'description': description,
        if (type != null) 'type': type,
        if (company != null) 'company': company,
        if (stock != null) 'stock': stock,
        if (isDelivery != null) 'is_delivery': isDelivery,
        if (isCredit != null) 'is_credit': isCredit,
        if (imageUrl != null) 'image_url': imageUrl,
        if (name != null) 'name': name,
        if (lng != null) 'longitude': lng,
        if (lat != null) 'latitude': lat,
      };

      final response = await _supabase
          .from('products')
          .update(updatedData)
          .eq('id', productId)
          .select();

      if (response.isEmpty) return null;

      final updatedProduct = response.first;

      final index = _products.indexWhere((p) => p['id'] == productId);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }

      debugPrint("✅ Product updated successfully: $productId");
      return updatedProduct;
    } catch (e) {
      debugPrint("❌ Update error: $e");
      return null;
    }
  }

  /// Delete product by ID
  Future<bool> deleteProduct(dynamic productId) async {
    try {
      final deleteResult = await _supabase
          .from('products')
          .delete()
          .eq('id', productId)
          .select('id');

      final deletedCount = (deleteResult is List) ? deleteResult.length : 1;
      if (deletedCount > 0) {
        _products.removeWhere(
          (p) => p['id'].toString() == productId.toString(),
        );
        notifyListeners();
        debugPrint("✅ Product deleted. id=$productId");
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ deleteProduct exception: $e");
      return false;
    }
  }

  /// Toggle delivery
  void toggleDelivery(bool value) {
    _isDelivery = value;
    notifyListeners();
  }

  /// Toggle credit
  void toggleCredit(bool value) {
    _isCredit = value;
    notifyListeners();
  }

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
        debugPrint("✅ Image picked from gallery: ${pickedFile.path}");
      }
    } catch (e) {
      debugPrint("❌ Error picking image from gallery: $e");
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        _image = File(pickedFile.path);
        notifyListeners();
        debugPrint("✅ Image captured from camera: ${pickedFile.path}");
      }
    } catch (e) {
      debugPrint("❌ Error capturing image from camera: $e");
    }
  }

  /// Clear selected image
  void clearImage() {
    _image = null;
    notifyListeners();
  }

  /// Upload image to Supabase storage and return public URL
  Future<String?> uploadImageToSupabase(File file) async {
    try {
      final uuid = Uuid().v4();
      final fileExt = file.path.split('.').last;
      final fileName = '$uuid.$fileExt';
      final bucket = 'product_image';

      final response = await _supabase.storage
          .from(bucket)
          .upload(fileName, file);

      if (response != null) {
        final publicUrl = _supabase.storage.from(bucket).getPublicUrl(fileName);
        debugPrint("✅ Image uploaded: $publicUrl");
        return publicUrl;
      }
    } catch (e) {
      debugPrint("❌ Error uploading image to Supabase: $e");
    }
    return null;
  }
}
