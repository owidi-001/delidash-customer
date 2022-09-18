import 'package:flutter/foundation.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/utils/routes.dart';
import 'package:http/http.dart';

import 'dart:async';
import 'dart:convert';

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

      UserPreferences().saveUser(authUser);
      
      if (kDebugMode) {
        print("User saved to preferences");
      }
      UserProvider().setUser(authUser);
      if (kDebugMode) {
        print("User set to provider");
      }
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

  Future<FutureOr> register(String email, String phone, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'email': email,
      'phone_number': phone,
      'password1': password
    };

    _loggedInStatus = Status.authenticating;
    notify();

    return await post(Uri.parse(AppUrl.register),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static Future<FutureOr> onValue(Response response) async {
    Map<String, Object> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (kDebugMode) {
      print(responseData);
    }

    if (response.statusCode == 200) {
      User authUser = User.fromJson(responseData);

      // now we will create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Successfully registered',
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
}
