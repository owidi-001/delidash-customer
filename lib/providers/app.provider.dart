import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/product.model.dart';

import '../domain/vendor.model.dart';
import '../services/category.service.dart';
import '../services/product.service.dart';
import '../services/vendor.service.dart';
import '../constants/status.dart';

/// Manage state for Users etc
class MealioApplicationProvider with ChangeNotifier {
  List<ProductCategory> categories = [];
  ServiceStatus categoriesStatus = ServiceStatus.initial;

  List<Vendor> vendors = [];
  ServiceStatus vendorsStatus = ServiceStatus.initial;

  List<Product> products = [];
  ServiceStatus productsStatus = ServiceStatus.initial;

  Map<Vendor, List<Product>> vendorProducts = {};

  MealioApplicationProvider() {
    categoriesStatus = ServiceStatus.loading;
    vendorsStatus = ServiceStatus.loading;
    productsStatus = ServiceStatus.loading;
    notifyListeners();

    init();
  }

  //This method is called on splash screen when the app starts
  init() async {
    await _initCategories();
    await _initProducts();
    await _initVendors();
  }

  Future<void> _initCategories() async {
    final res = await ProductCategoryService().fetchCategories();

    if (res["status"]) {
      categories = res["categories"];
      categoriesStatus = ServiceStatus.loadingSuccess;
    } else {
      categoriesStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
  }

  Future<void> _initProducts() async {
    final res = await ProductService().fetchProducts();

    if (res["status"]) {
      products = res["products"];
      productsStatus = ServiceStatus.loadingSuccess;
    } else {
      productsStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
  }

  Future<void> _initVendors() async {
    final res = await VendorService().fetchVendors();

    if (res["status"]) {
      vendors = res["vendors"];

      vendorsStatus = ServiceStatus.loadingSuccess;
    } else {
      vendorsStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
  }

  // Load vendor products
  List<Product> fetchVendorProducts(Vendor vendor) {
    List<Product> results = [];

    for (var product in products) {
      if (vendor.id == product.vendor) {
        results.add(product);
      }
    }

    return results;
  }
}
