import 'dart:collection';

// import 'package:flutter/foundation.dart';
import 'package:greens_veges/services/http.service.dart';

class FoodCategory {
  // attr
  late final String imagePath;
  late final String label;

  // Constructor
  FoodCategory({required this.imagePath, required this.label});
}

List<FoodCategory> getAllCategories() {
  List<FoodCategory> categories = [
    FoodCategory(imagePath: "${baseUrl}fruits.png", label: "Fruits"),
    FoodCategory(imagePath: "${baseUrl}vegetables.png", label: "Vegetables"),
    FoodCategory(imagePath: "${baseUrl}diary.png", label: "Diary"),
    FoodCategory(imagePath: "${baseUrl}meat.png", label: "Meat"),
    FoodCategory(imagePath: "${baseUrl}meat.png", label: "Beef"),
    FoodCategory(imagePath: "${baseUrl}meat.png", label: "Chicken")
  ];

  return categories;
}

// Returns foods of a given category
List<Food> getFoodsOfCategory(FoodCategory foodCategory) {
  List<Food> foods = [];
  for (Food food in getAllFoods()) {
    if (food.category.label == foodCategory.label) {
      foods.add(food);
    }
  }
  return foods;
}

// Returns a map of category and list of foods belonging to that category
Map<FoodCategory, List<Food>> foodCategories() {
  List<FoodCategory> categories = getAllCategories();

  Map<FoodCategory, List<Food>> categoryFoods = HashMap();

  for (FoodCategory category in categories) {
    categoryFoods[category] = getFoodsOfCategory(category);
    
    // Remove categories with empty food list
    if (getFoodsOfCategory(category).isEmpty) {
      categoryFoods.remove(category);
    }
  }
  // if (kDebugMode) {
  //   print("The food categories length is:");
  //   print(categoryFoods.keys.length);
  // }
  return categoryFoods;
}

class Food {
  // attributes
  late final String imagePath;
  late final String name;
  late final String price;
  late final FoodCategory category;

  // Constructor
  Food(
      {required this.imagePath,
      required this.name,
      required this.price,
      required this.category});
}

List<Food> getAllFoods() {
  final List<Food> foodList = [
    Food(
        imagePath: "assets/images/pepper_red.png",
        name: "Bell Pepper Red",
        price: "1kg, 6\$",
        category:
            FoodCategory(imagePath: "${baseUrl}fruits.png", label: "Fruits")),
    Food(
        imagePath: "assets/images/butternut.png",
        name: "Butternut Squash ",
        price: "1kg, 6\$",
        category:
            FoodCategory(imagePath: "${baseUrl}fruits.png", label: "Fruits")),
    Food(
        imagePath: "assets/images/ginger.png",
        name: "Arabic Ginger",
        price: "1kg, 4\$",
        category:
            FoodCategory(imagePath: "${baseUrl}fruits.png", label: "Fruits")),
    Food(
        imagePath: "assets/images/carrots.png",
        name: "Organic Carrots",
        price: "1kg, 4\$",
        category: FoodCategory(
            imagePath: "${baseUrl}vegetables.png", label: "Vegetables")),
    Food(
        imagePath: "assets/images/pepper_red.png",
        name: "Bell Pepper Red",
        price: "1kg, 6\$",
        category: FoodCategory(
            imagePath: "${baseUrl}vegetables.png", label: "Vegetables")),
    Food(
        imagePath: "assets/images/butternut.png",
        name: "Butternut Squash ",
        price: "1kg, 6\$",
        category: FoodCategory(
            imagePath: "${baseUrl}vegetables.png", label: "Vegetables")),
    Food(
        imagePath: "assets/images/ginger.png",
        name: "Arabic Ginger",
        price: "1kg, 4\$",
        category:
            FoodCategory(imagePath: "${baseUrl}diary.png", label: "Diary")),

    Food(
        imagePath: "assets/images/ginger.png",
        name: "Arabic Ginger",
        price: "1kg, 4\$",
        category:
            FoodCategory(imagePath: "${baseUrl}diary.png", label: "Diary")),
    Food(
        imagePath: "assets/images/carrots.png",
        name: "Organic Carrots",
        price: "1kg, 4\$",
        category:
            FoodCategory(imagePath: "${baseUrl}diary.png", label: "Diary")),
  ];
  return foodList;
}
