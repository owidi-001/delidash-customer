import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/models/food.model.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/foods.dart';
import 'screens/dashboard.dart';
import 'screens/registration.dart';
import 'screens/splash.dart';
import 'screens/food_detail.dart';
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
      title: "Mealio",
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        MyRoutes.welcomeRoute: (context) => const WelcomeScreen(),
        MyRoutes.registrationRoute: (context) => const RegistrationScreen(),
        MyRoutes.dashboardRoute: (context) => DashboardScreen(),
        MyRoutes.foodListRoute: (context) => const FoodListScreen(),
        // MyRoutes.foodDetailRoute: (context){
        //   return ModalRoute.of(context)!.settings.arguments as FoodDetailScreen;
        //   },
        MyRoutes.foodDetailRoute: (context) => FoodDetailScreen(
              food: Food(
                  imagePath: "assets/images/carrots.png",
                  name: "name",
                  price: "price"),
            ),
        MyRoutes.cartRoute: (context) => const CartScreen(),
      },
    );
  }
}
