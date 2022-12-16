import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

class HelpContact extends StatelessWidget {
  const HelpContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text(
          "Help",
          style: TextStyle(color: AppTheme.whiteColor),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
            color: AppTheme.lightColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: AppTheme.primaryColor,
                  ),
                  child: Image.asset("assets/images/help.png")),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: const Text(
                  "Are you facing any problem?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: const Text(
                  "Call us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
                ),
              ),
              const Text(
                "0791381653",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryColor),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: const Text(
                  "Mail Us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
                ),
              ),
              const Text(
                "kevinalex846@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppTheme.secondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
