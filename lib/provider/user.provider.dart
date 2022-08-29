import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

// Save token to local device
class UserPreferences {
  Future<void> saveUser(User user) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString("USER_KEY", jsonEncode(user.toJson(user))));
  }

  Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString("USER_KEY");
    if (data != null) {
      return User.fromJson(jsonDecode(data));
    }
    return null;
  }

  void removeUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove("USER_KEY");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString("USER_KEY");
    if (data != null) {
      return User.fromJson(jsonDecode(data)).token;
    }
    return null;
  }
}
