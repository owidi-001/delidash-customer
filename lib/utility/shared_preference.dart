// Save token to local device
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/auth.model.dart';
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
  storeLoginData(LoginData data) async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(USER, jsonEncode(data.user.toMap()));
      pref.setString(TOKEN, data.authToken);
    });
  }

  //TODO! Delete the lines below
  // Save user to shared prefs
  Future<void> saveUser(User user) async {
    await prefs
        .then((value) => value.setString(USER, jsonEncode(user.toJson(user))));
  }

  // Save auth token to shared prefs
  Future<void> saveToken(String token) async {
    await prefs.then((value) => value.setString(TOKEN, token));
  }

  // Confirm User onboard
  Future<void> onBoardUser() async {
    await prefs.then((value) => value.setBool(ONBOARD, true));
  }

  // Retrieve auth token from prefs
  Future<String> getToken() async {
    String data = await prefs.then((value) => value.getString(TOKEN)) ?? "";
    return data;
  }

  // Confirm User onboard
  Future<bool> userBoarded() async {
    bool data = await prefs.then((value) => value.getBool(ONBOARD)) ?? false;
    return data;
  }

  void removeUser() async {
    await prefs.then((value) => value.remove(USER));
    await prefs.then((value) => value.remove(TOKEN));
    await prefs.then((value) => value.remove(ONBOARD));
  }
}
