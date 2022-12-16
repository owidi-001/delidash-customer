import 'package:flutter/material.dart';
import 'package:greens_veges/domain/order.model.dart';

class OrderDetail extends StatelessWidget {
  final OrderItem item;
  const OrderDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Detail"),
      ),
      body: Container(),
    );
  }
}
