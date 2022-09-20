
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> _products=[];
  late List<ProductCategory> _categories=[];

  List<Product> get products => _products;
  List<ProductCategory> get categories => _categories;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  void setCategories(categories) {
    _categories = categories;
    notifyListeners();
  }
}