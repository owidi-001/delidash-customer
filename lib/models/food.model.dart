import 'package:greens_veges/services/http.service.dart';

class Category {
  // attr
  late final String imagePath;
  late final String label;

  // Constructor
  Category({required this.imagePath, required this.label});

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

List<Category> getCategories() {
  List<Category> categories = [
    Category(imagePath: "${baseUrl}fruits.png", label: "Fruits"),
    Category(imagePath: "${baseUrl}vegetables.png", label: "Vegetables"),
    Category(imagePath: "${baseUrl}diary.png", label: "Diary"),
    Category(imagePath: "${baseUrl}meat.png", label: "Meat"),
    Category(imagePath: "${baseUrl}meat.png", label: "Beef"),
    Category(imagePath: "${baseUrl}meat.png", label: "Chicken")
  ];

  return categories;
}

class Food {
  // attributes
  late final String imagePath;
  late final String name;
  late final String price;
  late final Category? category;

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
