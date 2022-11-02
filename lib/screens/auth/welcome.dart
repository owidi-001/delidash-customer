import 'package:flutter/material.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/images/welcome_bg.png"),
            fit: BoxFit.cover,
          ))),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  CircleAvatar(
                    backgroundColor: AppTheme.whiteColor,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/images/app_logo.png",
                        scale: 4.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text(
                      "Get your food delivered to your door",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: const Text(
                      "The best food delivery app in town for delivering your daily fresh foods",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppTheme.secondaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoute.login);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          shape: const StadiumBorder(),
                          backgroundColor: AppTheme.primaryColor,
                        ),
                        child: const Text("Shop now")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
