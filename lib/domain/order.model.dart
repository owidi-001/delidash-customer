import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/product.model.dart';


class OrderItem {
  final int id;
  final int order;
  final int quantity;
  Product product;

  OrderItem({
    required this.id,
    required this.order,
    required this.product,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    Product product = Product.fromJson(json["product"]);

    return OrderItem(
      id: json["id"],
      order: json["cart"],
      product: product,
      quantity: json["quantity"],
    );
  }

  static Map<String, dynamic> toMap(OrderItem item) {
    Map<String, dynamic> data = {
      "id": item.id,
      "cart": item.order,
      "quantity": item.quantity,
      "product": Product.toMap(item.product)
    };

    return data;
  }
}

class Order {
  final int id;
  final int user;
  final String status;
  final String dateOrdered;
  final double total;
  final Location? location;

  Order({
    required this.id,
    required this.user,
    required this.status,
    required this.total,
    required this.dateOrdered,
    this.location,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    Location? location;
    try {
      location = Location.fromJson(json["location"]);
    } catch (e) {
      location = null;
    }

    return Order(
      id: json["id"],
      user: json["user"],
      status: json["status"],
      total: double.parse(json["total"]),
      dateOrdered: json["date_ordered"],
      location: location,
    );
  }
}
