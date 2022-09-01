
class Product {
  final int id;
  final String label;
  final double unit_price;
  final String image;
  final String description;
  final int quantity;
  final String category; // Change to return category name
  final String vendor; // Change to return vendor email

  // constructor
  Product(
      {required this.id,
      required this.label,
      required this.unit_price,
      required this.image,
      required this.description,
      required this.quantity,
      required this.category,
      required this.vendor});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        label: json["name"],
        unit_price: json["unit_price"],
        image: json["image"],
        description: json["description"],
        quantity: json["quantity"],
        category: json["category"],
        vendor: json["vendor"]);
  }
}


class ProductCategory {
  final int id;
  final String name;
  final String icon;

  // constructor
  ProductCategory(
      {required this.id,
      required this.name,
      required this.icon,
      });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
        id: json["id"],
        name: json["name"],
        icon: json["image"],
        );
  }
}