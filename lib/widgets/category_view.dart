import 'package:flutter/material.dart';
import 'package:greens_veges/widgets/product_horizontal_list.dart';

import '../models/food.model.dart';
import 'category_card.dart';
import 'menu_minimal_view.dart';

// Product per category view
Widget categoryView(Map<FoodCategory, List<Food>> categoricalFoods) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: categoricalFoods.keys.length,
    itemBuilder: (BuildContext context, int index) {
      FoodCategory category = categoricalFoods.keys.elementAt(index);
      String categoryLabel = category.label;
      return Column(
        children: [
          seeAllView(context, categoryLabel),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: productHorizontalList(
                foods: categoricalFoods.values.elementAt(index)),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    },
  );
}

// Tabbed category list views
Widget categoryListView(List<FoodCategory> categories) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: categories.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: categoryCardView(
            categories[index].imagePath, categories[index].label),
      );
    },
  );
}
