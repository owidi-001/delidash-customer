import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class CartService {
  static String? paymentNumber;

  // Save cart and signal payment
  Future<Map<String, dynamic>> saveCart(
      Location location,
      List<CartItemModel> items,
      double total,
      String paymentPhoneNumber) async {
    String token = await UserPreferences().getToken();

    // Initialize objects to parse
    Map<String, dynamic> apiBodyData = {
      "location": Location.toMap(location),
      "items": items.map((e) => CartItemModel.toMap(e)).toList(),
      "total": total,
      "phone": paymentPhoneNumber
    };
    paymentNumber = paymentPhoneNumber;

    return await post(Uri.parse(ApiUrl.orders),
        body: json.encode(apiBodyData),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Token $token"
        }).then(onValue).catchError(onError);
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      Order order = Order.fromJson(responseData);

      // Update order provider to read order
      MealioApplicationProvider().addOrder(order);

      // Trigger payment
      String token = await UserPreferences().getToken();

      Map<String, dynamic> apiBodyData = {
        "phone": paymentNumber
      }; // Find a way of adding phone number

      Response response = await post(Uri.parse(ApiUrl.orders),
          body: apiBodyData, headers: {"Authorization": "Token $token"});

      if (response.statusCode == 201) {
        result = {
          'status': true,
          'message': "Payment Successful, order saved",
          'data': order
        };
      } else {
        result = {
          'status': false,
          'message': json.decode(response.body)['error']
        };
      }
    } else {
      if (kDebugMode) {
        print("The response status is ${response.statusCode}");
      }
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
