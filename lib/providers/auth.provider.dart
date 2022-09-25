import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/status.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationProvider._();
  static final instance = AuthenticationProvider._();

  AuthenticationStatus status = AuthenticationStatus.unknown;
  
  User user = User.empty();
  String authToken = "";

  void authenticationChanged(AuthenticationStatus status) {
    this.status = status;
    notifyListeners();
  }

  void loginUser({required User user, required String authToken}) {
    this.user = user;
    this.authToken = authToken;
    status = AuthenticationStatus.authenticated;
    notifyListeners();
  }

  void logout() async {
    status = AuthenticationStatus.unAuthenticated;
    user = User.empty();
    authToken = "";
    SharedPreferences.getInstance().then((pref) => pref.clear());
    notifyListeners();
  }

  void initialize({User? user, String? authToken}) {
    this.user = user ?? this.user;
    this.authToken = authToken ?? this.authToken;
  }
}
