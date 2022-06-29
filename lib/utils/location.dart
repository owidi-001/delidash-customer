// import 'package:flutter/foundation.dart';
// import 'package:location/location.dart';

// Future<LocationData?> getLocation() async {
//   Location location = Location();

//   // Check if service is enabled
//   bool serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return null;
//     }
//   }

//   // Check if permission is granted
//   PermissionStatus permissionGranted = await location.hasPermission();

//   if (permissionGranted == PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       return null;
//     }
//   }

//   location.enableBackgroundMode(enable: true);
//   // Get the address
//   LocationData locationData = await location.getLocation();

//   return locationData;
// }

// void main(List<String> args) {
//   if (kDebugMode) {
//     print(getLocation());
//   }
// }
