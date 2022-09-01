import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/food.model.dart';
import 'package:greens_veges/utils/routes.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

enum Status {
  ProductsNotLoaded,
  ProductsLoading,
  ProductsLoaded,
  CategoriesNotLoaded,
  CategoriesLoading,
  CategoriesLoaded
}

class ProductProvider with ChangeNotifier {
  Status _productLoadedStatus = Status.ProductsNotLoaded;
  Status _categoryLoadedStatus = Status.CategoriesNotLoaded;

  Status get productLoadedStatus => _productLoadedStatus;
  Status get categoryLoadedStatus => _categoryLoadedStatus;

  // load categories
  Future<Map<String, dynamic>> loadCategories() async {
    Map<String, dynamic> result;

    _categoryLoadedStatus = Status.CategoriesLoading;
    notifyListeners();

    Response response = await get(Uri.parse(AppUrl.listCategories));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      var responseData = json.decode(response.body);
      if (kDebugMode) {
        print(responseData);
      }

      List<ProductCategory> categories = [];

      for (Map<String, dynamic> data in responseData) {
        ProductCategory category = ProductCategory.fromJson(data);

        // Add product to the list
        categories.add(category);
      }

      _categoryLoadedStatus = Status.CategoriesLoaded;
      notifyListeners();

      result = {
        'status': true,
        'message': "Categories loaded",
        'categories': categories
      };
    } else {
      _categoryLoadedStatus = Status.CategoriesNotLoaded;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  // load products
  Future<Map<String, dynamic>> loadProducts() async {
    Map<String, dynamic> result;

    _productLoadedStatus = Status.ProductsLoading;
    notifyListeners();

    Response response = await get(Uri.parse(AppUrl.listProducts));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      var responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print(responseData);
      }

      List<Product> products = [];
      for (Map<String, dynamic> data in responseData) {
        Product product = Product.fromJson(data);

        // Add product to the list
        products.add(product);
      }

      if (kDebugMode) {
        print(products);
      }

      _productLoadedStatus = Status.ProductsLoaded;
      notifyListeners();

      result = {
        'status': true,
        'message': "Successfully Loaded",
        'products': products
      };
    } else {
      _productLoadedStatus = Status.ProductsNotLoaded;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
