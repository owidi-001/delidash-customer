import 'package:greens_veges/providers/order.provider.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/order_card_horizontal.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);
    var orders = orderProvider.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            orderProvider.refresh();
          });
        },
        // onRefresh: orders.refresh(),
        child: ListView.builder(
          itemCount: orders.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // List Item
            return OrderCard(
              order: orders[index],
            );
          },
        ),
      ),
    );
  }
}
