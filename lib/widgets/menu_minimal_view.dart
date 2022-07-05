// Returns widget view for see all belonging to best selling
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../utils/routes.dart';

Widget seeAllView(BuildContext context, String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, MyRoutes.foodListRoute);
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
