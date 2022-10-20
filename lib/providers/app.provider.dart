import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/domain/product.model.dart';

import '../domain/vendor.model.dart';
import '../services/app.service.dart';
import '../constants/status.dart';

/// Manage state for Users etc
class MealioApplicationProvider with ChangeNotifier {
  List<Product> products = [];
  ServiceStatus productsStatus = ServiceStatus.initial;

  List<ProductCategory> categories = [];
  ServiceStatus categoriesStatus = ServiceStatus.initial;

  List<Vendor> vendors = [];
  ServiceStatus vendorsStatus = ServiceStatus.initial;

  List<Order> orders = [];
  ServiceStatus orderStatus = ServiceStatus.initial;

  List<OrderItem> orderItems = [];
  ServiceStatus orderItemsStatus = ServiceStatus.initial;

  // Vendor specific products
  Map<Vendor, List<Product>> vendorProducts = {};

  // Category specific products
  Map<Vendor, List<Product>> categoryProducts = {};

  /// TODO! update this

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

    // Orders
    await _getOrders();
    await _getOrderItems();
  }

  Future<void> _initCategories() async {
    final res = await AppService().fetchCategories();

    res.when(error: (error) {
      /// pass
      categoriesStatus = ServiceStatus.loadingFailure;
    }, success: (data) {
      categories = data;
      categoriesStatus = ServiceStatus.loadingSuccess;
    });
    notifyListeners();
  }

  Future<void> _initProducts() async {
    final res = await AppService().fetchProducts();

    res.when(error: (error) {
      productsStatus = ServiceStatus.loadingFailure;
    }, success: (data) {
      products = data;
      productsStatus = ServiceStatus.loadingSuccess;
    });

    notifyListeners();
  }

  Future<void> _initVendors() async {
    final res = await AppService().fetchVendors();

    res.when(error: (error) {
      if (kDebugMode) {
        print(error);
      }
      vendorsStatus = ServiceStatus.loadingFailure;
    }, success: (data) {
      vendors = data;
      vendorsStatus = ServiceStatus.loadingSuccess;
    });
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

  // load user orders
  Future<void> _getOrders() async {
    final res = await AppService().fetchOrders();
    res.when(error: (error) {
      orderStatus = ServiceStatus.loadingFailure;
    }, success: (data) {
      orders = data;
      orderStatus = ServiceStatus.loadingSuccess;
    });
    notifyListeners();
  }

// Add order to orders list
  void addOrder(Order order) async {
    if (!orders.contains(order)) {
      orders.add(order);
    }
    notifyListeners();
  }

  // Getting orders
  Future<void> _getOrderItems() async {
    final res = await AppService().fetchOrderItems();
    res.when(error: (error) {
      orderItemsStatus = ServiceStatus.loadingFailure;
    }, success: (data) {
      orderItems = data;
      orderItemsStatus = ServiceStatus.loadingSuccess;
    });
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
