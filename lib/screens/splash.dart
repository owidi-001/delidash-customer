import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/utility/routes.dart';
import 'welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 1),
        initializeApp
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23AA49),
      body: Center(
          child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 48,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/app_logo.png",
            scale: 4.0,
          ),
        ),
      )),
    );
  }

  initializeApp() async {
    Future<String?> token = UserPreferences().getToken();

    token.then(
        (value) => {
              if (value!.isNotEmpty)
                {
                  // user authenticated
                  Navigator.pushNamed(context, MyRoutes.dashboardRoute)
                }
              else
                {
                  // Route to first time use
                  Navigator.pushNamed(context, MyRoutes.welcome)
                }
            }, onError: (error) {
      if (kDebugMode) {
        print("Splash error $error");
      }
    });
  }
}
