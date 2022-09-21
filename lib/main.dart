import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/providers/product.provider.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/products_list_screen.dart';
import 'package:greens_veges/screens/login_screen.dart';
import 'package:greens_veges/screens/profile.dart';
import 'package:greens_veges/screens/profileEdit.dart';
import 'package:greens_veges/screens/splash.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome.dart';
import 'utility/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartModel()),
        ],
        child: MaterialApp(
          title: "Mealio",
          theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
          initialRoute: "/",
          routes: {
            "/": (context) => const SplashScreen(),
            MyRoutes.welcome: (context) => const WelcomeScreen(),
            MyRoutes.register: (context) => const RegistrationScreen(),
            MyRoutes.login: (context) => const LoginScreen(),

            MyRoutes.dashboardRoute: ((context) => const DashboardScreen()),

            MyRoutes.foodListRoute: (context) => const FoodListScreen(),
            MyRoutes.cartRoute: (context) => const CartScreen(),
            MyRoutes.profileRoute: (context) => const Profile(),
            MyRoutes.profileEditRoute: (context) => const ProfileEdit(),
          },
        ));
  }
}
