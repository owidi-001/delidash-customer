import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/services/greetings.service.dart';
import 'package:greens_veges/services/location.service.dart';
import '../models/food.model.dart';
import '../models/user.model.dart';
import '../widgets/category_view.dart';
import '../widgets/menu_minimal_view.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final List<Food> foods = getAllFoods();
  final User user = login();

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var greetings = greetingMessage();

    // var location = () async => getAddressFromLatLong(await getGeoLocationPosition());

    // Future<String> location = getAddress();
    Size size = MediaQuery.of(context).size;
    String location = getAddress();

    if (kDebugMode) {
      print(location);
    }

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
                          Text(
                            "${widget.user.firstName} ${widget.user.lastName}",
                            style: const TextStyle(
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
                        children: <Widget>[
                          const Icon(
                            CupertinoIcons.location,
                            color: AppTheme.primaryColor,
                            size: 16,
                          ),
                          Text(
                            location,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          const Icon(
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
                // Use The seeAllView to manage the spaced nav
                seeAllView(context, "Categories"),
                const SizedBox(
                  height: 24,
                ),

                // Show categories
                SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child: categoryListView(getAllCategories())),

                // const SizedBox(
                //   height: 32,
                // ),

                //  Categorical views
                SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: categoryView(foodCategories()))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
