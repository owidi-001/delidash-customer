import 'package:flutter/material.dart';
import 'package:greens_veges/domain/location.model.dart';

class LocationProvider extends ChangeNotifier {
  UserLocation _location = UserLocation(address: "My Location");

  UserLocation get location {
    return _location;
  }

  void setLocation(UserLocation location) {
    _location = location;
    notifyListeners();
  }
}
