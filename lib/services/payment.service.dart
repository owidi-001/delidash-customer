import 'package:greens_veges/domain/exception.dart';
import 'package:greens_veges/domain/payment.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/http_client.dart';

import 'dart:async';

class PaymentService {
  // Pay
  Future<HttpResult<Payment>> makePayment(
          {required Map<String, String> data}) =>
      HttpClient.post2<Payment>(
        ApiUrl.payment,
        data: data,
        der: (data) => Payment.fromJson(data),
      );
}
