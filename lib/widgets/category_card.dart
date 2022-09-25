import 'package:flutter/material.dart';
import 'package:greens_veges/routes/app_router.dart';

import '../theme/app_theme.dart';

Widget categoryCardView(String imagePath, String catName) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: AppTheme.lightColor,
        radius: 32,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          // child: Image.asset(
          //   imagePath,
          //   scale: 4.0,
          // ),
          child: Image.network(
            "$baseURL$imagePath",
            scale: 4.0,
          ),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        catName,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.darkColor),
      )
    ],
  );
}
