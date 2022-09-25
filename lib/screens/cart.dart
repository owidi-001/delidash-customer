import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cart",
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
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              backgroundColor: AppTheme.lightColor,
              expandedHeight: 100,
              flexibleSpace: Container(
                // padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    // color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.centerLeft,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Shopping",
                      style: TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

          
            // List view
            cartProvider.items.isEmpty
                ? //check if customer has any items in cart
                SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
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
                                const Divider(
                                  color: AppTheme.whiteColor,
                                  thickness: 2,
                                ),
                                const Text(
                                  "No Products in your cart!",
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
                                            context, AppRoute.productList);
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        shape: const StadiumBorder(),
                                        backgroundColor:
                                            AppTheme.secondaryColor,
                                      ),
                                      child: const Text("Browse Products")),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                : //Show order list

                SliverList(
                    delegate: SliverChildBuilderDelegate(((
                    context,
                    index,
                  ) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        children: [
                          // buildCartItem(displayList[index]),
                          CartItemWidget(
                            item: cartProvider.items[index],
                          ),
                          const Divider(
                            color: AppTheme.secondaryColor,
                          )
                        ],
                      ),
                    );
                  }), childCount: cartProvider.items.length))
          ],
        ),
      ),
    );
  }

}
