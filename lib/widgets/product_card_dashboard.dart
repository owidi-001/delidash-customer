import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';

class DashboardFoodCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onTapCallback;
  const DashboardFoodCardWidget(
      {Key? key,
      required this.imagePath,
      required this.name,
      required this.price,
      required this.onTapCallback})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCallback(),
      child: Card(
          color: AppTheme.lightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 2,
                  child: Image.asset(
                    imagePath,
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkColor),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
