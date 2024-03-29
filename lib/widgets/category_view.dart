import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/widgets/product_horizontal_list.dart';

import 'category_card.dart';
import 'column_builder.dart';
import 'menu_minimal_view.dart';

// Tabbed category list views
Widget categoryCardListView(List<ItemCategory> categories) {
  var catIds = categories.map((e) => e.id).toList();
  if (!catIds.contains(0)) {
    categories.insert(0, ItemCategory.empty());
  }

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: categories.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: categoryCardView(
            categories[index].icon, categories[index].name, false),
      );
    },
  );
}

// Product per category view
Widget categoryView(Map<String, List<Item>> categoricalFoods) {
  return ColumnBuilder(
    itemCount: categoricalFoods.keys.length,
    itemBuilder: (BuildContext context, int index) {
      String category = categoricalFoods.keys.elementAt(index);

      return Column(
        children: [
          seeAllView(context, category, categoricalFoods[category]),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: productHorizontalList(
                products: categoricalFoods.values.elementAt(index)),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      );
    },
  );
}
