import 'package:greens_veges/domain/exception.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/http_client.dart';
import 'package:greens_veges/utility/shared_preference.dart';

class UserService {
  // login
  Future<HttpResult<User>> login(String email, String password) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    try {
      final results = await HttpClient.post(ApiUrl.login, loginData);
      User user = User.fromJson(results.data);
      return HttpResult.success(user);
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }
  // end login

  // register
  Future<HttpResult<User>> register(
      String email, String phone, String password) async {
    final Map<String, dynamic> data = {
      'email': email,
      'phone_number': phone,
      'password': password
    };

    try {
      final results = await HttpClient.post(ApiUrl.register, data);
      User user = User.fromJson(results.data);
      return HttpResult.success(user);
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }

  // Update profile
  Future<HttpResult<User>> updateProfile(
      String firstName, String lastName, String email, String phone) async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    final Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phone,
      'token': token
    };

    try {
      final results = await HttpClient.post(ApiUrl.profileUpdate, data);
      User user = User.fromJson(results.data);
      return HttpResult.success(user);
    } catch (e) {
      return HttpResult.error(getException(e));
    }
  }

  Future<HttpResult<User>> updateProfile2({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) =>
      HttpClient.post2<User>(
        ApiUrl.profileUpdate,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone,
        },
        der: (data) => User.fromJson(data),
      );
}
