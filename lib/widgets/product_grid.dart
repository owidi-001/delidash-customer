// Products card grid view
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/food.model.dart';
import 'product_card.dart';

Widget productGrids({required List<Food> foods}) {
  if (kDebugMode) {
    print("The number of items");
    print(foods.length);
  }
  return GridView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: foods.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      mainAxisExtent: 225,
    ),
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
