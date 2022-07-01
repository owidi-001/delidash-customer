import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/services/services.dart';
import 'package:greens_veges/widgets/food_card.dart';
import 'package:greens_veges/widgets/vegetable_card.dart';

import '../utils/routes.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool pinned = false;
    bool snap = false;
    bool floating = true;

    var greetings = greetingMessage();

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: CustomScrollView(
        slivers: <Widget>[
          // nav
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  // navbar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          "assets/images/user.png",
                          scale: 3.6,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  greetings,
                                  style: const TextStyle(
                                      color: AppTheme.secondaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "Tabby Tabs",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: const BoxDecoration(
                                color: AppTheme.lightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  CupertinoIcons.location,
                                  color: AppTheme.primaryColor,
                                  size: 16,
                                ),
                                // TODO! Insert user saved address
                                Text(
                                  "My Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  CupertinoIcons.chevron_down,
                                  color: AppTheme.primaryColor,
                                  size: 12,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          // Search bar
          SliverToBoxAdapter(
            child: // search box
                Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: const TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Category",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppTheme.secondaryColor,
                          fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.all(16),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: AppTheme.primaryColor,
                      ),
                    )),
              ),
            ),
          ),
          // hero
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                "assets/images/banner.png",
                scale: 3.6,
              ),
            ),
          ),
          // sub nav
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _seeAllView(context, "Categories"),
            ),
          ),
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),

          // Category menu
          SliverToBoxAdapter(
            child: Row(
              children: [
                _categoriesView("assets/images/fruits.png", "Fruits"),
                _categoriesView("assets/images/vegetables.png", "Vegetables"),
                _categoriesView("assets/images/diary.png", "Diary"),
                _categoriesView("assets/images/meat.png", "Meat")
              ],
            ),
          ),
          // Padding
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _seeAllView(context, "Best Selling"),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          // Card grid for products
          productGrids(),
        ],
      ),
    );
  }

// Returns widget view for see all belonging to best selling
// TODO! Change to list items from server
  Widget _seeAllView(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.vegetablesRoute);
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

// Returns category view card item
// TODO! Same as see all
  Widget _categoriesView(String imagePath, String catName) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.lightColor,
            radius: 32,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                imagePath,
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
      ),
    );
  }

  List<Widget> products = [
    Expanded(
      child: FoodCard(
        imagePath: "assets/images/bell_pepper_red.png",
        name: "Bell Pepper Red",
        price: "1kg, \$4",
        onTapCallback: () {
          // Navigator.pushNamed(context,MyRoutes.vegetableDetailRoute);
        },
      ),
    ),
    Expanded(
      child: VegetableCardWidget(
          imagePath: "assets/images/lamb_meat.png",
          name: "Bell Pepper Red",
          price: "1kg, \$4",
          onTapCallback: () {}),
    ),
    Expanded(
      child: VegetableCardWidget(
        imagePath: "assets/images/carrots.png",
        name: "Carrots",
        price: "1.5kg, \$2",
        onTapCallback: () {
          // Navigator.pushNamed(context, MyRoutes.vegetableDetailRoute);
        },
      ),
    ),
    Expanded(
      child: VegetableCardWidget(
          imagePath: "assets/images/butternut.png",
          name: "Butter Nut",
          price: "1kg, \$4",
          onTapCallback: () {}),
    ),
    Expanded(
      child: VegetableCardWidget(
        imagePath: "assets/images/carrots.png",
        name: "Carrots",
        price: "1.5kg, \$2",
        onTapCallback: () {
          // Navigator.pushNamed(context, MyRoutes.vegetableDetailRoute);
        },
      ),
    ),
    Expanded(
      child: VegetableCardWidget(
          imagePath: "assets/images/butternut.png",
          name: "Butter Nut",
          price: "1kg, \$4",
          onTapCallback: () {}),
    )
  ];

  // Return product grids
  Widget productGrids() {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: products,
    );
  }
}
