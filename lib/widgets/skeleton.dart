import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  const Skeleton({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: AppTheme.lightColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
    );
  }
}
