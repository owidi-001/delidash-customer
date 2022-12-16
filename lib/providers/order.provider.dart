import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/services/app.service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  List<OrderItem> _orderItems = [];
  ServiceStatus status = ServiceStatus.initial;
  ServiceStatus itemStatus = ServiceStatus.initial;

  OrderProvider() {
    status = ServiceStatus.initial;
    itemStatus = ServiceStatus.initial;

    _initOrders();
    _initItems();
  }

  List<Order> getOrders() {
    return _orders;
  }

  void setOrders(List<Order> orders) {
    _orders = orders;
    notifyListeners();
  }

  // Gets orders or error from the API
  Future<void> _initOrders() async {
    // load orders
    final res = await AppService().fetchOrders();
    res.when(error: (error) {
      status = ServiceStatus.loadingFailure;
    }, success: (data) {
      // if (kDebugMode) {
      //   print(data);
      // }
      setOrders(data);
      status = ServiceStatus.loadingSuccess;
    });

    notifyListeners();
  }

  Future<void> _initItems() async {
    final res = await AppService().fetchOrderItems();
    res.when(error: (error) {
      itemStatus = ServiceStatus.loadingFailure;
      if (kDebugMode) {
        print("Failed to fetch items");
      }
    }, success: (data) {
      _orderItems = data;
      if (kDebugMode) {
        print("Order items loaded");
        print(data);
      }
      itemStatus = ServiceStatus.loadingSuccess;
    });
    notifyListeners();
  }

  // Add order to orders list
  void addOrder(Order order) async {
    var orders = getOrders();

    if (!orders.contains(order)) {
      orders.add(order);
    }
    notifyListeners();
  }

  // Categorise order with their items
  // List<OrderItem> getOrderItems(Order order) {
  //   List<OrderItem> results = [];
  //   for (var item in _orderItems) {
  //     if (item.order == order.id) {
  //       results.add(item);
  //     }
  //   }
  //   return results;
  // }

  List<OrderItem> getOrderItems() {
    return _orderItems;
  }

  void addOrderItems(List<OrderItem> orders) async {
    _orderItems.addAll(orders);

    notifyListeners();
  }

  // refresh
  void refresh() {
    _initItems();
  }
}
