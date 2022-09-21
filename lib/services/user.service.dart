import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/utility/routes.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

import 'package:provider/provider.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredInStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  // login
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: loginData,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      User authUser = User.fromJson(responseData);

      // //save user
      // UserPreferences().saveUser(authUser);

      // //save token
      // UserPreferences().saveToken(authUser.token);

      // // Save user to provider
      // UserProvider().setUser(authUser);

      _loggedInStatus = Status.loggedIn;
      notifyListeners();

      result = {'status': true, 'message': "Successful", 'user': authUser};
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  // end login

  // register
  Future<Map<String, dynamic>> register(
      String email, String phone, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'phone_number': phone,
      'password': password
    };

    _loggedInStatus = Status.registering;
    notifyListeners();

    return await post(Uri.parse(AppUrl.register),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      User authUser = User.fromJson(responseData);

      if (kDebugMode) {
        print("User object created from reg data $authUser");
      }

      // now we will create shared preferences and save data
      UserPreferences().saveUser(authUser);
      UserPreferences().saveToken(authUser.token);

      // Set user to provider
      UserProvider().setUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }
    return result;
  }

  static onError(error) {
    if (kDebugMode) {
      print('the error is ${error.detail}');
    }
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }

  // Log out
  void logout() {
    UserPreferences().removeUser();
  }
}
