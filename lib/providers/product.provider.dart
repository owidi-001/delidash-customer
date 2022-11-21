import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/services/app.service.dart';

class ProductProvider with ChangeNotifier {
  ServiceStatus status = ServiceStatus.initial;

  List<Product> data = [];

  ProductProvider() {
    status = ServiceStatus.initial;
    _init();
  }

  void statusChanged(ServiceStatus status) {
    this.status = status;
    notifyListeners();
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

  List<Product> fetchCategoryProducts(ProductCategory category) {
    List<Product> results = [];

    for (var product in data) {
      if (category.id == product.category) {
        results.add(product);
      }
    }

    return results;
  }

  Product? findByName(String name) {
    for (var product in data) {
      if (product.label == name) {
        return product;
      }
    }
    return null;
  }
}
