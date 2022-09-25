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

// Widget browsableMenu() {
//   List<String> browsables = ["Products", "Category", "Vendor"];
//   String chosenValue = browsables[0];
//   return SliverToBoxAdapter(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           const Text(
//             "Browse Products",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             decoration: const BoxDecoration(
//                 color: AppTheme.lightColor,
//                 borderRadius: BorderRadius.all(Radius.circular(24))),
//             child: DropdownButton<String>(
//                 focusColor: AppTheme.whiteColor,
//                 value: chosenValue,
//                 style: const TextStyle(color: Colors.white),
//                 iconEnabledColor: AppTheme.darkColor,
//                 items: browsables.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: const TextStyle(color: AppTheme.darkColor),
//                     ),
//                   );
//                 }).toList(),
//                 hint: Text(
//                   browsables[0],
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 onChanged: (String? newValue) {
//                   chosenValue = newValue!;
//                 }),
//           ),
//         ],
//       ),
//     ),
//   );
// }
