import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/skeleton.dart';

Widget categorySkeletonLoader() {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: AppTheme.lightColor,
        radius: 32,
        child: Skeleton(height: 32,width: 32,)
      ),
      const SizedBox(
        height: 8,
      ),
      Skeleton(height: 20,width: 80,)
    ],
  );
}
