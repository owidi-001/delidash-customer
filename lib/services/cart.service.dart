import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greens_veges/routes/app_router.dart';

import 'dart:async';

import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

class CartService {
  // Future<HttpResult<Payment>> makePayment(
  //         {required Map<String, String> data}) =>
  //     HttpClient.post2<Payment>(
  //       ApiUrl.payment,
  //       data: data,
  //       der: (data) => Payment.fromJson(data),
  //     );

  Future<Map<String, dynamic>> saveOrder(Map<String, dynamic> payload) async {
    String token = await UserPreferences().getToken();

    Map<String, dynamic> result;

    Response response = await post(Uri.parse(ApiUrl.orders),
        body: json.encode(payload),
        headers: {
          "Authorization": "Token $token",
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print(response.statusCode);
      }

      result = {
        'status': true,
        'message': 'Order successfully placed'
      };
    } else {
      result = {
        'status': false,
        'message':
            'Failed to save order ${response.statusCode} ${response.body}'
      };
    }

    return result;
  }
}
