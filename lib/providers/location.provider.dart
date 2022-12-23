import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/location.model.dart';

class LocationProvider extends ChangeNotifier {
  static Address? _location;
  static LocationStatus locationStatus = LocationStatus.unknown;
  LocationProvider._();
  static LocationProvider instance = LocationProvider._();

  Address get location => _location ?? Address.empty();

  void setLocation(Address location) {
    _location = location;
    locationStatus = LocationStatus.loaded;
    notifyListeners();
  }
}
