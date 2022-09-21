import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';

class ProductCategoryProvider with ChangeNotifier {
  late List<ProductCategory> _categories=[];

  List<ProductCategory> get categories => _categories;

  void setCategories(categories) {
    _categories = categories;
    notifyListeners();
  }
}