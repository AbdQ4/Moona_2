import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdditemProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  bool _isDelivery = false;
  bool _isCredit = false;

  bool get isDelivery => _isDelivery;
  bool get isCredit => _isCredit;

  /// Fetch all products from Supabase
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _supabase
          .from('products')
          .select(
            'id, price_per_ton, description, image_url, type, company, stock, is_delivery, is_credit, name',
          );

      _products = List<Map<String, dynamic>>.from(response);
      notifyListeners();
      return _products; // ✅ return the list
    } catch (e) {
      debugPrint("Error fetching products: $e");
      return []; // ✅ return empty list on error
    }
  }

  /// Stream data from Supabase

  Stream<List<Map<String, dynamic>>> streamProducts(String type) {
    return _supabase
        .from('products')
        .stream(primaryKey: ['id']) // primary key must be in table
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
    String? imageUrl,
  }) async {
    try {
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
          })
          .select(
            'id, price_per_ton, description, image_url, type, company, stock, is_delivery, is_credit, name',
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
    required String productId, // keep as String
    double? price,
    String? description,
    String? type,
    String? company,
    double? stock,
    bool? isDelivery,
    bool? isCredit,
    String? imageUrl,
    String? name,
  }) async {
    try {
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
      };

      final response = await _supabase
          .from('products')
          .update(updatedData)
          .eq('id', productId) // ✅ UUID string comparison
          .select();

      if (response.isEmpty) return null;

      final updatedProduct = response.first;

      // Update local list
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
  /// Returns true on success, false on failure.
  /// Will print detailed debug info to help identify the problem.
  Future<bool> deleteProduct(dynamic productId) async {
    try {
      debugPrint(
        ">>> deleteProduct called with productId: $productId (type=${productId.runtimeType})",
      );

      // 1) Try to find the row first (attempt as-is)
      final findResult = await _supabase
          .from('products')
          .select('id, name')
          .eq('id', productId);

      debugPrint(">>> findResult (eq as-is) -> ${findResult}");

      // 2) If nothing found, try alternative types (string / int)
      if ((findResult == null || (findResult is List && findResult.isEmpty))) {
        // try string version
        final strId = productId.toString();
        final findStr = await _supabase
            .from('products')
            .select('id, name')
            .eq('id', strId);
        debugPrint(">>> findResult (eq string) -> ${findStr}");

        // try numeric version if productId looks numeric
        if (int.tryParse(strId) != null) {
          final intId = int.parse(strId);
          final findInt = await _supabase
              .from('products')
              .select('id, name')
              .eq('id', intId);
          debugPrint(">>> findResult (eq int) -> ${findInt}");
        }
      }

      // 3) Perform delete and request returning rows using .select()
      final deleteResult = await _supabase
          .from('products')
          .delete()
          .eq('id', productId)
          .select('id');

      debugPrint(">>> deleteResult -> $deleteResult");

      // Some Supabase setups return [] on delete success or return deleted rows.
      final deletedCount = (deleteResult is List)
          ? deleteResult.length
          : (deleteResult != null ? 1 : 0);
      if (deletedCount > 0) {
        _products.removeWhere(
          (p) => p['id'].toString() == productId.toString(),
        );
        notifyListeners();
        debugPrint("✅ Product deleted locally and remotely. id=$productId");
        return true;
      } else {
        // maybe the API returned empty list but row was deleted — check by trying to select again:
        final check = await _supabase
            .from('products')
            .select('id')
            .eq('id', productId);
        debugPrint(">>> post-delete check select -> $check");
        if (check == null || (check is List && check.isEmpty)) {
          // row not found after delete, treat as success
          _products.removeWhere(
            (p) => p['id'].toString() == productId.toString(),
          );
          notifyListeners();
          debugPrint(
            "✅ Delete appears successful (row not found after). id=$productId",
          );
          return true;
        }

        debugPrint(
          "❌ Delete returned no deleted rows and row still exists. id=$productId",
        );
        return false;
      }
    } catch (e, st) {
      debugPrint("❌ deleteProduct exception: $e");
      debugPrint("❌ stacktrace: $st");
      return false;
    }
  }

  /// Toggle delivery
  void toggleDelivery(bool value) {
    _isDelivery = value;
    notifyListeners();
    debugPrint("Delivery option set to $_isDelivery");
  }

  /// Toggle credit
  void toggleCredit(bool value) {
    _isCredit = value;
    notifyListeners();
    debugPrint("Credit option set to $_isCredit");
  }
}
