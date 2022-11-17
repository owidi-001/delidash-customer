import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/services/location.service.dart';

class LocationProvider extends ChangeNotifier {
  static Location? _location;
  static LocationStatus locationStatus = LocationStatus.unknown;
  LocationProvider._();
  static LocationProvider instance = LocationProvider._();
  Location get location =>
      _location ??
      Location(
          name: LocationService().getAddressName(),
          blockName: "",
          floor: "0",
          roomNumber: "0");

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
