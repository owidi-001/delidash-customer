import 'dart:convert';

class User {
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final int userId;
  final String token;

  User({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.token,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      email: json["email"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      token: json["auth_token"],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      "id": user.userId,
      "email": user.email,
      "last_name": user.lastName,
      "first_name": user.firstName,
      "phone_number": user.phoneNumber,
      "auth_token": user.token
    };
  }

  @override
  String toString() {
    return jsonEncode(
      toJson(this),
    );
  }
}

// class Client {
//   User user;
//   String? gender;

//   Client({required this.user, gender});

//   factory Client.fromJson(Map<String, dynamic> json) {
//     User user = User.fromJson(json['user']);
//     return Client(
//       user: user,
//       gender: json['gender'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"user": user.toJson(user), "gender": gender};
//   }

//   @override
//   String toString() {
//     return jsonEncode(toJson());
//   }
// }
