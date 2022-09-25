import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/services/greetings.service.dart';
import 'package:greens_veges/widgets/product_card.dart';
import 'package:greens_veges/widgets/product_card_skeleton.dart';
import 'package:greens_veges/widgets/vendor_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var greetings = greetingMessage();

    // Load user
    var user = context.watch<AuthenticationProvider>().user;

    // Use product provider
    var appProvider = Provider.of<MealioApplicationProvider>(context);

    // Load Location
    var locationProvider = Provider.of<LocationProvider>(context);

    List<String> browsables = ["Vendors", "Products"];
    String chosenValue = browsables[0];

    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 28,
                ),
              ),

              // Appbar
              SliverAppBar(
                  pinned: false,
                  snap: true,
                  floating: true,
                  // expandedHeight: 160.0,
                  backgroundColor: AppTheme.whiteColor,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => {
                              Navigator.pushNamed(context, AppRoute.profile)
                            },
                            child: Image.asset(
                              // widget.user.profileImage,
                              "assets/images/user.png",
                              scale: 3.6,
                            ),
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
                                    user.firstName.isEmpty
                                        ? user.email.split("@")[0]
                                        : user.firstName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    CupertinoIcons.location,
                                    color: AppTheme.primaryColor,
                                    size: 16,
                                  ),
                                  Text(
                                    locationProvider.location.address,
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
                  )),

              // Hero section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(
                    "assets/images/banner.png",
                    scale: 4.0,
                  ),
                ),
              ),

              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: const <Widget>[
              //         Text(
              //           "Browse Products",
              //           style: TextStyle(
              //               fontSize: 18, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // Show browsable menu
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Browse By:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                            color: AppTheme.lightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: DropdownButton<String>(
                            focusColor: AppTheme.whiteColor,
                            value: chosenValue,
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: AppTheme.darkColor,
                            items: browsables
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: AppTheme.darkColor),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              browsables[0],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: (String? newValue) {
                              chosenValue = newValue!;
                            }),
                      ),
                    ],
                  ),
                ),
              ),

              //  Product grid
              appProvider.productsStatus == ServiceStatus.loading ||
                      appProvider.vendorsStatus == ServiceStatus.loading
                  ? SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return productSkeletonLoader();
                        },
                        childCount: 8,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.0,
                      ),
                    )
                  : chosenValue == "Products"
                      ? SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductCardWidget(
                                product: appProvider.products[index],
                                onTapCallback: (() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            ProductDetailScreen(
                                              product:
                                                  appProvider.products[index],
                                            )),
                                      ),
                                    )),
                              );
                            },
                            childCount: appProvider.products.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.0,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(((
                          context,
                          index,
                        ) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: VendorCard(
                              vendor: appProvider.vendors[index],
                            ),
                          );
                        }), childCount: appProvider.vendors.length))
            ],
          ),
        ));
  }
}
