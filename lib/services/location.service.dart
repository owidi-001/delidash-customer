import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greens_veges/providers/location.provider.dart';

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

  Future<String?> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    // address ='${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    String? address = place.name;

    return address;
  }

  // Future<Location> fetchLocation() async {
  //   late Location location = Location();

  //   var position = await getGeoLocationPosition();

  //   var address = await getAddressFromLatLong(position);

  //   if (address != null) {
  //     // location=Location(address: address);
  //     location = Location(address: address);

  //     // Update provider to read location
  //     LocationProvider().setLocation(location);
  //   }

  //   return location;
  // }
}
