
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';

class ProductProvider with ChangeNotifier {
  late List<Product> _products=[];

  List<Product> get products => _products;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }
}