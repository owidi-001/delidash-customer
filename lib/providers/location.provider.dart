import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/location.model.dart';

class LocationProvider extends ChangeNotifier {
  late Location _location;
  ServiceStatus locationStatus = ServiceStatus.initial;

  Location? get location {
    return _location;
  }

  Future<void> setLocation(Location location) async {
    _location = location;
    locationStatus = ServiceStatus.loadingSuccess;
    notifyListeners();
  }
}
