import 'dart:convert';

import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toMap());

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String token;

  const User({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      lastName: json["last_name"],
      firstName: json["first_name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      email: json["email"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson(User user) => {
        "last_name": user.lastName,
        "first_name": user.firstName,
        "phone_number": user.phoneNumber,
        "email": user.email,
        "token": user.token
      };

  Map<String, dynamic> toMap() => {
        "last_name": lastName,
        "first_name": firstName,
        "phone_number": phoneNumber,
        "email": email,
        "token": token
      };

  @override
  List<Object?> get props => [
        firstName,
        lastName,
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
      firstName: "anonymous",
      lastName: "anonymous",
      email: "anonymous",
      phoneNumber: "anonymous",
      token: "anonymous");
}
