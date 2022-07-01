import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/services/services.dart';
import '../utils/routes.dart';
import '../widgets/vegetable_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var greetings = greetingMessage();
    if (kDebugMode) {
      print("Greetings message test $greetings");
    }
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 36,
          ),
          // nav
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
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
                          borderRadius: BorderRadius.all(Radius.circular(24))),
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
          ),
          const SizedBox(
            height: 16,
          ),
          // Search
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
              )),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   //  TODO! Change to custom styled card
          //   child: Image.asset(
          //     "assets/images/banner.png",
          //     scale: 4.0,
          //   ),
          // ),
          // hero
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/banner.png",
              scale: 4.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // TODO! Loop for categories from best selling to product types in list view
                // Use The seeAllView to manage the spaced nav
                _seeAllView(context, "Categories"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    _categoriesView("assets/images/fruits.png", "Fruits"),
                    _categoriesView(
                        "assets/images/vegetables.png", "Vegetables"),
                    _categoriesView("assets/images/diary.png", "Diary"),
                    _categoriesView("assets/images/meat.png", "Meat")
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                _seeAllView(context, "Best Selling"),
                const SizedBox(
                  height: 24,
                ),
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  // maxCrossAxisExtent: 2,
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      child: VegetableCardWidget(
                        imagePath: "assets/images/bell_pepper_red.png",
                        name: "Bell Pepper Red",
                        price: "1kg, \$4",
                        onTapCallback: () {
                          Navigator.pushNamed(
                              context, MyRoutes.vegetableDetailRoute);
                        },
                      ),
                    ),
                    Container(
                      child: VegetableCardWidget(
                          imagePath: "assets/images/lamb_meat.png",
                          name: "Bell Pepper Red",
                          price: "1kg, \$4",
                          onTapCallback: () {}),
                    ),
                    Container(
                      child: VegetableCardWidget(
                        imagePath: "assets/images/carrots.png",
                        name: "Carrots",
                        price: "1.5kg, \$2",
                        onTapCallback: () {
                          Navigator.pushNamed(
                              context, MyRoutes.vegetableDetailRoute);
                        },
                      ),
                    ),
                    Container(
                      child: VegetableCardWidget(
                          imagePath: "assets/images/butternut.png",
                          name: "Butter Nut",
                          price: "1kg, \$4",
                          onTapCallback: () {}),
                    ),
                    Container(
                      child: VegetableCardWidget(
                        imagePath: "assets/images/carrots.png",
                        name: "Carrots",
                        price: "1.5kg, \$2",
                        onTapCallback: () {
                          Navigator.pushNamed(
                              context, MyRoutes.vegetableDetailRoute);
                        },
                      ),
                    ),
                    Container(
                      child: VegetableCardWidget(
                          imagePath: "assets/images/butternut.png",
                          name: "Butter Nut",
                          price: "1kg, \$4",
                          onTapCallback: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
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
}
