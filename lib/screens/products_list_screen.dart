import 'package:flutter/material.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/category_view.dart';
import 'package:greens_veges/widgets/product_card.dart';
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
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppTheme.lightColor,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
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
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                    child: categoryCardListView(appProvider.categories)),
              ),
            ),
const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            //  Product grid
            appProvider.categoriesStatus == ServiceStatus.loading ||
                    appProvider.productsStatus == ServiceStatus.loading
                ? const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()))
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCardWidget(
                          product: appProvider.products[index],
                          onTapCallback: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ProductDetailScreen(
                                        product: appProvider.products[index],
                                      )),
                                ),
                              )),
                        );
                      },
                      childCount: appProvider.products.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
