import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';

import '../models/product.model.dart';
import '../utils/routes.dart';

class FoodDetailScreen extends StatefulWidget {
  
  final Product product;
  const FoodDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 140.0))),
              child: Column(children: [
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/back_icon.png",
                          width: 44,
                          height: 44,
                        ),
                      ),
                      Image.asset(
                        "assets/images/search_icon.png",
                        width: 44,
                        height: 44,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.6,
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.label,
                          style: const TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  if (itemCount > 0) itemCount--;
                                });
                              }),
                              child: Image.asset(
                                "assets/images/remove_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "$itemCount",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkColor),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  itemCount++;
                                });
                              },
                              child: Image.asset(
                                "assets/images/add_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("\$ ${widget.product.unitPrice}/Kg",
                      style: const TextStyle(
                          color: AppTheme.redColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                        color: AppTheme.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      _itemKeyPointsView(
                          "assets/images/organic.png", "100%", "Organic"),
                      const SizedBox(
                        width: 8,
                      ),
                      _itemKeyPointsView("assets/images/expiration.png",
                          "1 Year", "Expiration")
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      _itemKeyPointsView(
                          "assets/images/reviews.png", "4.8", "Reviews"),
                      const SizedBox(
                        width: 8,
                      ),
                      _itemKeyPointsView(
                          "assets/images/calories.png", "80 kcal", "100 Gram")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.cartRoute);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          shape: const StadiumBorder(),
                          backgroundColor: AppTheme.primaryColor,
                        ),
                        child: const Text("Add to cart")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemKeyPointsView(String imagePath, String title, String desc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: const Color(0xffF1F1F5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 14, color: AppTheme.secondaryColor)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
