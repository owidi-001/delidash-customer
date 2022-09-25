// Returns widget view for see all belonging to best selling
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/routes/app_router.dart';

import '../theme/app_theme.dart';

Widget seeAllView(BuildContext context, String name, List<Product>? products) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoute.productList);
          // Navigator.pushNamed(context, FoodListScreen(products:products));
        },
        child: const Text(
          "See All",
          style: TextStyle(
              fontSize: 14,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
