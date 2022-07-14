import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';
import '../models/cart.model.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: CartItemModel.cartItemList.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  item: CartItemModel.cartItemList[index],
                );
              },
            ),
          ),
          // TODO! Cart summary
          // const Divider(),
          // const Padding(padding: EdgeInsets.all(16.0),
          //   child: Text("data"),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xff23AA49),
                    ),
                    child: const Text("Pay Now")),
              )
            ]),
          )
        ],
      ),
    );
  }
}
