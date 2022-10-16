import 'package:flutter/material.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/cart.service.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/cart_item.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';
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
    final locationProvider = Provider.of<LocationProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

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
                            height: MediaQuery.of(context).size.height * 0.3,
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
                                  TextButton(
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                AppRoute.dashboard));
                                      },
                                      child: const Text(
                                        "Browse Products",
                                        style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ))
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
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        color: AppTheme.whiteColor,
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
                                "Sub total:",
                                style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
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
                                "Delivery Fee:",
                                style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
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
              ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),

              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Deliver to:",
                        style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverPadding(padding: EdgeInsets.all(8.0)),

              // Location data
              SliverToBoxAdapter(
                child: Card(
                  child: ListTile(
                    onTap: (() =>
                        {Navigator.pushNamed(context, AppRoute.location)}),
                    leading: locationProvider.location == Location.empty()
                        ? const Text("Location not set!")
                        : Text("${locationProvider.location.name}"),
                    trailing: InkWell(
                      onTap: (() =>
                          {Navigator.pushNamed(context, AppRoute.location)}),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: CircleAvatar(
                          backgroundColor: AppTheme.gradientColor,
                          child: Icon(
                            Icons.edit_location_alt_outlined,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),

              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Payment On:",
                        style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverPadding(padding: EdgeInsets.all(8.0)),

              // Payment data
              SliverToBoxAdapter(
                child: Card(
                  child: ListTile(
                    onTap: (() =>
                        {Navigator.pushNamed(context, AppRoute.location)}),
                    leading: Text(spacePhone(authProvider.user.phoneNumber)),
                    trailing: InkWell(
                      onTap: (() =>
                          {Navigator.pushNamed(context, AppRoute.location)}),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: CircleAvatar(
                          backgroundColor: AppTheme.gradientColor,
                          child: Icon(
                            Icons.edit_sharp,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // Checkout button
              SliverToBoxAdapter(
                child: submitButton("Make Payment", () {
                  if (cartProvider.items.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(showMessage(false, "Your cart is empty"));
                    return;
                  } else {
                    // show processing till response is received
                    Future.doWhile(() {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(showMessage(true, "Please wait ..."));

                      Future<Map<String, dynamic>> data =
                          CartService().saveCart();

                      data.then((value) {
                        if (value["status"]) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              showMessage(
                                  true, "Your order placed successfully"));
                          Navigator.pushReplacementNamed(
                              context, AppRoute.profile);
                          return true;
                        } else {
                          return false;
                        }
                      });
                      return false;
                    });
                    // placeOrder();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String spacePhone(String phone) {
    return "${phone.substring(0, 4)}  ${phone.substring(4, 7)}  ${phone.substring(7, 10)}";
  }

// Place order
  // Future<void> placeOrder() async {
  //   Map<String, dynamic> data = await CartService().saveCart();

  //   if (data["status"]) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(showMessage(true, "Your order placed successfully"));
  //     Navigator.pushReplacementNamed(context, AppRoute.profile);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         showMessage(false, "Failed to place order! \nPayment failed"));
  //   }
  // }
}
