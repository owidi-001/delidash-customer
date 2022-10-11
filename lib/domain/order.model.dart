import 'package:greens_veges/domain/product.model.dart';

/*

{

    "id": 11,
    "cart": 2,
    "quantity": 1,
    "product": {
        "id": 4,
        "label": "Avocado",
        "unit": "kg",
        "unit_price": "200.00",
        "image": "/media/product/2022/10/04/avocado.png",
        "description": "Developed in 1951 by James Bacon, this avocado type is a medium-sized fruit with yellowish-green, light-tasting flesh. It has a large seed with the flesh containing a large amount of oil. 9. Cleopatra. It is a relatively new avocado type with a medium-sized fruit having yellow, creamy flesh and a rich, creamy flavor.",
        "stock": 1,
        "category": 6,
        "vendor": 9
    }

},

 */

class OrderItem {
  final int id;
  final int order;
  final int quantity;
  Product product;

  OrderItem(
      {required this.id,
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
}

class Location {
  final double? lng;
  final double? lat;
  final String? name;
  final String? city;
  final String? street;
  late final String? blockName;
  late final String? floor;
  late final String? roomNumber;

  Location({this.lng, this.lat, this.name, this.city, this.street,this.blockName,this.floor,this.roomNumber});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        lng: json["lng"],
        lat: json["lat"],
        name: json["name"],
        city: json["city"],
        street: json["street"]);
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
