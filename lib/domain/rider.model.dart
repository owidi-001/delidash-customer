import 'package:greens_veges/domain/user.model.dart';

class Rider {
  // NB other fields presented in the API but not received on the user end are not relevant to the user
  final int id;
  final User user;
  final String brand, gender;

  // Constructor
  Rider(
      {required this.id,
      required this.user,
      required this.brand,
      required this.gender});

  // from json
  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
        id: json["id"],
        user: User.fromJson(json["user"]),
        brand: json["brand"],
        gender: json["gender"]);
  }

  // toMap
  static Map<String, dynamic> toMap(Rider rider) {
    return {
      "id": rider.id,
      "user": rider.user.toMap(),
      "brand": rider.brand,
      "gender": rider.gender
    };
  }
}
