import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

class PaymentDone extends StatelessWidget {
  const PaymentDone({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
              color: AppTheme.lightColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                CircleAvatar(
                  backgroundColor: AppTheme.whiteColor,
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Order placed",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Update Profile",
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
