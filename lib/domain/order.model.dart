import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/domain/rider.model.dart';

// Sample data format received
var x = """
    {
        "id": 1,
        "item": {
            "id": 3,
            "category": {
                "id": 1,
                "name": "Chicken",
                "icon": "/media/category/2022/12/23/chicken.png",
                "date_created": "2022-12-23T14:03:55Z"
            },
            "name": "Burger king",
            "unit": "kg",
            "unit_price": "350.00",
            "image": "/media/product/2022/12/23/kfc_fries.png",
            "description": "Burger king cons",
            "stock": 20,
            "date_added": "2022-12-23T14:34:56.858136Z",
            "vendor": 1
        },
        "delivery_address": {
            "id": 1,
            "placemark": "Nakuru,kenya,njoro",
            "country": "Kenya",
            "city": "Nakuru",
            "street": "Njokerio",
            "block": "Binti",
            "floor": "2",
            "room": "20"
        },
        "date_ordered": "2022-12-23T19:27:55.584135Z",
        "date_dispatched": null,
        "date_delivered": null,
        "quantity": 1,
        "status": "Pending",
        "customer": {
            "name": "",
            "email": "clientx@mail.com",
            "phone_number": "0786484661"
        },
        "rider": {
            "id": 1,
            "user": {
                "name": "Odhis the rider",
                "email": "rider@mail.com",
                "phone_number": "0742446941"
            },
            "brand": "Odhis Rides",
            "dob": "07/12/2001",
            "gender": "male",
            "national_id": "65722380",
            "license": "DHZ354"
        }
    }


""";

class Order {
  final int id;
  final Item item;
  final Address deliveryAddress;
  final String dateOrdered;
  final String? dateDispatched;
  final String? dateDelivered;
  final int quantity;
  final String status;
  final Rider? rider;

  // constructor
  Order(
      {required this.id,
      required this.item,
      required this.deliveryAddress,
      required this.dateOrdered,
      this.dateDispatched,
      this.dateDelivered,
      required this.quantity,
      this.rider,
      required this.status});

  // factory fromJson
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        item: Item.fromJson(json["item"]),
        deliveryAddress: Address.fromJson(json["delivery_address"]),
        dateOrdered: json["date_ordered"],
        dateDispatched: json["date_dispatched"],
        dateDelivered: json["date_delivered"],
        quantity: json["quantity"],
        rider: json["rider"] != null ? Rider.fromJson(json["rider"]) : null,
        status: json["status"]);
  }

  // factory toMap
  static Map<String, dynamic> toMap(Order order) {
    return {
      "id": order.id,
    };
  }
}
