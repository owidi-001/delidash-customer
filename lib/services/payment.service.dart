import 'package:flutter/foundation.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class PaymentService {
  // Pay
   Future<Map<String, dynamic>> makePayment(
      String token,String phone, double amount) async {

    final Map<String, dynamic> apiBodyData = {
      'token': token,
      'phone': phone,
      'amount': amount
    };

    return await post(Uri.parse(ApiUrl.payment),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // Save order

      result = {
        'status': true,
        'message': 'Payment completed',
        'data': "code"
      };
    } else {
      result = {
        'status': false,
        'message': 'Payment failed',
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
