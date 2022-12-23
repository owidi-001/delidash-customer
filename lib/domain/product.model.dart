import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String name;
  final String unit;
  final double unitPrice;
  final String image;
  final String description;
  final int stock;
  final ItemCategory category;
  final int vendor;

  // constructor
  Item(
      {required this.id,
      required this.name,
      required this.unit,
      required this.unitPrice,
      required this.image,
      required this.description,
      required this.stock,
      required this.category,
      required this.vendor});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json["id"],
        name: json["name"],
        unit: json["unit"],
        unitPrice: double.parse(json["unit_price"]),
        image: json["image"],
        description: json["description"],
        stock: json["stock"],
        category: json["category"],
        vendor: json["vendor"]);
  }

  static Map<String, dynamic> toMap(Item item) {
    return {
      "id": item.id,
      "name": item.name,
      "unit": item.unit,
      "unit_price": item.unitPrice,
      "image": item.image,
      "description": item.description,
      "stock": item.stock,
      "category": ItemCategory.toMap(item.category),
      "vendor": item.vendor
    };
  }

  @override
  List<Object?> get props =>
      [id, name, unit, unitPrice, image, description, stock, category, vendor];

  factory Item.empty() => Item(
      id: 1,
      name: "dummy",
      unit: "kg",
      unitPrice: 0.00,
      image: "assets/images/banner.png",
      description: "",
      stock: 0,
      vendor: 0,
      category: ItemCategory.empty());
}

class ItemCategory {
  final int id;
  final String name;
  final String icon;
  final String dateCreated;

  // constructor
  ItemCategory(
      {required this.id,
      required this.name,
      required this.icon,
      required this.dateCreated});

  // Factory toJson
  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        dateCreated: json["date_created"]);
  }

  // toMap
  static toMap(ItemCategory category) {
    return {
      "id": category.id,
      "name": category.name,
      "icon": category.icon,
      "date_created": category.dateCreated
    };
  }

  factory ItemCategory.empty() => ItemCategory(
      id: -1,
      icon: "assets/images/app_logo.png",
      name: "All",
      dateCreated: "2022-12-23T14:03:55Z");

  bool equals(ItemCategory itemCategory) {
    return id == itemCategory.id;
  }
}
