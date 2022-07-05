import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';

class FoodCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onTapCallback;

  const FoodCard(
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
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: InkWell(
        onTap: () => onTapCallback(),
        child: Card(
            color: AppTheme.lightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                
                children: [
                  Image.asset(
                    imagePath,
                    // width: 120,
                    // height: 120,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                            color: AppTheme.redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      MaterialButton(
                        onPressed: () {
                          // Add to cart
                          // Call added to cart
                        },
                        child: Image.asset(
                          "assets/images/add_icon.png",
                          width: 32,
                          height: 32,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

// Alert when added to cart
void alertAdded() {}
