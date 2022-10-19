import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      // timeLimit: const Duration(seconds: 5)
    );
  }

  Future<String> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (kDebugMode) {
      print("The placemarks are: ");
      print(placemarks[0].name);
    }

    Placemark place = placemarks[0];
    String address =
        '${place.street} ${place.subLocality} ${place.locality} ${place.postalCode} ${place.country}';
    // String address = '${place.name}';

    return address;
  }

  // Return location description
  Future<String> getAddress() async {
    return getAddressFromLatLong(await getGeoLocationPosition());
  }

  String getAddressName() {
    String name = "";
    LocationService().getAddress().then((value) {
      if (value.isEmpty) {
        name = value;
      } else {
        name = "Location not loaded";
      }
    });

    return name;
  }
}
