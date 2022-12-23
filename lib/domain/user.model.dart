import 'dart:convert';

import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toMap());

class User extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final String token;

  const User({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      email: json["email"],
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson(User user) => {
        "name": user.name,
        "phone_number": user.phoneNumber,
        "email": user.email,
        "token": user.token
      };

  Map<String, dynamic> toMap() => {
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "token": token
      };

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        token,
      ];

  @override
  String toString() {
    return jsonEncode(
      toJson(this),
    );
  }

  factory User.empty() => const User(
      name: "name",
      email: "anonymous",
      phoneNumber: "anonymous",
      token: "anonymous");
}
