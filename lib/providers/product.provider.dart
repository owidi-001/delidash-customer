import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/services/app.service.dart';

class ProductProvider with ChangeNotifier {
  ServiceStatus status = ServiceStatus.initial;

  List<Item> data = [];

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
  List<Item> fetchVendorProducts(Vendor vendor) {
    List<Item> results = [];

    for (var product in data) {
      if (product.vendor == vendor.id) {
        results.add(product);
      }
    }
    return results;
  }

  List<Item> fetchCategoryProducts(ItemCategory category) {
    List<Item> results = [];

    for (var product in data) {
      if (category.id == product.category.id) {
        results.add(product);
      }
    }

    return results;
  }

  Item? findByName(String name) {
    for (var product in data) {
      if (product.name == name) {
        return product;
      }
    }
    return null;
  }
}
