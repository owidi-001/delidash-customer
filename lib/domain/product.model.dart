class Product {
  final int id;
  final String label;
  final double unitPrice;
  final String image;
  final String description;
  final int quantity;
  final int? category;
  final int vendor;

  // constructor
  Product(
      {required this.id,
      required this.label,
      required this.unitPrice,
      required this.image,
      required this.description,
      required this.quantity,
      this.category,
      required this.vendor});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        label: json["label"],
        unitPrice: double.parse(json["unit_price"]),
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
}