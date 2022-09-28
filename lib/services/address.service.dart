import 'package:greens_veges/domain/address.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

class AddressService {
  // Fetch addresses
  Future<Map<String, dynamic>> fetchAddress() async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.userAddress),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      // Convert the list to Address instance
      List<Address> addresses = parsed
          .map<Address>((json) => Address.fromJson(json))
          .toList();

      // Update provider to read categories
      result = {
        "status": true,
        "message": "User address loaded",
        "addresses": addresses
      };
    } else {
      // throw Exception('Failed to load address');
      result = {
        "status": false,
        "message": "Address not loaded",
      };
    }
    return result;
  }
}
