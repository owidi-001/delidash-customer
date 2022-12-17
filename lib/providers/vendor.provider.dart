import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/services/app.service.dart';

class VendorProvider with ChangeNotifier {
  List<Vendor> data = [];
  ServiceStatus status = ServiceStatus.initial;

  VendorProvider() {
    _init();
  }

  Future<void> _init() async {
    final res = await AppService().fetchVendors();

    res.when(error: (error) {
      // if (kDebugMode) {
      //   print(error);
      // }
      status = ServiceStatus.loadingFailure;
    }, success: (data) {
      this.data = data;
      status = ServiceStatus.loadingSuccess;
    });
    notifyListeners();
  }
}
