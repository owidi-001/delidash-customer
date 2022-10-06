import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/checkout_screen.dart';
import 'package:greens_veges/screens/dashboard.dart';
import 'package:greens_veges/screens/home_screen.dart';
import 'package:greens_veges/screens/login_screen.dart';
import 'package:greens_veges/screens/products_list_screen.dart';
import 'package:greens_veges/screens/profile.dart';
import 'package:greens_veges/screens/profileEdit.dart';
import 'package:greens_veges/screens/registration_screen.dart';
import 'package:greens_veges/screens/search_locations.dart';
import 'package:greens_veges/screens/splash.dart';
import 'package:greens_veges/screens/welcome.dart';
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
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        // ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Mealio',
        theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
        initialRoute: AppRoute.splash,
        routes: {
          AppRoute.splash: (context) => const SplashScreen(),
          AppRoute.welcome: (context) => const WelcomeScreen(),
          AppRoute.register: (context) => const RegistrationScreen(),
          AppRoute.login: (context) => const LoginScreen(),
          AppRoute.home: (context) => const Home(),
          AppRoute.dashboard: ((context) => const DashboardScreen()),
          AppRoute.location: (context) => const SearchLocation(),
          AppRoute.productList: (context) => const ProductListScreen(),
          AppRoute.cart: (context) => const CartScreen(),
          AppRoute.checkout: (context) => const CheckOut(),
          AppRoute.profile: (context) => const Profile(),
          AppRoute.profileEdit: (context) => const ProfileEdit(),
        },
      ),
    );
  }
}
