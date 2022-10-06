import 'package:flutter/material.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/screens/cart.dart';
import 'package:greens_veges/screens/profile.dart';
import 'package:greens_veges/screens/dashboard.dart';
import 'package:greens_veges/screens/products_list_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProductListScreen(),
    const CartScreen(),
    const Profile()
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              color: AppTheme.lightColor),
          child: BottomNavigationBar(
              onTap: _updateIndex,
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: AppTheme.secondaryColor,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(color: AppTheme.primaryColor),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt), label: "Foods"),
                BottomNavigationBarItem(icon: CartIcon(), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
              ]),
        ));
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
      width: kToolbarHeight,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          const Icon(Icons.shopping_bag_outlined),
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              width: 18,
              height: 18,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor,
              ),
              child: Center(
                child: Text(
                  "${cartProvider.items.length}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
