import 'package:flutter/material.dart';
import 'package:greens_veges/domain/address.model.dart';
import 'package:greens_veges/theme/app_theme.dart';

class AddressCard extends StatelessWidget {
  Address address;
  AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: const Color(0xffF1F1F5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_city_rounded,
              size: 40,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  address.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text("Floor:${address.floorNumber}",
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.secondaryColor)),
                    Text("Door:${address.doorNumber}",
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.secondaryColor)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
