import 'dart:convert';

class User {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImage;

  User({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["user"]['id'],
      email: json["user"]["email"],
      lastName: json["user"]["last_name"],
      firstName: json["user"]["first_name"],
      phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
      profileImage: json["profile_image"],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return <String, dynamic>{
      "id": user.userId,
      "email": user.email,
      "last_name": user.lastName,
      "first_name": user.firstName,
      "phone_number": user.phoneNumber,
      "profile_image": user.profileImage
    };
  }

  @override
  String toString() {
    return jsonEncode(
      toJson(this),
    );
  }
}

class Client {
  User user;
  String? gender;

  Client({required this.user, gender});

  factory Client.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    return Client(
      user: user,
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"user": user.toJson(user), "gender": gender};
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
