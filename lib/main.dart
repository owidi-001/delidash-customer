import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/provider/user.provider.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/products.dart';
import 'package:greens_veges/screens/profile.dart';
import 'package:greens_veges/screens/profileEdit.dart';
import 'package:greens_veges/screens/login_screen.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<User?> getUserData() => UserPreferences().getUser();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider())
        ],
        child: MaterialApp(
          title: "Mealio",
          theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
          // initialRoute: "/",
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    } else if (snapshot.data == null) {
                      return const LoginScreen();
                    } else {
                      UserPreferences().removeUser();
                    }
                    // TODO: Set to splash screen ie new user intro
                    return DashboardScreen();
                }
              }),
          routes: {
            // "/": (context) => const SplashScreen(),
            MyRoutes.welcome: (context) => const WelcomeScreen(),
            MyRoutes.register: (context) => const RegistrationScreen(),
            MyRoutes.login: (context) => const LoginScreen(),

            MyRoutes.dashboardRoute: ((context) => DashboardScreen()),

            MyRoutes.foodListRoute: (context) => const FoodListScreen(),
            // MyRoutes.foodDetailRoute: (context) => FoodDetailScreen(
            //       food: Food(
            //           imagePath: "assets/images/carrots.png",
            //           name: "name",
            //           price: "price",
            //           category: FoodCategory(
            //               imagePath: "${baseUrl}fruits.png", label: "Fruits"),
            //           description: ''),
            //     ),
            MyRoutes.cartRoute: (context) => const CartScreen(),
            MyRoutes.profileRoute: (context) => const Profile(),
            MyRoutes.profileEditRoute: (context) => const ProfileEdit(),
          },
        ));
  }
}
