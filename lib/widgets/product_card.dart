import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatelessWidget {
  final Item product;
  final VoidCallback onTapCallback;

  const ProductCardWidget(
      {Key? key, required this.product, required this.onTapCallback})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // Check if product is already added to cart
    bool inCart = cartProvider
        .productInCart(CartItemModel(product: product, quantity: 1));

    return InkWell(
      onTap: () => onTapCallback(),
      child: Card(
          color: AppTheme.lightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Image.network(
                    "$baseURL${product.image}",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.name,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sh. ${product.unitPrice}",
                      style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    inCart
                        ? InkWell(
                            onTap: (() {
                              // check if item in cart
                              showMessage(
                                  true, "${product.name} already in cart");
                              // add item
                            }),
                            child: Image.asset(
                              "assets/images/check.png",
                              width: 36,
                              height: 36,
                            ),
                          )
                        : InkWell(
                            onTap: (() {
                              // check if item in cart
                              cartProvider.add(
                                  CartItemModel(product: product, quantity: 1));
                              showMessage(
                                  true, "${product.name} added to cart");
                              // add item
                            }),
                            child: Image.asset(
                              "assets/images/add_icon.png",
                              width: 36,
                              height: 36,
                            ),
                          )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
