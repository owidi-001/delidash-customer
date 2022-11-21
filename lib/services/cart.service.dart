import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/exception.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/http_client.dart';

import 'dart:async';

class CartService {
  // Future<HttpResult<Payment>> makePayment(
  //         {required Map<String, String> data}) =>
  //     HttpClient.post2<Payment>(
  //       ApiUrl.payment,
  //       data: data,
  //       der: (data) => Payment.fromJson(data),
  //     );

  Future<HttpResult<List<OrderItem>>> saveOrder(
      {required Map<String, dynamic> apiBody}) {
    // if (kDebugMode) {
    //   print("Service Called $apiBody ");
    // }
    return HttpClient.post2<List<OrderItem>>(ApiUrl.orders,
        data: apiBody,
        der: (data) =>
            data.map<OrderItem>((json) => OrderItem.fromJson(json)).toList());
  }
}
