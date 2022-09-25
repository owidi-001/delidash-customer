// import 'package:flutter/material.dart';
// import 'package:greens_veges/theme/app_theme.dart';
// import 'package:greens_veges/domain/cart.model.dart';
// import '../widgets/cart_item.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "Cart",
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: const Icon(Icons.arrow_back_ios)),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               ListView.separated(
//                 shrinkWrap: true,
//                 separatorBuilder: (context, index) {
//                   return const Divider();
//                 },
//                 itemCount: CartItemModel.cartItemList.length,
//                 itemBuilder: (context, index) {
//                   return CartItemWidget(
//                     item: CartItemModel.cartItemList[index],
//                   );
//                 },
//               ),

//               const SizedBox(
//                 height: 24,
//               ),

//               // Cart summary
//               Container(
//                 padding: const EdgeInsets.all(16.0),
//                 decoration: const BoxDecoration(
//                     color: AppTheme.lightColor,
//                     borderRadius: BorderRadius.all(Radius.circular(24))),
//                 child: Card(
//                   color: Colors.transparent,
//                   elevation: 0,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const <Widget>[
//                           Text(
//                             "Item total:",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                           Text(
//                             "\$100",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           )
//                         ],
//                       ),


//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const <Widget>[
//                           Text(
//                             "Delivery:",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                           Text(
//                             "Free",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           )
//                         ],
//                       ),
//                       const Divider(
//                         color: AppTheme.secondaryColor,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const <Widget>[
//                           Text(
//                             "Total:",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           ),
//                           Text(
//                             "\$100",
//                             style: TextStyle(
//                                 color: AppTheme.secondaryColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               FractionallySizedBox(
//                 widthFactor: 1,
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       textStyle: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.w500),
//                       shape: const StadiumBorder(),
//                       backgroundColor: const Color(0xff23AA49),
//                     ),
//                     child: const Text("Pay Now")),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
