import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class CartService {
  // Save cart and signal payment
  Future<Map<String, dynamic>> saveCart() async {
    String token = await UserPreferences().getToken();

    // Initialize objects to parse
    Location location = LocationProvider().location;
    List<CartItemModel> items = CartProvider().items;

    Map<String, dynamic> apiBodyData = {"location": location, "items": items};

    return await post(Uri.parse(ApiUrl.orders),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json',"Authorization": "Token $token"})
        .then(onValue)
        .catchError(onError);
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      Order order = Order.fromJson(responseData);

      // Update order provider to read order
      MealioApplicationProvider().orders.add(order);

      result = {'status': true, 'message': 'Successfully Saved', 'data': order};
    } else {
      result = {
        'status': false,
        'message': 'Response not ok',
        'data': responseData
      };
    }
    return result;
  }

  static onError(error) {
    if (kDebugMode) {
      print('the error is ${error.detail}');
    }
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
