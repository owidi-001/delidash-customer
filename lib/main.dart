import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/vegetables.dart';
import 'screens/dashboard.dart';
import 'screens/registration.dart';
import 'screens/splash.dart';
import 'screens/vegetable_detail.dart';
import 'screens/welcome.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grocery App",
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        MyRoutes.welcomeRoute: (context) => const WelcomeScreen(),
        MyRoutes.registrationRoute: (context) => const RegistrationScreen(),
        MyRoutes.dashboardRoute: (context) => const DashboardScreen(),
        MyRoutes.vegetablesRoute: (context) => const VegetablesScreen(),
        MyRoutes.vegetableDetailRoute: (context) => const VegetableDetailScreen(),
        MyRoutes.cartRoute: (context) => const CartScreen(),
      },
    );
  }
}
