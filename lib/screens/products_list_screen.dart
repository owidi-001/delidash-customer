import 'package:flutter/material.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/category_card_skeleton.dart';
import 'package:greens_veges/widgets/category_view.dart';
import 'package:greens_veges/widgets/product_card.dart';
import 'package:greens_veges/widgets/product_card_skeleton.dart';
import 'package:provider/provider.dart';

import '../constants/status.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<MealioApplicationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "All Foods",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppTheme.lightColor,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: const TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Category",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryColor,
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.all(16),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppTheme.primaryColor,
                          ),
                        )),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                  child: appProvider.categoriesStatus == ServiceStatus.loading
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: categorySkeletonLoader(),
                            );
                          },
                        )
                      : appProvider.categories.isEmpty
                          ? Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.lightColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "No saved categories yet",
                                  style: TextStyle(
                                      color: AppTheme.secondaryColor,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          : categoryCardListView(appProvider.categories),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            //  Product grid
            appProvider.productsStatus == ServiceStatus.loading
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
                : appProvider.products.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppTheme.lightColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "No products yet",
                              style: TextStyle(
                                  color: AppTheme.secondaryColor, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    : SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductCardWidget(
                              product: appProvider.products[index],
                              onTapCallback: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          ProductDetailScreen(
                                            product:
                                                appProvider.products[index],
                                          )),
                                    ),
                                  )),
                            );
                          },
                          childCount: appProvider.products.length,
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
