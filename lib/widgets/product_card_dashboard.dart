import 'package:flutter/material.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/domain/product.model.dart';

class DashboardFoodCardWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onTapCallback;

  const DashboardFoodCardWidget(
      {Key? key, required this.product, required this.onTapCallback})
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
                  // child: Image.network(
                  //   "$baseURL${product.image}",
                  //   width: 120,
                  //   height: 120,
                  // ),
                  child: Image.asset(product.image,
                    width: 120,
                    height: 120,),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    product.label,
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
