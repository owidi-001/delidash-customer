import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:http/retry.dart';

// Sample data format received
var x = """
{

    "id": 1,
    "cart": 1,
    "quantity": 2,
    "product": {
        "id": 2,
        "label": "Tomatoes",
        "unit": "kg",
        "unit_price": "50.00",
        "image": "/media/product/2022/12/16/tomatoes.png",
        "description": "We have a varieties of tomato breeds. Come get your and give us your feedback.",
        "stock": 5,
        "created_at": "2022-12-16T13:13:51.618354Z",
        "category": 1,
        "vendor": 1
    },
    "status": "Pending",
    "time": "13:39:48.860035",
    "date": "2022-12-16T13:39:48.859981Z"

},
""";

class OrderItem {
  final int? id;
  final int? order;
  final int quantity;
  Product product;
  final String status;
  final String date;
  final String time;

  OrderItem(
      {this.id,
      this.order,
      required this.product,
      required this.quantity,
      required this.status,
      required this.date,
      required this.time});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    Product product = Product.fromJson(json["product"]);

    return OrderItem(
        id: json["id"],
        order: json["cart"],
        product: product,
        quantity: json["quantity"],
        status: json["status"],
        date: json["date"],
        time: json["time"]);
  }

  static Map<String, dynamic> toMap(OrderItem item) {
    Map<String, dynamic> data = {
      "id": item.id,
      "cart": item.order,
      "quantity": item.quantity,
      "product": Product.toMap(item.product),
      "date": item.date,
      "time": item.time,
      "status": item.status
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
