import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

// Save token to local device
class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("userID", user.userId);
    preferences.setString("first_name", user.firstName);
    preferences.setString("last_name", user.lastName);
    preferences.setString("email", user.email);
    preferences.setString("phone", user.phoneNumber);
    preferences.setString("token", user.token);
    
    // TODO: to update the commit
    return preferences.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    int userId = preferences.getInt("userID");
    String first_name = preferences.getString("first_name");
    String last_name = preferences.getString("last_name");
    String email = preferences.getString("email");
    String phone = preferences.getString("phone");
    String token = preferences.getString("token");

    return User(
        userId: userId,
        firstName: first_name,
        lastName: last_name,
        email: email,
        phoneNumber: phone,
        token: token);
  }

  void removeUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove("first_name");
    preferences.remove("last_name");
    preferences.remove("email");
    preferences.remove("phone");
    preferences.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    return token;
  }
}
