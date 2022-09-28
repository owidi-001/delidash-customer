class Address {
  final String name;
  final double lat;
  final double long;
  final String? floorNumber;
  final String? doorNumber;

  Address(
      {required this.name,
      required this.lat,
      required this.long,
      this.floorNumber,
      this.doorNumber});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        name: json["name"],
        lat: json["lat"],
        long: json["long"],
        floorNumber: json["floor_number"],
        doorNumber: json["door_number"]);
  }
}
