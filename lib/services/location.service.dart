import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late String address;
  // double latitude;
  // double longitude;

  // Location(
  //     {required this.address, required this.latitude, required this.longitude});

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
    // address ='${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    address = '${place.name}';

    return address;
  }

  Future<String> getAddress() async {
    return getAddressFromLatLong(await getGeoLocationPosition());
  }
}

Future<String> getAddress() {
  return Future.delayed(const Duration(seconds: 5),(){
    return Location().getAddress();
  });
}
