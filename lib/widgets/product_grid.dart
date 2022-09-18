// Products card grid view
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/screens/product_detail.dart';

import '../models/product.model.dart';
import 'product_card.dart';

Widget productGrids({required List<Product> products}) {
  if (kDebugMode) {
    print("The number of items");
    print(products.length);
  }
  return GridView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      mainAxisExtent: 225,
    ),
    itemBuilder: (context, index) {
      return Flexible(
        child: FoodCardWidget(
          image: products[index].image,
          name: products[index].label,
          price: products[index].unitPrice,
          onTapCallback: () {
            // Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
            //     arguments: products[index]);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FoodDetailScreen(product: products[index])));
          },
        ),
      );
    },
  );
}
