// Products card grid view
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/screens/product_detail.dart';

import 'product_card.dart';

Widget productGrids(List<Product> products) {
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
        child: ProductCardWidget(
          product: products[index],
          onTapCallback: () {
            // Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
            //     arguments: products[index]);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: products[index])));
          },
        ),
      );
    },
  );
}
