import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/order_card_horizontal.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  
  @override
  Widget build(BuildContext context) {
    var orders = [1, 2, 3];
    bool hasOrders = orders.isEmpty;

    var user= context.watch<AuthenticationProvider>().user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppTheme.darkColor,
            )),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 44,
                      ),
                      CircleAvatar(
                        backgroundColor: AppTheme.whiteColor,
                        radius: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                              // widget.user.profileImage,
                              "assets/images/user.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          user.firstName.isEmpty
                              ? "Update Name"
                              : "${user.firstName} ${user.lastName}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          user.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.secondaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoute.profileEdit);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              shape: const StadiumBorder(),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                            child: const Text("Update Profile")),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Lower layer
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Your Orders",
                  style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // List view
            hasOrders
                ? //check if customer has made any orders
                SliverToBoxAdapter(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: AppTheme.lightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const Text(
                                "No orders yet!",
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
                                      Navigator.pushReplacementNamed(
                                          context, AppRoute.dashboard);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      shape: const StadiumBorder(),
                                      backgroundColor: AppTheme.secondaryColor,
                                    ),
                                    child: const Text("Browse Products")),
                              ),
                            ],
                          ),
                        )),
                  )
                : //Show order list

                SliverList(
                    delegate: SliverChildBuilderDelegate(((
                    context,
                    index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: orderCardHorizontal(),
                    );
                  }), childCount: 10))
          ],
        ),
      ),
    );
  }
}
