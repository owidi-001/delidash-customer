import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/providers/category.provider.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> _products = [];

  List<Product> get products => _products;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  Map<String, List<Product>> getFoodsCategorically() {
    Map<String, List<Product>> results = {};

    // List<String> categories = ProductCategoryProvider()
    //     .categories
    //     .map((category) => category.name)
    //     .toList();

    List<ProductCategory> categories = ProductCategoryProvider().categories;

    for (ProductCategory category in categories) {
      List<Product> categoryProducts = [];

      for (Product product in products) {
        if (product.category == category.id) {
          categoryProducts.add(product);
        }
      }

      results["$category.name"] = categoryProducts;
    }

    return results;
  }
}
