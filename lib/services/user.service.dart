import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/services/exceptions.service.dart';
import 'package:greens_veges/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication {
  static Dio dio =
      Dio(BaseOptions(connectTimeout: timeout, receiveTimeout: timeout));

  static Future<void> loginUser(Map data) async {
    try {
      final response = await dio.post(
        "$baseURL/auth/login/",
        data: data,
        options: Options(sendTimeout: timeout),
      );
      final _prefs = await SharedPreferences.getInstance();
      _prefs.setString(
        "token",
        response.data['token'],
      );
    } catch (e) {
      throw getException(e);
    }
  }

  // static Future<String> getAuthToken() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   return _prefs.getString("token");
  // }

  static Future<void> registerUser(String data) async {
    try {
      await dio.post("$baseURL/auth/register/",
          data: data, options: Options(sendTimeout: timeout));
    } catch (e) {
      throw getException(e);
    }
  }


  // static Future<User> updateProfile(String data) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   try {
  //     String authToken = _prefs.getString("token");
  //     var _profile = await dio.put("${baseURL}/customer/profile/",
  //         options: Options(
  //             headers: {'Authorization': 'Token $authToken'},
  //             sendTimeout: timeout),
  //         data: data);
  //     print(_profile.data);
  //     _prefs.setString("user", jsonEncode(_profile.data));
  //     return User.fromJson(_profile.data);
  //   } catch (e) {
  //     throw getException(e);
  //   }
  // }

  // static Future<Map<String, dynamic>> resetPassword({Map data}) async {
  //   try {
  //     final res = await dio.post("${baseURL}api/auth/reset/", data: data);
  //     return res.data;
  //   } catch (e) {
  //     throw getException(e);
  //   }
  // }

  // static Future<Map<String, dynamic>> setNewPassword({Map data}) async {
  //   try {
  //     final res = await dio.put(
  //       "${baseURL}api/auth/reset/",
  //       data: data,
  //       options: Options(sendTimeout: timeout),
  //     );
  //     return res.data;
  //   } catch (e) {
  //     throw getException(e);
  //   }
  // }

  // static Future<User> refreshUserProfile() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   try {
  //     String authToken = _prefs.getString("token");
  //     var profile = await dio.get(
  //       "${baseURL}api/customer/profile/",
  //       options: Options(
  //           headers: {'Authorization': 'Token $authToken'},
  //           sendTimeout: timeout),
  //     );
  //     _prefs.setString(
  //       "user",
  //       jsonEncode(profile.data),
  //     );
  //     return User.fromJson(profile.data);
  //   } catch (e) {
  //     throw getException(e);
  //   }
  // }

  // static Future<User> getUserProfile() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   String _userData = _prefs.get("user");
  //   if (_userData != null) {
  //     return User.fromJson(jsonDecode(_userData));
  //   } else {
  //     try {
  //       String authToken = _prefs.getString("token");
  //       var profile = await dio.get(
  //         "${baseURL}api/customer/profile/",
  //         options: Options(
  //             headers: {'Authorization': 'Token $authToken'},
  //             sendTimeout: timeout),
  //       );
  //       _prefs.setString(
  //         "user",
  //         jsonEncode(profile.data),
  //       );
  //       return User.fromJson(profile.data);
  //     } catch (e) {
  //       throw getException(e);
  //     }
  //   }
  // }
}
