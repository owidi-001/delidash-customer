// Products card grid view
import 'package:flutter/material.dart';
import 'package:greens_veges/utils/routes.dart';
import 'package:greens_veges/widgets/product_card_dashboard.dart';

import '../models/food.model.dart';

Widget productHorizontalList({required List<Food> foods}) {
  
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: foods.length,
    itemBuilder: (context, index) {
      return DashboardFoodCardWidget(
              imagePath: foods[index].imagePath,
              name: foods[index].name,
              price: foods[index].price,
              onTapCallback: () {
                Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
                    arguments: foods[index]);
              },
            );
    },
  );
}
