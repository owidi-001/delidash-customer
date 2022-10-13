import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/product.model.dart';
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
import 'package:greens_veges/widgets/vendor_card_skeleton.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static List<String> browsables = ["Vendors", "Products"];
  String chosenValue = browsables[0];
  @override
  Widget build(BuildContext context) {
    var greetings = greetingMessage();

    // Load user
    var user = context.watch<AuthenticationProvider>().user;

    // Use product provider
    var appProvider = Provider.of<MealioApplicationProvider>(context);

    // Load Location
    var locationProvider = Provider.of<LocationProvider>(context);

    // Banner product
    Product? product;
    if (appProvider.productsStatus == ServiceStatus.loadingSuccess &&
        appProvider.products.length > 1) {
      product = (appProvider.products..shuffle()).first;
    }

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
                            child: InkWell(
                              onTap: (() => {
                                    Navigator.pushNamed(
                                        context, AppRoute.location)
                                  }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: const BoxDecoration(
                                    color: AppTheme.lightColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(
                                      CupertinoIcons.location,
                                      color: AppTheme.primaryColor,
                                      size: 16,
                                    ),
                                    Text(
                                      "My Location",
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
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
                              ),
                            ))
                      ],
                    ),
                  )),

              // Hero section
              SliverToBoxAdapter(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 5,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/banner.png",
                        fit: BoxFit.fill,
                        height: 160,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        height: 160,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          // height: MediaQuery.of(context).size.width * 0.56,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.elliptical(
                                  MediaQuery.of(context).size.width * 0.2,
                                  MediaQuery.of(context).size.width * 0.8),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Random suggestions",
                                style: TextStyle(
                                    color: AppTheme.gradientColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                product != null ? product.label : "Beef pizza",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppTheme.whiteColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.normal),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (product != null) {
                                      (() => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  ProductDetailScreen(
                                                    product: product!,
                                                  )),
                                            ),
                                          ));
                                    } else {
                                      return;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.fastfood_outlined,
                                    color: AppTheme.primaryColor,
                                    size: 16,
                                  ),
                                  label: const Text(
                                    "View",
                                    style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.lightColor,
                                      foregroundColor: AppTheme.secondaryColor,
                                      elevation: 0,
                                      fixedSize: const Size(120, 28),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24.0),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                                BorderRadius.all(Radius.circular(12))),
                        child: DropdownButton<String>(
                          focusColor: AppTheme.whiteColor,
                          value: chosenValue,
                          style: const TextStyle(color: Colors.white),
                          // iconEnabledColor: AppTheme.darkColor,
                          items: browsables
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style:
                                    const TextStyle(color: AppTheme.darkColor),
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
                          onChanged: ((value) => {
                                setState(() {
                                  chosenValue = value!;
                                })
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //  Data grid/columns
              appProvider.productsStatus == ServiceStatus.loading ||
                      appProvider.vendorsStatus == ServiceStatus.loading
                  // Check the browse value
                  ? chosenValue == browsables[0]
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(((
                            context,
                            index,
                          ) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: VendorCardSkeleton(),
                            );
                          }), childCount: 6),
                        )
                      : SliverGrid(
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
                      ? appProvider.products.isNotEmpty
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
                                                  product: appProvider
                                                      .products[index],
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
                          : const SliverToBoxAdapter(
                              child: Text(
                                "No Products saved yet",
                                style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 18),
                              ),
                            )
                      : appProvider.vendors.isNotEmpty
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(((
                                context,
                                index,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: VendorCard(
                                    vendor: appProvider.vendors[index],
                                  ),
                                );
                              }), childCount: appProvider.vendors.length),
                            )
                          : const SliverToBoxAdapter(
                              child: Text(
                                "No vendors saved yet",
                                style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 18),
                              ),
                            ),
            ],
          ),
        ));
  }
}
