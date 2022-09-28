import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:greens_veges/domain/auto_complete_prediction.dart';
import 'package:greens_veges/domain/place_auto_complete_response.dart';
import 'package:greens_veges/secrets/keys.dart';
import 'package:greens_veges/services/maps.service.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/widgets/location_tile.dart';

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
      // print(response);
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.parseAutocompleteResult(response);
      if (kDebugMode) {
        print(response);
      }
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.whiteColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: AppTheme.lightColor,
            child: Icon(
              Icons.location_history,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
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
                      borderRadius: BorderRadius.all(Radius.circular(24))),
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
              onPressed: () {},
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
                    onTapCallBack: () {},
                    location: placePredictions[index].description!,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
