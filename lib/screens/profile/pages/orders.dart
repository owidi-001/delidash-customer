import 'package:greens_veges/providers/items.provider.dart';
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
    
    var orders = Provider.of<ItemsProvider>(context);
    var items = orders.getItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // List Item
          return OrderCard(
            item: items[index],
          );
        },
      ),
    );
  }
}
