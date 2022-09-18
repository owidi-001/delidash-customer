import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:http/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

// Save token to local device
class UserPreferences {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<void> saveUser(User user) async {
    await prefs.then(
        (value) => value.setString("USER", jsonEncode(user.toJson(user))));
  }

  Future<void> saveToken(String token) async {
    await prefs.then((value) => value.setString("token", token));
  }


  Future<User?> getUser() async {
    final data = await prefs.then((value) => value.getString('USER'));

    if (data != null) {
      User user = User.fromJson(jsonDecode(data));
      UserProvider().setUser(user);

      return user;
    }
    return null;
  }

  Future<String?> getToken() async {
    final data = await prefs.then((value) => value.getString("token"));
    return data;
  }

  void removeUser() async {
    await prefs.then((value) => value.remove('USER'));
    await prefs.then((value) => value.remove('token'));
  }
}
