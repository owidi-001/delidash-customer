import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/auth.model.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:http/http.dart';

class UserService {
  // login
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    Response response = await post(
      Uri.parse(ApiUrl.login),
      body: loginData,
    );

    if (kDebugMode) {
      print("The response received is $response");
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      User authUser = User.fromJson(responseData);

      result = {'status': true, 'message': "Successful", 'user': authUser};
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
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

    return await post(Uri.parse(ApiUrl.register),
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

      LoginData data = LoginData(user: authUser, authToken: authUser.token);

      //save user
      UserPreferences().storeLoginData(data);

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


  // Update profile
  Future<Map<String, dynamic>> updateProfile(
      String firstName, String lastName, String email, String phone) async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    final Map<String, dynamic> profileData = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phone,
      'token': token
    };

    Response response = await post(Uri.parse(ApiUrl.profileUpdate),
        body: profileData, headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      User authUser = User.fromJson(responseData);

      //update provider
      AuthenticationProvider.instance
          .loginUser(user: authUser, authToken: authUser.token);

      //save to prefs
      LoginData loginData =
          LoginData(user: authUser, authToken: authUser.token);

      UserPreferences().storeLoginData(loginData);

      result = {'status': true, 'message': "Successful", 'user': authUser};
    } else {
      ///Throw some exception
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
  // end login
}
