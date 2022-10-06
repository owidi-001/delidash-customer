import 'package:flutter/material.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/cart_item.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    double deliveryFee = cartProvider.items.isEmpty ? 0 : 50;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: CircleAvatar(
              backgroundColor: AppTheme.gradientColor,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              cartProvider.removeAll();
            },
            child: const CircleAvatar(
              backgroundColor: AppTheme.lightColor,
              child: Icon(
                Icons.clear_all_rounded,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  color: AppTheme.lightColor,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Shopping",
                        style: TextStyle(
                            color: AppTheme.darkColor,
                            fontSize: 24,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Cart",
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // List view
              cartProvider.items.isEmpty
                  ? //check if customer has any items in cart
                  SliverToBoxAdapter(
                      child: Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                                color: AppTheme.lightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const Divider(
                                    color: AppTheme.whiteColor,
                                    thickness: 2,
                                  ),
                                  const Text(
                                    "No Products in your cart!",
                                    style: TextStyle(
                                        color: AppTheme.darkColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 24.0,
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.pushReplacementNamed(
                                          //     context, AppRoute.productList);
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  AppRoute.dashboard));
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          shape: const StadiumBorder(),
                                          backgroundColor:
                                              AppTheme.secondaryColor,
                                        ),
                                        child: const Text("Browse Products")),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  : //Show order list

                  SliverList(
                      delegate: SliverChildBuilderDelegate(((
                        context,
                        index,
                      ) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Column(
                            children: [
                              CartItemWidget(
                                item: cartProvider.items[index],
                              ),
                              const Divider(
                                color: AppTheme.secondaryColor,
                              )
                            ],
                          ),
                        );
                      }), childCount: cartProvider.items.length),
                    ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // Cart summary
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                      color: AppTheme.lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Item total:",
                              style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (cartProvider.totalPrice).toStringAsFixed(2),
                              style: const TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Delivery:",
                              style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$deliveryFee",
                              style: const TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppTheme.secondaryColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Total:",
                              style: TextStyle(
                                  color: AppTheme.darkColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sh. ${(cartProvider.totalPrice + deliveryFee).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: AppTheme.darkColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // Checkout button
              SliverToBoxAdapter(
                child: submitButton("Checkout", () {
                  if (cartProvider.items.isEmpty) {
                    // return;
                    Navigator.pushNamed(context, AppRoute.checkout);
                  } else {
                    // Navigate to checkout
                    Navigator.pushNamed(context, AppRoute.checkout);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
