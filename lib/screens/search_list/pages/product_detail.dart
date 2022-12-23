import 'package:flutter/material.dart';
import 'package:greens_veges/domain/cart.model.dart';
import 'package:greens_veges/providers/cart.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Item product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // Check if product is already added to cart
    bool inCart = cartProvider
        .productInCart(CartItemModel(product: widget.product, quantity: 1));

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Product detail",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppTheme.lightColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 140.0))),
              child: Column(children: [
                const SizedBox(
                  height: 24,
                ),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.6,
                  child: Image.network(
                    "$baseURL${widget.product.image}",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  if (itemCount > 1) {
                                    itemCount--;
                                  } else {
                                    return;
                                  }
                                });
                              }),
                              child: Image.asset(
                                "assets/images/remove_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "$itemCount",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkColor),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  itemCount++;
                                });
                              },
                              child: Image.asset(
                                "assets/images/add_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                      "Sh. ${(widget.product.unitPrice * itemCount).toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(
                    color: AppTheme.lightColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "About ${widget.product.name}",
                      style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          color: AppTheme.lightColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "Sh. ${(widget.product.unitPrice * itemCount).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: AppTheme.darkColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                "Total Price",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: inCart
                                ? ElevatedButton(
                                    onPressed: () {
                                      cartProvider
                                          .removeFromCart(widget.product);

                                      // Navigator.pushNamed(context, AppRoute.cart);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showMessage(
                                              false, "Product removed cart!"));
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      shape: const StadiumBorder(),
                                      backgroundColor: AppTheme.redColor,
                                    ),
                                    child: const Text(
                                      "Remove from cart",
                                      style:
                                          TextStyle(color: AppTheme.whiteColor),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      // check if item in cart
                                      cartProvider.add(CartItemModel(
                                          product: widget.product,
                                          quantity: itemCount));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showMessage(
                                              true, "Product added to cart!"));

                                      // Navigator.pushNamed(context, AppRoute.cart);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      shape: const StadiumBorder(),
                                      backgroundColor: AppTheme.primaryColor,
                                    ),
                                    child: const Text(
                                      "Add to cart",
                                      style:
                                          TextStyle(color: AppTheme.whiteColor),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
