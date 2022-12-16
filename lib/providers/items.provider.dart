import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/services/app.service.dart';

class ItemsProvider with ChangeNotifier {
  List<OrderItem> _orderItems = [];

  ServiceStatus status = ServiceStatus.initial;

  ItemsProvider() {
    status = ServiceStatus.initial;

    _initItems();
  }

  // mutatos
  List<OrderItem> getItems() {
    return _orderItems;
  }

  void setItems(List<OrderItem> orders) {
    _orderItems = orders;
    notifyListeners();
  }

  // Gets orders or error from the API
  Future<void> _initItems() async {
    // load order items
    final res = await AppService().fetchOrderItems();
    res.when(error: (error) {
      status = ServiceStatus.loadingFailure;
    }, success: (data) {
      if (kDebugMode) {
        print(data);
      }
      setItems(data);
      status = ServiceStatus.loadingSuccess;
    });

    notifyListeners();
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
