import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.center,
                child: Image.network(
                  "$baseURL${item.product.image}",
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.label,
                  style: const TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("Sh. ${item.product.unitPrice}",
                    style: const TextStyle(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        cartProvider.updateCart(item, item.quantity - 1);
                      }),
                      child: Image.asset(
                        "assets/images/remove_icon.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "${item.quantity}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        if (item.quantity < item.product.stock) {
                          cartProvider.updateCart(item, item.quantity + 1);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              showMessage(false,
                                  "Maximum available quantities reached!"));
                        }
                      },
                      child: Image.asset(
                        "assets/images/add_icon.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "sub: ${(item.product.unitPrice * item.quantity).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
