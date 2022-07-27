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
}

User login() {
  return User(
      userId: 1,
      email: "email@gmail.com",
      firstName: "Tabby",
      lastName: "Tabs",
      profileImage: "assets/images/user.png",
      phoneNumber: "phoneNumber");
}
