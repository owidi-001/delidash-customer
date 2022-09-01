// Products card grid view
import 'package:flutter/material.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/widgets/product_card_dashboard.dart';

import '../models/food.model.dart';

Widget productHorizontalList({required List<Product> products}) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: products.length,
    itemBuilder: (context, index) {
      return DashboardFoodCardWidget(
        imagePath: products[index].image,
        name: products[index].label,
        price: products[index].unit_price,
        onTapCallback: () {
          // Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
          //     arguments: products[index]);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FoodDetailScreen(product: products[index])));
        },
      );
    },
  );
}
