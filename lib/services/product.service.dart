import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/product.model.dart';
import 'package:greens_veges/utils/routes.dart';
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

class ProductProvider with ChangeNotifier {

  List<Product?> _products=[];
  List<ProductCategory?> _categories=[];
  Map<String, List<Product>>
      _productCategories={}; // Products list per category

  List<Product?> get products => _products;
  List<ProductCategory?> get categories => _categories;
  Map<String, List<Product>> get productCategories => _productCategories;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  void setCategories(List<ProductCategory> categories) {
    _categories = categories;
    notifyListeners();
  }

  // Not neccessary
  void setProductCategories(Map<String, List<Product>> productCategories) {
    _productCategories = productCategories;
    notifyListeners();
  }

  Status _productLoadedStatus = Status.productsNotLoaded;
  Status _categoryLoadedStatus = Status.categoriesNotLoaded;

  Status get productLoadedStatus => _productLoadedStatus;
  Status get categoryLoadedStatus => _categoryLoadedStatus;

  // load categories
  Future<Map<String, dynamic>> loadCategories() async {
    Map<String, dynamic> result;

    _categoryLoadedStatus = Status.categoriesLoading;
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

      _categoryLoadedStatus = Status.categoriesLoaded;
      notifyListeners();

      result = {
        'status': true,
        'message': "Categories loaded",
        'categories': categories
      };
    } else {
      _categoryLoadedStatus = Status.categoriesNotLoaded;
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

    _productLoadedStatus = Status.productsLoading;
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

      _productLoadedStatus = Status.productsLoaded;
      notifyListeners();

      result = {
        'status': true,
        'message': "Products Loaded",
        'products': products
      };
    } else {
      _productLoadedStatus = Status.productsNotLoaded;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, List<Product>>> loadProductCategorically() async {
    Map<String, List<Product>> results = {};

    for (var category in categories) {
      List<Product> products = [];

      for (var product in products) {
        if (product.category == category!.id) {
          products.add(product);
        }
      }
      results[category!.name] = products;
    }

    // validate results
    for (var item in results.keys) {
      if (results[item]!.isEmpty) {
        results.remove(item);
      }
    }

    return results;
  }
}

// get all products
Future<List<Product>> fetchProduct() async {
  final response = await get(Uri.parse(AppUrl.listProducts));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    var products =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();

    if (kDebugMode) {
      print("The loaded Products");
    }
    for (var product in products) {
      if (kDebugMode) {
        print(product);
      }
    }
    return products;
  } else {
    throw Exception('Failed to load foods');
  }
}
