import 'package:greens_veges/domain/user.model.dart';

class LoginData {
  final User user;
  final String authToken;
  LoginData({required this.user, required this.authToken});
}
