import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/domain/location.model.dart';
import 'package:greens_veges/providers/location.provider.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/utility/shared_preference.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';

class LocationListTile extends StatefulWidget {
  final String location;
  Function() onTapCallBack;
  LocationListTile(
      {super.key, required this.onTapCallBack, required this.location});

  @override
  State<LocationListTile> createState() => _LocationListTileState();
}

class _LocationListTileState extends State<LocationListTile> {
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

      Location location = Location(
          name: widget.location,
          blockName: _blockNameController.text,
          floor: _floorNumberController.text,
          roomNumber: _roomNumberController.text);

      // Save location to provider
      LocationProvider().setLocation(location);
      // Save location locally
      LocationPreferences().storeLocationData(location);

      // Navigate back to the last screen
      Navigator.of(context).pop(); // Closses the bottom sheet
      // Show confirmation message

      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(true, 'Delivery location set!'));

      if (kDebugMode) {
        print("The location saved is");
        print(LocationProvider().location);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, 'Please help us find you!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: _showModalForm,
          leading: const Icon(
            Icons.location_pin,
            size: 24,
            color: AppTheme.secondaryColor,
          ),
          title: Text(
            widget.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
