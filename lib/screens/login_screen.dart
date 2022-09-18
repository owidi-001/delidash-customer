import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:provider/provider.dart';
import '../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        _emailController.value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Email field required!";
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        _passwordController.value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // login button
    final loginButton = Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: AppTheme.primaryColor,
      child: MaterialButton(
        onPressed: () {
          doLogin();
        },
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Login",
          style: TextStyle(
              color: AppTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "Sign in",
                            style: TextStyle(
                                color: AppTheme.darkColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sign in to continue",
                            style: TextStyle(
                                color: AppTheme.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Email Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  emailField,
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordField,
                  const SizedBox(
                    height: 32,
                  ),
                  loginButton,
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account? ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.register);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      )),
    );
  }

  void doLogin() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      final Future<Map<String, dynamic>> successfulMessage =
          auth.login(_emailController.text, _passwordController.text);

      successfulMessage.then((response) {
        if (response['status'] == true) {
          User user = response['user'];
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          if (kDebugMode) {
            print("logged user $user");
          }
          Navigator.pushNamed(context, MyRoutes.dashboardRoute);

          if (kDebugMode) {
            print("Dashboard pushed");
          }
          Fluttertoast.showToast(
              msg: "Login Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppTheme.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Login Failed!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppTheme.redColor,
              textColor: Colors.white,
              fontSize: 16.0);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            elevation: 2,
            content: Text(response['message']['message'].toString()),
            duration: const Duration(seconds: 3),
          ));
        }
      });
    } else {
      if (kDebugMode) {
        print("form is invalid");
      }
    }
  }
}
