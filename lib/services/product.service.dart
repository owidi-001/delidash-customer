import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';


class ProductService{


// get all products
  Future<Map<String, dynamic>> fetchProducts() async {
    Map<String, dynamic> result;


    String token = await UserPreferences().getToken();


    final response = await get(Uri.parse(ApiUrl.listProducts),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);

      List<Product> products =
          parsed.map<Product>((json) => Product.fromJson(json)).toList();

      // Update provider to read products

      result = {
        'status': true,
        'message': "Products loaded",
        "products": products
      };

      return result;
    } else {
      
      //   throw Exception('Failed to load products');
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }
}
