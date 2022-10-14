import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:greens_veges/utility/validators.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String authAction = "Login";

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
      validator: ((value) => validEmail(_emailController.text)),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Email", Icons.mail),
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
      // validator: (value) => validPassword(_passwordController.text),
      textInputAction: TextInputAction.done,
      decoration: buildInputDecoration("Password", Icons.lock),
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
                submitButton("Login", login),
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
                        Navigator.pushNamed(context, AppRoute.register);
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
            ),
          ),
        ),
      )),
    );
  }

  void login() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(true, "Please wait authenticating ..."));

      // Update authentication status
      AuthenticationProvider.instance
          .authenticationChanged(AuthenticationStatus.authenticating);

      final Future<Map<String, dynamic>> successfulMessage =
          UserService().login(_emailController.text, _passwordController.text);

      successfulMessage.then((response) {
        if (response['status'] == true) {
          User user = response['user'];

          // Provider.of<AuthenticationProvider>(context,listen: false)
          //     .loginUser(user: user, authToken: user.token);

          AuthenticationProvider.instance
              .loginUser(user: user, authToken: user.token);

          Navigator.pushReplacementNamed(context, AppRoute.home);

          ScaffoldMessenger.of(context)
              .showSnackBar(showMessage(true, "Login Success"));

          // if (AuthenticationProvider.instance.status ==
          //     AuthenticationStatus.authenticated) {
          //   // Go to homescreen
          //   Navigator.pushReplacementNamed(context, AppRoute.home);

          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(showMessage(true, "Login Success"));
          // } else {
          //   //  print()
          // }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              showMessage(false, "Login Failed ${response['message']!}"));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, 'Invalid form input!'));
    }
  }
}
