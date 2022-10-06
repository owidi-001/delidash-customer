import 'package:flutter/material.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/cart_item.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthenticationProvider>(context);

    double deliveryFee = cartProvider.items.isEmpty ? 0 : 50;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout",
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
          Image.asset(
            "assets/images/user.png",
            width: 48,
            height: 48,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: CustomScrollView(
            slivers: <Widget>[
              // Spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // Delivery address
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Virtual card",
                      style: TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: AppTheme.gradientColor,
                      child: Icon(
                        Icons.credit_card,
                        size: 24,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),
              // Payment card
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const Text(
                                "MPESA",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 2.0,
                                      color: Colors.black26,
                                    ),
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 2.0,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 62.0, maxWidth: 62.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.gradientColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(Icons.contactless_outlined)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              spacePhone(authProvider.user.phoneNumber),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Colors.black26,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const Text(
                              "Amount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Sh. ${cartProvider.totalPrice}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Colors.black26,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              authProvider.user.firstName.isNotEmpty
                                  ? "${authProvider.user.firstName}  ${authProvider.user.lastName}"
                                  : authProvider.user.email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Spacer
              const SliverPadding(padding: EdgeInsets.all(16)),

              // Delivery address
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Address",
                      style: TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        return;
                      }),
                      child: const CircleAvatar(
                        backgroundColor: AppTheme.gradientColor,
                        child: Icon(
                          Icons.edit_location_alt_outlined,
                          size: 24,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer
              const SliverPadding(padding: EdgeInsets.all(8.0)),

              SliverToBoxAdapter(
                child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/dummy_map.png",
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 40,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppTheme.whiteColor,
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(12.0),
                                // ),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Other details",
                                        style: TextStyle(
                                          color: AppTheme.darkColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                    )),
              ),

              const SliverPadding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              SliverToBoxAdapter(
                child: submitButton("Pay Sh. ${cartProvider.totalPrice}", () {
                  // SHow paying snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                      showMessage(true, "Verifying payment ...", timeout: 5));

                  // Navigate back to dashboard
                  Navigator.pushReplacementNamed(context, AppRoute.profile);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String spacePhone(String phone) {
  return "${phone.substring(0, 4)}  ${phone.substring(4, 7)}  ${phone.substring(7, 10)}";
}
