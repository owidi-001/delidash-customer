import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/providers/cart.provider.dart';
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

  // Save order / checkout => Order needs to be saved before the items since items use order ID
  Future<Map<String, dynamic>> saveOrder(Location location) async {
    Map<String, dynamic> result;

    Response response = await post(
      Uri.parse(ApiUrl.orders),
      body: Location.toMap(location),
    );

    if (kDebugMode) {
      print("The response received is $response");
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      Order order = Order.fromJson(responseData);

      List<OrderItem> items = [];
      for (var item in CartProvider().items) {
        items.add(OrderItem(
            order: order.id, product: item.product, quantity: item.quantity));
      }
      // Save order items
      saveOrderItems(items);

      result = {
        'status': true,
        'message': "Order placed successfuly",
        'data': order
      };
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  // Save order items
  Future<Map<String, dynamic>> saveOrderItems(List<OrderItem> items) async {
    Map<String, dynamic> result = {
      "status": true,
      "message": "All items posted"
    };

    for (var item in items) {
      // Save every order item
      Response response = await post(
        Uri.parse(ApiUrl.orderItems),
        body: OrderItem.toMap(item),
      );

      if (kDebugMode) {
        print("The response received is $response");
      }
    }

    return result;
  }
}
