import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/payment.model.dart';
import 'package:greens_veges/services/payment.service.dart';

class PaymentProvider with ChangeNotifier {
  PaymentProvider._();
  static final instance = PaymentProvider._();

  PaymentStatus status = PaymentStatus.unknown;

  Payment payment = Payment.empty();
  void paymentStatusChanged(PaymentStatus status) {
    this.status = status;
    notifyListeners();
  }

  //  Update payment as per the response
  void savePayment({required Payment payment, required PaymentStatus status}) {
    this.payment = payment;
    this.status = status;
    notifyListeners();
  }

  Future<void> _init() async {
    final res = await PaymentService().makePayment(data: {});

    res.when(
        error: (error) {
          // // An error occured
          // if (kDebugMode) {
          //   print(error.message);
          // }
          status = PaymentStatus.failed;
        },
        success: (data) {
          
        });

    notifyListeners();
  }
}
