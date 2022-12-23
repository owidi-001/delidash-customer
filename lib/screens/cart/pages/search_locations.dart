import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/auto_complete_prediction.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/domain/place_auto_complete_response.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/secrets/keys.dart';
import 'package:greens_veges/services/location.service.dart';
import 'package:greens_veges/services/maps.service.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/location_tile.dart';
import 'package:greens_veges/widgets/message_snack.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  List<AutocompletePrediction> placePredictions = [];

  // Search complete
  void placeAutoComplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "/maps/api/place/autocomplete/json", {
      "input": query,
      "key": mapsAPIKey,
    });

    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  // Location description
  String location_name = "";

  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers
  final TextEditingController _blockNameController = TextEditingController();
  final TextEditingController _floorNumberController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();

  // order detail view
  void _showModalForm() {
    // block Name field
    final blockNameField = TextFormField(
      autofocus: false,
      controller: _blockNameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        _blockNameController.value;
      },
      validator: ((value) {
        if (value!.isEmpty) {
          return "Please give building name/number";
        }
        return null;
      }),
      textInputAction: TextInputAction.next,
      decoration:
          buildInputDecoration("Building name", Icons.bungalow_outlined),
    );

    // block Name field
    final floorNumberField = TextFormField(
      autofocus: false,
      controller: _floorNumberController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        _floorNumberController.value;
      },
      validator: ((value) {
        if (value!.isEmpty) {
          return "Enter 0 if none";
        }
        return null;
      }),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Floor", Icons.business),
    );

    // block Name field
    final roomNumberField = TextFormField(
      autofocus: false,
      controller: _roomNumberController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        _roomNumberController.value;
      },
      validator: ((value) {
        if (value!.isEmpty) {
          return "Enter 0 if none";
        }
        return null;
      }),
      textInputAction: TextInputAction.done,
      decoration: buildInputDecoration("Room", Icons.door_back_door_rounded),
    );

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: AppTheme.gradientColor,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "Building name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      blockNameField,
                      const SizedBox(
                        height: 18.0,
                      ),
                      const Text(
                        "Floor Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      floorNumberField,
                      const SizedBox(
                        height: 18.0,
                      ),
                      const Text(
                        "Room Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      roomNumberField,
                      const SizedBox(
                        height: 18.0,
                      ),
                      submitButton("Save Location", saveLocation),
                      const SizedBox(
                        height: 18.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Save location
  void saveLocation() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      Address location = Address(
          id: -1,
          placemark: location_name,
          country: location_name,
          city: location_name,
          street: location_name,
          block: _blockNameController.text,
          floor: _floorNumberController.text,
          room: _roomNumberController.text);

      // Save location to provider
      LocationProvider.instance.setLocation(location);
      // Save location locally
      LocationPreferences().storeLocationData(location);

      // Navigate back to the last screen
      Navigator.of(context).pop(); // Closes the bottom sheet

      // Show confirmation message
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(true, 'Delivery location set!'));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, 'Please help us find you!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.whiteColor,
        title: const Text(
          "Set Delivery location",
          style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              onTap: (() {
                Navigator.pop(context);
              }),
              child: const CircleAvatar(
                backgroundColor: AppTheme.lightColor,
                child: Icon(
                  Icons.close_rounded,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          // Search section
          Form(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: TextFormField(
                      onChanged: ((value) {
                        placeAutoComplete(value);
                      }),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Your location",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.w500),
                        contentPadding: EdgeInsets.all(16),
                        prefixIcon: Icon(
                          Icons.location_searching,
                          color: AppTheme.primaryColor,
                        ),
                      )),
                )),
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Assing location name, pick from service
                Future<String> address = LocationService().getAddress();
                // Set location name to the future instance string value
                address.then((value) => location_name = value);

                // // Test if location is saved
                // if (kDebugMode) {
                //   print("The location detected is: $location_name");
                // }
                // Show modal
                _showModalForm();
              },
              icon: const Icon(
                Icons.location_pin,
                color: AppTheme.primaryColor,
                size: 16,
              ),
              label: const Text(
                "Use my Current Location",
                style: TextStyle(
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightColor,
                  foregroundColor: AppTheme.secondaryColor,
                  elevation: 0,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
            ),
          ),

          const Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: placePredictions.length,
              itemBuilder: ((context, index) => LocationListTile(
                    location: placePredictions[index].description!,
                    onTapCallBack: () {
                      // Assing location name
                      location_name = placePredictions[index].description!;
                      // Show modal
                      _showModalForm();
                    },
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
