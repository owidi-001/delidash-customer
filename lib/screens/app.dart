import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/cart/cart.dart';
import 'package:greens_veges/screens/dashboard/dashboard.dart';
import 'package:greens_veges/screens/home_screen.dart';
import 'package:greens_veges/screens/auth/login_screen.dart';
import 'package:greens_veges/screens/search_list/products_list_screen.dart';
import 'package:greens_veges/screens/profile/profile.dart';
import 'package:greens_veges/screens/profile/pages/profileEdit.dart';
import 'package:greens_veges/screens/auth/registration_screen.dart';
import 'package:greens_veges/screens/cart/pages/search_locations.dart';
import 'package:greens_veges/screens/auth/splash.dart';
import 'package:greens_veges/screens/auth/welcome.dart';
import 'package:provider/provider.dart';

class Mealio extends StatefulWidget {
  const Mealio({super.key});

  @override
  State<Mealio> createState() => _MealioState();
}

class _MealioState extends State<Mealio> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider.instance,
        ),
        ChangeNotifierProvider(create: (_) => MealioApplicationProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider.value(value: LocationProvider.instance)
      ],
      child: MaterialApp(
        title: 'Meal-io',
        theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
        initialRoute: AppRoute.splash,
        routes: {
          AppRoute.splash: (context) => const SplashScreen(),
          AppRoute.welcome: (context) => const WelcomeScreen(),
          AppRoute.register: (context) => RegistrationScreen(),
          AppRoute.login: (context) => LoginScreen(),
          AppRoute.home: (context) => const Home(),
          AppRoute.dashboard: ((context) => const DashboardScreen()),
          AppRoute.location: (context) => const SearchLocation(),
          AppRoute.productList: (context) => const ProductListScreen(),
          AppRoute.cart: (context) => const CartScreen(),
          AppRoute.profile: (context) => const Profile(),
          AppRoute.profileEdit: (context) => const ProfileEdit(),
        },
      ),
    );
  }
}
