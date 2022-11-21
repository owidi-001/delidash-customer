import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String label;
  final String? unit;
  final double unitPrice;
  final String image;
  final String description;
  final int stock;
  final int? category;
  final int vendor;

  // constructor
  Product(
      {required this.id,
      required this.label,
      this.unit,
      required this.unitPrice,
      required this.image,
      required this.description,
      required this.stock,
      this.category,
      required this.vendor});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        label: json["label"],
        unitPrice: double.parse(json["unit_price"]),
        image: json["image"],
        description: json["description"],
        stock: json["stock"],
        category: json["category"],
        vendor: json["vendor"]);
  }

  static Map<String, dynamic> toMap(Product product) {
    Map<String, dynamic> data = {
      "id": product.id,
      "label": product.label,
      "unit": product.unit,
      "unit_price": product.unitPrice,
      "image": product.image,
      "description": product.description,
      "stock": product.stock,
      "category": product.category,
      "vendor": product.vendor
    };

    return data;
  }

  @override
  List<Object?> get props =>
      [id, label, unit, unitPrice, image, description, stock, category, vendor];

  factory Product.empty() => Product(
      id: 1,
      label: "dummy",
      unitPrice: 0.00,
      image: "assets/images/banner.png",
      description: "",
      stock: 0,
      vendor: 0);
}

class ProductCategory {
  final int id;
  final String name;
  final String icon;

  // constructor
  ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
    );
  }

  factory ProductCategory.empty() =>
      ProductCategory(id: -1, icon: "assets/images/app_logo.png", name: "All");

  bool equals(ProductCategory productCategory) {
    return this.id == productCategory.id;
  }
}
