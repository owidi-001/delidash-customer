import 'package:flutter/material.dart';
import 'package:greens_veges/domain/vendor.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/search_list/pages/vendor_product_list.dart';
import 'package:greens_veges/theme/app_theme.dart';

class VendorCard extends StatelessWidget {
  final Vendor vendor;
  const VendorCard({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => VendorProductList(vendor: vendor)),
            ),
          )),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: AppTheme.lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  alignment: Alignment.center,
                  child: Image.network(
                    "$baseURL${vendor.logo}",
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor.brand,
                    style: const TextStyle(
                        color: AppTheme.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(vendor.tagline,
                      style: const TextStyle(
                          color: AppTheme.darkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
