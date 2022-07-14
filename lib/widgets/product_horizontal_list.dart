// Products card grid view
import 'package:flutter/material.dart';

import '../models/food.model.dart';
import 'product_card.dart';

Widget productHorizontalList({required List<Food> foods}) {
  
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: foods.length,
    itemBuilder: (context, index) {
      return Flexible(
        child: FoodCardWidget(
          imagePath: foods[index].imagePath,
          name: foods[index].name,
          price: foods[index].price,
          onTapCallback: () {
            // Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
            //     arguments: foods[index]);
          },
        ),
      );
    },
  );
}
