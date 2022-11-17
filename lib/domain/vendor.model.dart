import 'dart:convert';

import 'package:equatable/equatable.dart';

Vendor vendorFromJson(String str) => Vendor.fromJson(json.decode(str));
String vendorToJson(Vendor data) => json.encode(data.toMap());

class Vendor extends Equatable {
  final int id;
  final int user;
  final String brand;
  final String tagline;
  final String logo;

    
  const Vendor(
      {required this.id,
      required this.user,
      required this.brand,
      required this.tagline,
      required this.logo});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json["id"],
      user: json["user"],
      brand: json["brand"],
      tagline: json["tagline"],
      logo: json["logo"],
    );
  }

  Map<String, dynamic> toJson(Vendor vendor) => {
        "id": vendor.id,
        "user": vendor.user,
        "brand": vendor.brand,
        "tagline": vendor.tagline,
        "logo": vendor.logo
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user,
        "brand": brand,
        "tagline": tagline,
        "logo": logo
      };

  @override
  List<Object?> get props => [id, user, brand, tagline, logo];

  factory Vendor.empty() => const Vendor(
      id: 0, user: 0, brand: "anonymous", tagline: "Unknown", logo: "");
}
