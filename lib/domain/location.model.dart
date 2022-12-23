import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int id;
  final String placemark, country, city, street, block, floor, room;

  Address(
      {required this.id,
      required this.placemark,
      required this.country,
      required this.city,
      required this.street,
      required this.block,
      required this.floor,
      required this.room});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json["id"],
        placemark: json["placemark"],
        country: json["country"],
        city: json["city"],
        street: json["street"],
        block: json["block"],
        floor: json["floor"],
        room: json["room"]);
  }

  static Map<String, dynamic> toMap(Address location) {
    return {
      "id": location.id,
      "placemark": location.placemark,
      "country": location.country,
      "city": location.city,
      "street": location.street,
      "block": location.block,
      "floor": location.floor,
      "room": location.room
    };
  }

  @override
  List<Object?> get props =>
      [id, placemark, country, street, block, floor, room];

  factory Address.empty() => Address(
      id: -1,
      placemark: "placemark",
      country: "country",
      city: "city",
      street: "street",
      block: "block",
      floor: "floor",
      room: "room");

  @override
  String toString() {
    return placemark;
  }
}
