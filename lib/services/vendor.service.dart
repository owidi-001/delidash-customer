import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class VendorService {
  // get all vendors
  Future<Map<String, dynamic>> fetchVendors() async {
    Map<String, dynamic> results;

    // Acquire auth token
    String token = await UserPreferences().getToken();

    //  Send request to server
    final response = await get(Uri.parse(ApiUrl.listVendors),
        headers: {"Authorization": "Token $token"});

    // Validate response
    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      // Convert the list to Vendors instance

      List<Vendor> vendors =
          parsed.map<Vendor>((json) => Vendor.fromJson(json)).toList();

      // if (kDebugMode) {
      //   print(vendors);
      // }

      results = {
        "status": true,
        "message": "Vendors loaded",
        "vendors": vendors
      };
      // if (kDebugMode) {
      //   print(results);
      // }
    } else {
      // throw Exception('Failed to load vendors');
      results = {
        "status": false,
        "message":
            "Vendors loaded , reason: \nStatus: ${response.statusCode} \nError: ${response.body} ",
      };
    }

    return results;
  }
}
