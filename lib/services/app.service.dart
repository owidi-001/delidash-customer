import 'package:greens_veges/domain/exception.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/http_client.dart';

import 'dart:async';

class AppService {
  // Fetch products
  Future<HttpResult<List<Item>>> fetchProducts() => HttpClient.get2<List<Item>>(
      ApiUrl.listProducts,
      der: (data) => data.map<Item>((json) => Item.fromJson(json)).toList());

  // Fetch product categories
  Future<HttpResult<List<ItemCategory>>> fetchCategories() =>
      HttpClient.get2<List<ItemCategory>>(ApiUrl.listCategories,
          der: (data) => data
              .map<ItemCategory>((json) => ItemCategory.fromJson(json))
              .toList());

  // Fetch vendors
  Future<HttpResult<List<Vendor>>> fetchVendors() =>
      HttpClient.get2<List<Vendor>>(ApiUrl.listVendors,
          der: (data) =>
              data.map<Vendor>((json) => Vendor.fromJson(json)).toList());

  // Fetch orders
  // Future<HttpResult<List<Order>>> fetchOrders() => HttpClient.get2<List<Order>>(
  //       ApiUrl.orders,
  //       der: (data) => data.map<Order>((json) => Order.fromJson(json)).toList(),
  //     );

  // Fetch order items
  Future<HttpResult<List<Order>>> fetchOrders() => HttpClient.get2<List<Order>>(
      ApiUrl.orders,
      der: (data) => data.map<Order>((json) => Order.fromJson(json)).toList());
}
