import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/location.model.dart';

class LocationProvider extends ChangeNotifier {
  Location _location = Location.empty();
  LocationStatus locationStatus = LocationStatus.unknown;

  Location get location {
    return _location;
  }

  void setLocation(Location location) {
    if (kDebugMode) {
      /// proven works
      print("Location provider called with value ${location.toString()}");
    }
    _location = location;
    locationStatus = LocationStatus.loaded;
    notifyListeners();
  }
}
