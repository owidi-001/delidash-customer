import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/auth/login_screen.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<AuthenticationProvider>();
    var user = context.watch<AuthenticationProvider>().user;

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
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      CircleAvatar(
                        backgroundColor: AppTheme.whiteColor,
                        radius: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/user.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          user.firstName.isEmpty
                              ? user.email.split("@")[0]
                              : "${user.firstName} ${user.lastName}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gradientColor),
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
                              color: AppTheme.lightColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.orders);
                        },
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.black,
                          color: AppTheme.gradientColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.shopping_cart,
                                  color: AppTheme.secondaryColor,
                                  size: 28,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Orders",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor),
                                    ),
                                    Text(
                                      "Order history",
                                      style: TextStyle(
                                          color: AppTheme.secondaryColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.help);
                        },
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.black,
                          color: AppTheme.gradientColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.phone_callback_rounded,
                                  color: AppTheme.secondaryColor,
                                  size: 28,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Help",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.primaryColor),
                                    ),
                                    Text(
                                      "Contact & help",
                                      style: TextStyle(
                                          color: AppTheme.secondaryColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                  child: ListTile(
                leading: const Icon(
                  Icons.location_on_rounded,
                  size: 32,
                ),
                title: const Text(
                  "Default",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
                ),
                subtitle: const Text(
                  "Home",
                  style: TextStyle(color: AppTheme.secondaryColor),
                ),
                trailing: TextButton(
                  onPressed: (() =>
                      {Navigator.pushNamed(context, AppRoute.location)}),
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Actions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 32),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.person_pin_rounded,
                        size: 28,
                        color: AppTheme.secondaryColor,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.profileEdit);
                          },
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600),
                          ))
                    ]),
                    Row(children: [
                      const Icon(
                        Icons.logout,
                        size: 28,
                        color: AppTheme.redColor,
                      ),
                      TextButton(
                          onPressed: () {
                            userProvider.logout();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('User logged out!'),
                            ));

                            // reroute to login
                            Navigator.pushReplacementNamed(
                                context, AppRoute.login);
                          },
                          child: const Text(
                            "Log out",
                            style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600),
                          ))
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
