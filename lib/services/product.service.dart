import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/providers/product.provider.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/utility/routes.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

enum Status {
  productsNotLoaded,
  productsLoading,
  productsLoaded,
  categoriesNotLoaded,
  categoriesLoading,
  categoriesLoaded
}

class ProductService with ChangeNotifier {
  Status _productLoadedStatus = Status.productsNotLoaded;
  Status _categoriesLoadedStatus = Status.categoriesNotLoaded;

// get all products
  Future<List<Product>> fetchProduct() async {
    _productLoadedStatus = Status.productsLoading;
    notifyListeners();

    final response = await get(Uri.parse(AppUrl.listProducts));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      var products =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();

      if (kDebugMode) {
        print("The loaded Products");
      }
      ProductProvider().setProducts(products);

      _productLoadedStatus = Status.productsLoaded;
      notifyListeners();

      return products;
    } else {
      _productLoadedStatus = Status.productsNotLoaded;
      notifyListeners();
      throw Exception('Failed to load foods');
    }
  }

// get all products
  Future<List<ProductCategory>> fetchProductCategories() async {
    
    final response = await get(Uri.parse(AppUrl.listCategories),headers: {"token":UserProvider().user.token});

    if (kDebugMode) {
      print("The respose status: ${response.statusCode}");
      print("The respose status: ${response.body}");
    }

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      var categories = parsed
          .map<ProductCategory>((json) => ProductCategory.fromJson(json))
          .toList();

      ProductProvider().setCategories(categories);

      if (kDebugMode) {
        print("The loaded categories");
      }
      _categoriesLoadedStatus = Status.categoriesLoaded;
      notifyListeners();

      return categories;
    } else {
      _categoriesLoadedStatus = Status.categoriesNotLoaded;
      notifyListeners();

      throw Exception('Failed to load categories');
    }
  }
}
