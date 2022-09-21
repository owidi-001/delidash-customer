import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/providers/category.provider.dart';
import 'package:greens_veges/utility/routes.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

enum Status { categoriesNotLoaded, categoriesLoading, categoriesLoaded }

class ProductCategoryService with ChangeNotifier {
  Status _categoriesLoadedStatus = Status.categoriesNotLoaded;

// get all categories
  Future<List<ProductCategory>> fetchProductCategories() async {
    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(AppUrl.listCategories),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {

      List parsed = jsonDecode(response.body);

      // Convert the list to ProductCategory instance
      List<ProductCategory> categories = parsed
          .map<ProductCategory>((json) => ProductCategory.fromJson(json))
          .toList();

      ProductCategoryProvider().setCategories(categories);

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
