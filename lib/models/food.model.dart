import 'package:greens_veges/services/http.service.dart';

class FoodCategory {
  // attr
  late final String imagePath;
  late final String label;

  // Constructor
  FoodCategory({required this.imagePath, required this.label});

  // methods

  // Get category foods
  List getCategoryFoods(String label) {
    List foods = [];
    for (var food in Food.getAllFoods()) {
      if (food.category == label) {
        foods.add(food);
      }
    }
    return foods;
  }
}

List<FoodCategory> getCategories() {
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

class Food {
  // attributes
  late final String imagePath;
  late final String name;
  late final String price;
  late final FoodCategory? category;

  // Constructor
  Food(
      {required this.imagePath,
      required this.name,
      required this.price,
      this.category});

  static getAllFoods() {}
}

List<Food> getFoods() {
  final foodList = [
    Food(
        imagePath: "assets/images/pepper_red.png",
        name: "Bell Pepper Red",
        price: "1kg, 6\$"),
    Food(
        imagePath: "assets/images/butternut.png",
        name: "Butternut Squash ",
        price: "1kg, 6\$"),
    Food(
        imagePath: "assets/images/ginger.png",
        name: "Arabic Ginger",
        price: "1kg, 4\$"),
    Food(
        imagePath: "assets/images/carrots.png",
        name: "Organic Carrots",
        price: "1kg, 4\$"),
    Food(
        imagePath: "assets/images/pepper_red.png",
        name: "Bell Pepper Red",
        price: "1kg, 6\$"),
    Food(
        imagePath: "assets/images/butternut.png",
        name: "Butternut Squash ",
        price: "1kg, 6\$"),
    Food(
        imagePath: "assets/images/ginger.png",
        name: "Arabic Ginger",
        price: "1kg, 4\$"),
    Food(
        imagePath: "assets/images/carrots.png",
        name: "Organic Carrots",
        price: "1kg, 4\$"),
  ];
  return foodList;
}
