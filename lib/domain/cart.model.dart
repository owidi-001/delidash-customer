import 'package:greens_veges/domain/product.model.dart';

class CartItemModel {
  late final Product product;
  late final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({Product? product, int? quantity}) {
    return CartItemModel(
        product: product ?? this.product, quantity: quantity ?? this.quantity);
  }
}
