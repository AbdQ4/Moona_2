import 'package:flutter/material.dart';
import 'package:moona/model/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'products_provider.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  final _client = Supabase.instance.client;

  /// ================= Add =================
  Future<void> addToCart(Map<String, dynamic> product, int quantity) async {
    final index = _items.indexWhere((e) => e.id == product['id']);

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: product['id'],
          price: product['price'].toDouble(),
          quantity: quantity,
          productId: product['id'],
          userId: Supabase.instance.client.auth.currentUser!.id,
          image: product['image'],
          stock: product['stock'],
        ),
      );
    }
    notifyListeners();
  }

  /// ================= Remove =================
  void removeItem(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  /// ================= Increase =================
  void increaseQuantity(String id, int stock) {
    final item = _items.firstWhere((e) => e.id == id);
    if (item.quantity < stock) {
      item.quantity++;
      notifyListeners();
    }
  }

  /// ================= Decrease =================
  void decreaseQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    }
  }

  /// ================= Max =================
  void setMaxQuantity(String id) {
    final item = _items.firstWhere((e) => e.id == id);
    item.quantity = 15;
    notifyListeners();
  }

  /// ================= Calculations =================
  double get subTotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  /// ================= Clear =================
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// ================= Add to Supabase =================

  Future<void> addToCartTable({
    required String productId,
    required int stock,
    required double price,
    required BuildContext context,
  }) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not logged in')));
      return;
    }

    try {
      await _client.from('cart').insert({
        'product_id': productId,
        'user_id': user.id,
        'stock': stock,
        'price': price,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully')),
      );
    } catch (e) {
      debugPrint('ADD TO CART ERROR: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// ================= Fetch Supabase =================

  Stream<List<CartItem>> cartStream() async* {
    final userId = _client.auth.currentUser!.id;

    // 🔹 1. fetch أول مرة
    final initial = await _client
        .from('cart')
        .select()
        .eq('user_id', userId)
        .order('id');

    yield (initial as List).map((e) => CartItem.fromMap(e)).toList();

    // 🔹 2. stream التغييرات
    yield* _client
        .from('cart')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((rows) => rows.map((e) => CartItem.fromMap(e)).toList());
  }
}
