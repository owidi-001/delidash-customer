import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/address.model.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/services/address.service.dart';
import 'package:greens_veges/services/order.service.dart';

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

  List<Address> addresses = [];
  ServiceStatus addressesStatus = ServiceStatus.initial;

  Map<Vendor, List<Product>> vendorProducts = {};

  List<Order> orders = [];
  ServiceStatus orderStatus = ServiceStatus.initial;

  List<OrderItem> orderItems = [];
  ServiceStatus orderItemsStatus = ServiceStatus.initial;


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

    // Get saved address
    await _userAddress();
    // Orders
    await _getOrders();
    await _getOrderItems();
  }

  Future<void> _userAddress() async {
    final res = await AddressService().fetchAddress();

    if (res["status"]) {
      addresses = res["addresses"];
      addressesStatus = ServiceStatus.loadingSuccess;
    } else {
      addressesStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
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

  // Getting orders
  Future<void> _getOrders() async {
    final res = await OrderService().fetchOrders();

    if (res["status"]) {
      orders = res["orders"];

      orderStatus = ServiceStatus.loadingSuccess;
    } else {
      orderStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
  }

  // Getting orders
  Future<void> _getOrderItems() async {
    final res = await OrderService().fetchOrderItems();

    if (res["status"]) {
      orderItems = res["orderItems"];

      orderItemsStatus = ServiceStatus.loadingSuccess;
    } else {
      orderItemsStatus = ServiceStatus.loadingFailure;
    }
    notifyListeners();
  }

  // Categorise order with their items
  List<OrderItem> getOrderItems(Order order) {
    List<OrderItem> results = [];
    for (var item in orderItems) {
      if (item.order == order.id) {
        results.add(item);
      }
    }
    return results;
  }
}
