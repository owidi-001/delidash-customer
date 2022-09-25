import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class ProductCategoryService {
  // Fetch categories
  Future<Map<String, dynamic>> fetchCategories() async {
    Map<String, dynamic> result;
    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.listCategories),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      // Convert the list to ProductCategory instance
      List<ProductCategory> categories = parsed
          .map<ProductCategory>((json) => ProductCategory.fromJson(json))
          .toList();

      // Update provider to read categories
      result = {
        "status": true,
        "message": "Categories loaded",
        "categories": categories
      };
    } else {
      // throw Exception('Failed to load categories');
      result = {
        "status": false,
        "message": "Categories not loaded",
      };
    }
    return result;
  }
}
