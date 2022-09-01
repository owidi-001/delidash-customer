import 'package:flutter/material.dart';
import 'package:greens_veges/screens/product_detail.dart';
import 'package:greens_veges/services/product.service.dart';
import 'package:provider/provider.dart';
import '../models/food.model.dart';
import '../widgets/product_card.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product?> products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            mainAxisExtent: 225,
          ),
          itemBuilder: (context, index) {
            return FoodCardWidget(
              image: products[index]!.image,
              name: products[index]!.label,
              price: products[index]!.unit_price,
              onTapCallback: () {
                // Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
                //     arguments: products[index]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FoodDetailScreen(product: products[index]!)));

                // if (products[index] != null) {
                //   Product product = products[index]!;
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               FoodDetailScreen(product: product)));
                // }
              },
            );
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}
