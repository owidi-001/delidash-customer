import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/providers/product.provider.dart';
import 'package:greens_veges/screens/search_list/pages/product_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/product_card.dart';
import 'package:greens_veges/widgets/product_card_skeleton.dart';
import 'package:provider/provider.dart';

class VendorProductList extends StatelessWidget {
  Vendor vendor;
  VendorProductList({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context);
    var vendorProducts = products.fetchVendorProducts(vendor);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          vendor.brand,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppTheme.primaryColor,
          ),
          iconSize: 24,
          splashRadius: 40,
          splashColor: AppTheme.gradientColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),

            //  Product grid
            products.status == ServiceStatus.loading
                ? SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return productSkeletonLoader();
                      },
                      childCount: 6,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.0,
                    ),
                  )
                : vendorProducts.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                                color: AppTheme.lightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const Text(
                                    "No products",
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
                                          Navigator.pop(context);
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
                      )
                    : SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductCardWidget(
                              product: vendorProducts[index],
                              onTapCallback: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          ProductDetailScreen(
                                            product: vendorProducts[index],
                                          )),
                                    ),
                                  )),
                            );
                          },
                          childCount: vendorProducts.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
