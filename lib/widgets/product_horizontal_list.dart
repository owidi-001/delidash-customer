// Products card grid view
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/widgets/product_card.dart';

Widget productHorizontalList({required List<Product> products}) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: products.length,
    itemBuilder: (context, index) {
      return ProductCardWidget(
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
      );
    },
  );
}
