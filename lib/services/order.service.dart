import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class OrderService {
  // Fetch orders
  Future<Map<String, dynamic>> fetchOrders() async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.orders),
        headers: {"Authorization": "Token $token"});

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      // Convert the list to Address instance
      List<Order> orders =
          parsed.map<Order>((json) => Order.fromJson(json)).toList();

      if (kDebugMode) {
        print("Post orders conversion");
        print(orders);
      }

      result = {
        "status": true,
        "message": "User orders loaded",
        "orders": orders
      };
    } else {
      if (kDebugMode) {
        print("Post orders conversion failed");
      }

      // throw Exception('Failed to load orders');
      result = {
        "status": false,
        "message": "Orders not loaded",
      };
    }
    return result;
  }

  // Fetch order items
  Future<Map<String, dynamic>> fetchOrderItems() async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.orderItems), headers: {
      "Authorization": "Token $token",
    });

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      // Convert the list to Address instance
      List<OrderItem> orderItems =
          parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();

      // Update provider to read categories
      result = {
        "status": true,
        "message": "Order Items loaded",
        "orderItems": orderItems
      };
    } else {
      // throw Exception('Failed to load address');
      result = {
        "status": false,
        "message": "Items not loaded",
      };
    }
    return result;
  }
}
