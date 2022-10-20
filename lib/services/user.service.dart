import 'package:greens_veges/domain/exception.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/http_client.dart';

class UserService {
  // login
  Future<HttpResult<User>> login({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.register,
        data: data,
        der: (data) => User.fromJson(data),
      );

  // register
  Future<HttpResult<User>> register({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.register,
        data: data,
        der: (data) => User.fromJson(data),
      );

  // Update profile
  Future<HttpResult<User>> updateProfile({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.profileUpdate,
        data: data,
        der: (data) => User.fromJson(data),
      );
}
