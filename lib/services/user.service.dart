import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/provider/user.provider.dart';
import 'package:greens_veges/utils/routes.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  // login
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      // body: json.encode(loginData),
      body: loginData,
      // headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print(responseData);
      }

      User authUser = User.fromJson(responseData);

      if (kDebugMode) {
        print(authUser);
      }
      UserPreferences().saveUser(authUser);
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': "Successful", 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  // register
  Future<FutureOr> register(String first_name, String last_name, String email,
      String phone, String password, bool is_vendor) async {
    final Map<String, dynamic> registrationData = {
      'user': {
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'phone_number': phone,
        'password': password,
        'is_vendor': is_vendor
      }
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    return await post(Uri.parse(AppUrl.register),
            body: json.encode(registrationData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  // helper methods
  Future<FutureOr> onValue(Response response) async {
    Map<String, Object> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData['data'];
      User authUser = User.fromJson(userData);
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Registration successful',
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
      print("The error is ${error.detail}");
    }
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
