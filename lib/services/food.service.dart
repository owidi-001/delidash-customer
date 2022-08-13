import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:greens_veges/models/food.model.dart';
import 'package:http/http.dart' as http;

// Test base url
String baseUrl = "https://veges-server.heroku.com";

// // USER AUTH AND ACCOUNTS
// // Register service
// Future<User> registerUser(Map<String, dynamic> data) async {
//   final response = await http.post(Uri.parse("$baseUrl/register"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       body: jsonEncode(<String, dynamic>{
//         "first_name": data['firstName'],
//         "last_name": data['lastName'],
//         "email": data['email'],
//         "phone_number": data['phoneNumber'],
//         "password": data['password'],
//         "is-vendor": false
//       }));

//   if (response.statusCode == 201) {
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception("Registration failed");
//   }
// }

// // Login service
// Future<User> loginUser(Map<String, dynamic> data) async {
//   final response = await http.post(Uri.parse("$baseUrl/login"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       body: jsonEncode(<String, dynamic>{
//         "email": data['email'],
//         "password": data['password'],
//       }));

//   if (response.statusCode == 200) {
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     if (kDebugMode) {
//       print(response.statusCode);
//     }
//     throw Exception(response.body);
//   }
// }

// // Update details service
// Future<User> updateUser(Map<String, dynamic> data) async {
//   final response = await http.post(Uri.parse("$baseUrl/update"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       body: jsonEncode(<String, dynamic>{
//         "first_name": data['firstName'],
//         "last_name": data['lastName'],
//         "email": data['email'],
//         "phone_number": data['phoneNumber'],
//       }));

//   if (response.statusCode == 201) {
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception("Credentials not updated");
//   }
// }

// PRODUCTS
// get all products
Future<List<Food>> fetchProduct() async {
  final response = await http.get(Uri.parse('$baseUrl/products'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Food>((json) => Food.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load foods');
  }
}

// Payment service & Cart save



