import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:greens_veges/theme/app_theme.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  Function() onTapCallBack;
  LocationListTile(
      {super.key, required this.onTapCallBack, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapCallBack,
          leading: const Icon(
            Icons.location_pin,
            size: 24,
            color: AppTheme.secondaryColor,
          ),
          title: Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
