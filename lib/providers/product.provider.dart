import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/services/app.service.dart';

class ProductProvider with ChangeNotifier {


  List<Product> data = [];
  ServiceStatus status = ServiceStatus.initial;

  ProductProvider() {
    status = ServiceStatus.initial;
    _init();
  }

  Future<void> _init() async {
    final res = await AppService().fetchProducts();

    res.when(error: (error) {
      status = ServiceStatus.loadingFailure;
    }, success: (data) {
      this.data = data;
      status = ServiceStatus.loadingSuccess;
    });

    notifyListeners();
  }

  // Load vendor products
  List<Product> fetchVendorProducts(Vendor vendor) {
    List<Product> results = [];

    for (var product in data) {
      if (vendor.id == product.vendor) {
        results.add(product);
      }
    }

    return results;
  }
}
