import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int id;
  final String placemark, block, floor, room;

  const Address(
      {required this.id,
      required this.placemark,
      required this.block,
      required this.floor,
      required this.room});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json["id"],
        placemark: json["placemark"],
        block: json["block"],
        floor: json["floor"],
        room: json["room"]);
  }

  static Map<String, dynamic> toMap(Address location) {
    return {
      "id": location.id,
      "placemark": location.placemark,
      "block": location.block,
      "floor": location.floor,
      "room": location.room
    };
  }

  @override
  List<Object?> get props => [id, placemark, block, floor, room];

  factory Address.empty() => const Address(
      id: -1,
      placemark: "placemark",
      block: "block",
      floor: "floor",
      room: "room");

  @override
  String toString() {
    return placemark;
  }
}
