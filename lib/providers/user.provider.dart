
import 'package:flutter/foundation.dart';
import 'package:greens_veges/domain/user.model.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
