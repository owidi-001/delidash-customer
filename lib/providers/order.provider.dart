import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/services/app.service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  ServiceStatus status = ServiceStatus.initial;

  OrderProvider() {
    status = ServiceStatus.initial;

    _initOrders();
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

  // Add order to orders list
  void addOrder(Order order) async {
    var orders = getOrders();

    if (!orders.contains(order)) {
      _orders.add(order);
    }
    notifyListeners();
  }

  // refresh
  void refresh() async {
    await _initOrders();
  }
}
