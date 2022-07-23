import 'package:flutter/material.dart';
import 'package:greens_veges/widgets/product_horizontal_list.dart';

import '../models/food.model.dart';
import 'category_card.dart';
import 'column_builder.dart';
import 'menu_minimal_view.dart';

// Tabbed category list views
Widget categoryCardListView(List<FoodCategory> categories) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
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


// Product per category view
Widget categoryView(Map<FoodCategory, List<Food>> categoricalFoods) {
  return ColumnBuilder(
    itemCount: categoricalFoods.keys.length,
    itemBuilder: (BuildContext context, int index) {
      FoodCategory category = categoricalFoods.keys.elementAt(index);
      String categoryLabel = category.label;
      return Column(
        children: [
          seeAllView(context, categoryLabel,getFoodsOfCategory(category)),
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