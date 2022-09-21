import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/providers/product.provider.dart';
import 'package:greens_veges/utility/routes.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

enum Status {
  productsNotLoaded,
  productsLoading,
  productsLoaded,
}

class ProductService with ChangeNotifier {
  Status _productLoadedStatus = Status.productsNotLoaded;

// get all products
  Future<List<Product>> fetchProduct() async {
    _productLoadedStatus = Status.productsLoading;
    notifyListeners();

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(AppUrl.listProducts),
        headers: {"Authorization": "Token $token"});

    if (kDebugMode) {
      print("The Products load response status is ${response.statusCode} ");
    }

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      List<Product> products =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();

      if (kDebugMode) {
        print("The loaded Products $products");
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
}
