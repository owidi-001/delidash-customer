import 'dart:convert';

import 'package:equatable/equatable.dart';

Vendor vendorFromJson(String str) => Vendor.fromJson(json.decode(str));
String vendorToJson(Vendor data) => json.encode(data.toMap());

class Vendor extends Equatable {
  final String? brand;
  final String? tagline;
  final String? logo;

  const Vendor({this.brand, this.tagline, this.logo});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      brand: json["brand"],
      tagline: json["tagline"],
      logo: json["logo"],
    );
  }

  Map<String, dynamic> toJson(Vendor vendor) =>
      {"brand": vendor.brand, "tagline": vendor.tagline, "logo": vendor.logo};

  Map<String, dynamic> toMap() =>
      {"brand": brand, "tagline": tagline, "logo": logo};

  @override
  List<Object?> get props => [brand, tagline, logo];

  factory Vendor.empty() =>
      const Vendor(brand: "anonymous", tagline: "Unknown", logo: "");
}
