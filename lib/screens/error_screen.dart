import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

class ErrorPage extends StatelessWidget {
  String error;
  ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      body: Center(
          child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.primaryColor,
            radius: 48,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/app_logo.png",
                scale: 4.0,
              ),
            ),
          ),
          const Text(
            "Error encountered",
            style: TextStyle(color: AppTheme.secondaryColor, fontSize: 18),
          )
        ],
      )),
    );
  }
}
