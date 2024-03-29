import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/providers/product.provider.dart';
import 'package:greens_veges/screens/search_list/components/body.dart';
import 'package:greens_veges/screens/search_list/pages/product_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/product_card.dart';
import 'package:provider/provider.dart';

// Set global for filters
List<Item> products = [];

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    products = Provider.of<ProductProvider>(context).data;
    if (kDebugMode) {
      print(products);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 32,
        ),

        // Top widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Text(
              "All Products",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: // Search Button
                  IconButton(
                onPressed: (() {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                }),
                icon: const Icon(
                  Icons.search,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),

        // Body of product cards
        const Body()
      ]),
    );
  }
}

// Custom search delegate
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = products.map((e) => e.name).toList();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = "";
          }),
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, null);
        }),
        icon: const Icon(Icons.arrow_back,color:  AppTheme.primaryColor,));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Item> matchQuery = [];

    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Expanded(
        child: GridView.builder(
          itemCount: matchQuery.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ProductCardWidget(
            product: matchQuery[index],
            onTapCallback: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  product: matchQuery[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Item> matchQuery = [];

    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Expanded(
        child: GridView.builder(
            itemCount: matchQuery.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => ProductCardWidget(
                  product: matchQuery[index],
                  onTapCallback: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: matchQuery[index],
                        ),
                      )),
                )),
      ),
    );
  }
}
