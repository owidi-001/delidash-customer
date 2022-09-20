import 'dart:convert';

class User {
  final String? first_name;
  final String? last_name;
  final String phone_number;
  final String email;
  final bool is_vendor;
  final String token;


  User({
    this.first_name,
    this.last_name,
    required this.phone_number,
    required this.email,
    required this.is_vendor,
    required this.token,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      last_name: json["last_name"],
      first_name: json["first_name"],
      phone_number: (json["phone_number"] as String).replaceAll("+254", "0"),
      email: json["email"],
      is_vendor: json["is_vendor"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      "last_name": user.last_name,
      "first_name": user.first_name,
      "phone_number": user.phone_number,
      "email": user.email,
      "is_vendor": user.is_vendor,
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