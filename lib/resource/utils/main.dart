

// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../domain/auth_dto.dart';
// import '../../domain/user.model.dart';
// import '../../utility/constants.dart';

// Future<LoginData?> loadUserData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? user = prefs.getString(USER_KEY);
//   String? authToken = prefs.getString(AUTH_TOKEN_KEY);
//   if (user != null && authToken != null) {
//     if (kDebugMode) {
//       print(json.decode(user));
//     }
//     return LoginData(
//       user: User.fromJson(
//         json.decode(user),
//       ),
//       authToken: authToken,
//     );
//   }
//   return null;
// }

// storeLoginData(LoginData data) async {
//   await SharedPreferences.getInstance().then((pref) {
//     pref.setString(USER_KEY, jsonEncode(data.user.toMap()));
//     pref.setString(AUTH_TOKEN_KEY, data.authToken);
//   });
// }
