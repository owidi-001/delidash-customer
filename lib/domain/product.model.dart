class Product {
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
