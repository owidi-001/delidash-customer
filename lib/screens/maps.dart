import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greens_veges/providers/app.provider.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/address_card.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<MealioApplicationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick delivery location'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Saved addresses",
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return AddressCard(
          //         address: appProvider.addresses[index],
          //       );
          //     },
          //     childCount: appProvider.addresses.length,
          //   ),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 10,
          //     crossAxisSpacing: 10,
          //     childAspectRatio: 1.0,
          //   ),
          // )
        ],
      ),
    );
  }
}
