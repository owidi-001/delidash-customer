import 'package:flutter/material.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';

Widget vendorCardListView(List<Vendor> vendors) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: vendors.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Card(color: AppTheme.lightColor, child: vendorCard(vendors[index])),
      );
    },
  );
}

Widget vendorCard(Vendor vendor) {
  return Card(
    color: AppTheme.lightColor,
    elevation: 2,
    shadowColor: AppTheme.gradientColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.all(20),
    child: ListTile(
        title: Text(
          "${vendor.brand}",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkColor),
        ),
        subtitle: Text(
          "${vendor.tagline}",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkColor),
        ),
        leading: CircleAvatar(
          backgroundColor: AppTheme.lightColor,
          radius: 32,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.network(
              "$baseURL${vendor.logo}",
              scale: 4.0,
            ),
          ),
        ),
        trailing: Column(
          children: [
            const Text(
              "9.8",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkColor),
            ),
            submitButton("view", () => {})
          ],
        )),
  );
}
