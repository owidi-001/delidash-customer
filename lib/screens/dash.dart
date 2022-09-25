// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:greens_veges/constants/app_theme.dart';
// import 'package:greens_veges/domain/product.model.dart';
// import 'package:greens_veges/domain/user.model.dart';
// import 'package:greens_veges/domain/vendor.model.dart';
// import 'package:greens_veges/providers/product.provider.dart';
// import 'package:greens_veges/providers/user.provider.dart';
// import 'package:greens_veges/providers/vendor.provider.dart';
// import 'package:greens_veges/services/category.service.dart';
// import 'package:greens_veges/services/greetings.service.dart';
// import 'package:greens_veges/services/location.service.dart';
// import 'package:greens_veges/services/product.service.dart';
// import 'package:greens_veges/services/vendor.service.dart';
// import 'package:greens_veges/utility/routes.dart';
// import 'package:greens_veges/widgets/menu_minimal_view.dart';
// import 'package:greens_veges/widgets/product_grid.dart';
// import 'package:greens_veges/widgets/vendor_list.dart';
// import 'package:provider/provider.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     User user = Provider.of<UserProvider>(context).user;

//     // Load Products
//     // List<Product> products = ProductProvider().products;

//     // Load products
//     Future<List<Product>> products = ProductService().fetchProduct();

//     // // Load categories
//     // Future<List<ProductCategory>> categories =
//     //     ProductCategoryService().fetchProductCategories();

//     // Fetch vendors
//     List<Vendor>? vendors = VendorProvider().vendors;

//     // Fetch products categorically
//     Map<String, List<Product>> productsCategorically =
//         ProductProvider().getFoodsCategorically();

//     var greetings = greetingMessage();

//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         backgroundColor: AppTheme.whiteColor,
//         body: SingleChildScrollView(
//           child: Expanded(
//             child: Column(children: [
//               const SizedBox(
//                 height: 36,
//               ),
//               // nav
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () => {
//                           Navigator.pushNamed(context, MyRoutes.profileRoute)
//                         },
//                         child: Image.asset(
//                           // widget.user.profileImage,
//                           "assets/images/user.png",
//                           scale: 3.6,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 8),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 greetings,
//                                 style: const TextStyle(
//                                     color: AppTheme.secondaryColor,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 // user.first_name ?? user.email.split("@")[0],
//                                 "${user.first_name!.isEmpty ? user.email.split("@")[0] : user.first_name}",
//                                 style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         )),
//                     Expanded(
//                         flex: 2,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 8),
//                           decoration: const BoxDecoration(
//                               color: AppTheme.lightColor,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(24))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               const Icon(
//                                 CupertinoIcons.location,
//                                 color: AppTheme.primaryColor,
//                                 size: 16,
//                               ),
//                               FutureBuilder(
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.done) {
//                                     if (snapshot.hasError) {
//                                       if (kDebugMode) {
//                                         print(
//                                             "The snapshot has error ${snapshot.error}");
//                                       }
//                                       return const Text(
//                                         "My Location",
//                                         softWrap: false,
//                                         overflow: TextOverflow.clip,
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500),
//                                       );
//                                     } else if (snapshot.hasData) {
//                                       if (kDebugMode) {
//                                         print(
//                                             "The snapshot data found ${snapshot.data}");
//                                       }
//                                       return Text(
//                                         (snapshot.data as String).length > 11
//                                             ? (snapshot.data as String)
//                                                 .substring(0, 10)
//                                             : snapshot.data as String,
//                                         softWrap: false,
//                                         overflow: TextOverflow.clip,
//                                         style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500),
//                                       );
//                                     }
//                                   }
//                                   return const Text(
//                                     "My location",
//                                     softWrap: false,
//                                     overflow: TextOverflow.clip,
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500),
//                                   );
//                                 },
//                                 future: getAddress(),
//                               ),
//                               const Icon(
//                                 CupertinoIcons.chevron_down,
//                                 color: AppTheme.primaryColor,
//                                 size: 12,
//                               )
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               ),

//               const SizedBox(
//                 height: 16,
//               ),
//               // hero
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Image.asset(
//                   "assets/images/banner.png",
//                   scale: 4.0,
//                 ),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               // Search
//               Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         color: AppTheme.lightColor,
//                         borderRadius: BorderRadius.all(Radius.circular(24))),
//                     child: const TextField(
//                         textAlignVertical: TextAlignVertical.center,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Search Category",
//                           hintStyle: TextStyle(
//                               fontSize: 14,
//                               color: AppTheme.secondaryColor,
//                               fontWeight: FontWeight.w500),
//                           contentPadding: EdgeInsets.all(16),
//                           prefixIcon: Icon(
//                             CupertinoIcons.search,
//                             color: AppTheme.primaryColor,
//                           ),
//                         )),
//                   )),

//               // Vendors
//               SizedBox(
//                   height: double.infinity,
//                   width: size.width,
//                   child: vendors.isEmpty
//                       ? const Text("There are no vendors yet")
//                       // : vendorCardListView(vendors)),
//                       : const Text("Vendors loaded")),

//               // SizedBox(
//               //   height: 100,
//               //   width: size.width,
//               //   child: Padding(
//               //     padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//               //     child: FutureBuilder<List<Vendor>?>(
//               //       future: vendors,
//               //       builder: (context, snapshot) {
//               //         if (snapshot.connectionState == ConnectionState.waiting) {
//               //           return const Center(
//               //               child: CircularProgressIndicator(
//               //             color: AppTheme.primaryColor,
//               //           ));
//               //         } else if (snapshot.connectionState ==
//               //             ConnectionState.done) {
//               //           if (snapshot.hasError) {
//               //             return Text(
//               //                 'Failed to load categories ${snapshot.error}');
//               //           } else if (snapshot.hasData) {
//               //             return vendorCardListView(snapshot.data!);
//               //           } else {
//               //             return const Text('Empty data');
//               //           }
//               //         } else {
//               //           return Text('State: ${snapshot.connectionState}');
//               //         }
//               //       },
//               //     ),
//               //   ),
//               // ),

//               // Padding(
//               //   padding: const EdgeInsets.all(16),
//               //   child: Container(
//               //     width: double.infinity,
//               //     child: Card(
//               //         child: Stack(
//               //       children: <Widget>[
//               //         Positioned(
//               //           left: 0,
//               //           child: Container(
//               //               color: AppTheme.lightColor,
//               //               width: size.width * 0.5,
//               //               child: Image.asset("assets/images/lamb_meat.png")),
//               //         ),
//               //         Positioned(
//               //             child: Container(
//               //           color: AppTheme.primaryColor,
//               //           width: size.width * 0.5,
//               //           child: Column(
//               //             children: [
//               //               const Text(
//               //                 "Random suggestion",
//               //                 style: TextStyle(
//               //                     color: AppTheme.lightColor,
//               //                     fontSize: 18,
//               //                     fontWeight: FontWeight.normal),
//               //               ),
//               //               const Text("Pizzah",
//               //                   style: TextStyle(
//               //                       color: AppTheme.whiteColor,
//               //                       fontSize: 20,
//               //                       fontWeight: FontWeight.bold)),
//               //               ElevatedButton(
//               //                   onPressed: () {},
//               //                   style: TextButton.styleFrom(
//               //                     padding:
//               //                         const EdgeInsets.symmetric(vertical: 16),
//               //                     textStyle: const TextStyle(
//               //                         fontSize: 14,
//               //                         fontWeight: FontWeight.w500),
//               //                     shape: const StadiumBorder(),
//               //                     backgroundColor: AppTheme.whiteColor,
//               //                   ),
//               //                   child: const Text(
//               //                     "suggest",
//               //                     style:
//               //                         TextStyle(color: AppTheme.primaryColor),
//               //                   )),
//               //             ],
//               //           ),
//               //         ))
//               //       ],
//               //     )),
//               //   ),
//               // ),

//               // Padding(
//               //   padding: const EdgeInsets.all(16),
//               //   child: seeAllView(context, "Categories", products),
//               // ),

//               // // // Categories list
//               // SizedBox(
//               //   height: 100,
//               //   width: size.width,
//               //   child: Padding(
//               //     padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//               //     child: FutureBuilder<List<ProductCategory>?>(
//               //       future: categories,
//               //       builder: (context, snapshot) {
//               //         if (snapshot.connectionState == ConnectionState.waiting) {
//               //           return const Center(
//               //               child: CircularProgressIndicator(
//               //             color: AppTheme.primaryColor,
//               //           ));
//               //         } else if (snapshot.connectionState ==
//               //             ConnectionState.done) {
//               //           if (snapshot.hasError) {
//               //             return Text(
//               //                 'Failed to load categories ${snapshot.error}');
//               //           } else if (snapshot.hasData) {
//               //             return categoryCardListView(snapshot.data!);
//               //           } else {
//               //             return const Text('Empty data');
//               //           }
//               //         } else {
//               //           return Text('State: ${snapshot.connectionState}');
//               //         }
//               //       },
//               //     ),
//               //   ),
//               // ),

//               const SizedBox(
//                 height: 24,
//               ),

//               // Padding(
//               //   padding: const EdgeInsets.all(16.0),
//               //   child: categoryView(productsCategorically),
//               // )

//               // Vendors lists
//               // Padding(
//               //   padding: const EdgeInsets.all(16),
//               //   child: Padding(
//               //     padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//               //     child: FutureBuilder<List<Vendor>?>(
//               //       future: vendors,
//               //       builder: (context, snapshot) {
//               //         if (snapshot.connectionState == ConnectionState.waiting) {
//               //           return const Center(
//               //               child: CircularProgressIndicator(
//               //             color: AppTheme.primaryColor,
//               //           ));
//               //         } else if (snapshot.connectionState ==
//               //             ConnectionState.done) {
//               //           if (snapshot.hasError) {
//               //             return Text('Failed to load vendors ${snapshot.error}');
//               //           } else if (snapshot.hasData) {
//               //             return vendorCardListView(snapshot.data!);
//               //           } else {
//               //             return const Text('Empty data');
//               //           }
//               //         } else {
//               //           return Text('State: ${snapshot.connectionState}');
//               //         }
//               //       },
//               //     ),
//               //   ),
//               // )

//               // // Food grid
//               // SizedBox(
//               //   height: size.height,
//               //   width: size.width,
//               //   child: Padding(
//               //     padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//               //     child: FutureBuilder<List<Product>?>(
//               //       future: products,
//               //       builder: (context, snapshot) {
//               //         if (snapshot.connectionState == ConnectionState.waiting) {
//               //           return Column(
//               //             mainAxisAlignment: MainAxisAlignment.start,
//               //             crossAxisAlignment: CrossAxisAlignment.center,
//               //             children: const <Widget>[
//               //               CircularProgressIndicator(
//               //                 color: AppTheme.primaryColor,
//               //               )
//               //             ],
//               //           );
//               //         } else if (snapshot.connectionState ==
//               //             ConnectionState.done) {
//               //           if (snapshot.hasError) {
//               //             return Text(
//               //               'Failed to load products ${snapshot.error}',
//               //               style: const TextStyle(
//               //                   fontSize: 24,
//               //                   fontWeight: FontWeight.normal,
//               //                   color: AppTheme.secondaryColor),
//               //             );
//               //           } else if (snapshot.hasData) {
//               //             return Column(
//               //               children: <Widget>[
//               //                 Padding(
//               //                   padding: const EdgeInsets.all(16),
//               //                   child: seeAllView(
//               //                       context, "Products", snapshot.data!),
//               //                 ),
//               //                 productGrids(snapshot.data!),
//               //               ],
//               //             );
//               //           } else {
//               //             return const Text('Empty data',
//               //                 style: TextStyle(
//               //                     fontSize: 24,
//               //                     fontWeight: FontWeight.normal,
//               //                     color: AppTheme.secondaryColor));
//               //           }
//               //         } else {
//               //           return Text('State: ${snapshot.connectionState}');
//               //         }
//               //       },
//               //     ),
//               //   ),
//               // ),
//             ]),
//           ),
//         ));
//   }
// }
