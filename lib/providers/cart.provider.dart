import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/domain/product.model.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<CartItemModel> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<CartItemModel> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(CartItemModel item) {
    for (var cartItem in items) {
      if (item.product.id == cartItem.product.id) {
        return;
      } 
    }
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void updateCart(CartItemModel cartProduct, int quantity) {
    _items = _items
        .map((e) {
          if (e.product.id == cartProduct.product.id) {
            return e.copyWith(quantity: quantity);
          }
          return e;
        })
        .where((element) => element.quantity > 0)
        .toList();
    notifyListeners();
  }
}
