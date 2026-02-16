import 'package:flutter/material.dart';
import 'package:moona/model/cart_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartProvider extends ChangeNotifier {
  final _client = Supabase.instance.client;

  /// ================= Remove =================

  Future<void> removeFromCartByProductId({
    required String productId,
    required BuildContext context,
  }) async {
    final userId = _client.auth.currentUser!.id;

    try {
      await _client
          .from('cart')
          .delete()
          .eq('product_id', productId)
          .eq('user_id', userId);

      notifyListeners();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item removed from cart')));
    } catch (e) {
      debugPrint('REMOVE FROM CART ERROR: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// ================= Increase =================

  Future<void> increaseQuantity(CartItem item) async {
    if (item.quantity < item.stock) {
      item.quantity++;

      int newFinalPrice = (item.price * item.quantity).toInt();

      await _client
          .from('cart')
          .update({'quantity': item.quantity, 'final_price': newFinalPrice})
          .eq('id', item.id);

      notifyListeners();
    }
  }

  /// ================= Decrease =================

  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      item.quantity--;

      int newFinalPrice = (item.price * item.quantity).toInt();

      await _client
          .from('cart')
          .update({'quantity': item.quantity, 'final_price': newFinalPrice})
          .eq('id', item.id);

      notifyListeners();
    }
  }

  /// ================= Max =================

  Future<void> setMaxQuantity(CartItem item) async {
    item.quantity = item.stock;

    int newFinalPrice = (item.price * item.quantity).toInt();

    await _client
        .from('cart')
        .update({'quantity': item.quantity, 'final_price': newFinalPrice})
        .eq('id', item.id);

    notifyListeners();
  }

  /// ================= Clear =================

  Future<void> clearCart(BuildContext context) async {
    final userId = _client.auth.currentUser!.id;

    try {
      await _client.from('cart').delete().eq('user_id', userId);

      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart cleared successfully')),
      );
    } catch (e) {
      debugPrint('CLEAR CART ERROR: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  /// ================= Add to Supabase =================

  // Future<void> addToCartTable({
  //   required String productId,
  //   required int stock,
  //   required double price,
  //   required String image,
  //   required BuildContext context,
  //   required String type,
  //   required String name,
  // }) async {
  //   final userId = _client.auth.currentUser!.id;

  //   try {
  //     await _client.from('cart').insert({
  //       'product_id': productId,
  //       'user_id': userId,
  //       'stock': stock,
  //       'price': price,
  //       'image': image,
  //       'type': type,
  //       'name': name,
  //     });

  //     debugPrint("user : $userId");

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Added to cart successfully')),
  //     );
  //   } catch (e) {
  //     debugPrint('ADD TO CART ERROR: $e');
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  Future<void> addToCartTable({
    required String productId,
    required int stock,
    required double price,
    required String image,
    required BuildContext context,
    required String type,
    required String name,
  }) async {
    final userId = _client.auth.currentUser!.id;

    try {
      // Check if the item is already in the cart
      final existing = await _client
          .from('cart')
          .select()
          .eq('product_id', productId)
          .eq('user_id', userId)
          .single()
          .maybeSingle();

      if (existing != null) {
        // Item exists: update quantity and final_price
        int currentQuantity = existing['quantity'] ?? 1;
        int newQuantity = currentQuantity + 1;
        int newFinalPrice = (price * newQuantity).toInt();

        await _client
            .from('cart')
            .update({'quantity': newQuantity, 'final_price': newFinalPrice})
            .eq('id', existing['id']);
      } else {
        // Item does not exist: insert new
        await _client.from('cart').insert({
          'product_id': productId,
          'user_id': userId,
          'stock': stock,
          'price': price,
          'image': image,
          'type': type,
          'name': name,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully')),
      );
      notifyListeners();
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

    final initial = await _client.from('cart').select().eq('user_id', userId);

    debugPrint('INITIAL RAW: $initial');

    yield (initial as List).map((e) => CartItem.fromMap(e)).toList();
  }
}
