class Location {
  final String? name;
  late final String? blockName;
  late final String? floor;
  late final String? roomNumber;

  Location({this.name, this.blockName, this.floor, this.roomNumber});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      blockName: json["block_name"],
      floor: json["floor_number"],
      roomNumber: json["room_number"],
    );
  }

  static Map<String, dynamic> toMap(Location location) {
    Map<String, dynamic> data = {
      "name": location.name,
      "blockName": location.blockName,
      "floor": location.floor,
      "roomNumber": location.roomNumber
    };

    return data;
  }
}
