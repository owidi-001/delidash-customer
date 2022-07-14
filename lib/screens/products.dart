import 'package:flutter/material.dart';
import 'package:greens_veges/utils/routes.dart';
import '../models/food.model.dart';
import '../widgets/product_card.dart';

class FoodListScreen extends StatefulWidget {
  final List<Food> foods;
  const FoodListScreen({Key? key, required this.foods}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  // List<Food> allFoods = getAllFoods();

  @override
  Widget build(BuildContext context) {
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
              imagePath: widget.foods[index].imagePath,
              name: widget.foods[index].name,
              price: widget.foods[index].price,
              onTapCallback: () {
                Navigator.pushNamed(context, MyRoutes.foodDetailRoute,
                    arguments: widget.foods[index]);
              },
            );
          },
          itemCount: widget.foods.length,
        ),
      ),
    );
  }
}
