// Save token to local device
import 'dart:convert';

import 'package:greens_veges/domain/auth.model.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // load shared preferences
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

// Load User data
  Future<LoginData?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString(USER);
    String? authToken = prefs.getString(TOKEN);

    if (user != null && authToken != null) {
      // if (kDebugMode) {
      //   print(json.decode(user));
      // }
      return LoginData(
        user: User.fromJson(
          json.decode(user),
        ),
        authToken: authToken,
      );
    }
    return null;
  }

  // Store user
  void storeLoginData(LoginData data) async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(USER, jsonEncode(data.user.toMap()));
      pref.setString(TOKEN, data.authToken);
    });
  }

  // Retrieve auth token from prefs
  Future<String> getToken() async {
    String data = await prefs.then((value) => value.getString(TOKEN)) ?? "";
    return data;
  }

  // void removeUser() async {
  //   await prefs.then((value) => value.remove(USER));
  //   await prefs.then((value) => value.remove(TOKEN));
  // }
}

class LocationPreferences {
  // load shared preferences
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

// Load location data
  Future<Location?> loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? location = prefs.getString(LOCATION);

    if (location != null) {
      return Location.fromJson(json.decode(location));
    }
    return null;
  }

  // Store location
  void storeLocationData(Location data) async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(LOCATION, jsonEncode(Location.toMap(data)));
    });
  }

  void removeLocation() async {
    await prefs.then((value) => value.remove(LOCATION));
  }
}
