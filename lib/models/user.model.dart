import 'dart:convert';

class User {
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final int userId;
  final String token;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // userId: json['id'],
      userId: 1,
      email: json["email"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      "id": user.userId,
      "email": user.email,
      "last_name": user.lastName,
      "first_name": user.firstName,
      "phone_number": user.phoneNumber,
      "token": user.token
    };
  }

  @override
  String toString() {
    return jsonEncode(
      toJson(this),
    );
  }
}