import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:greens_veges/utility/validators.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

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
      validator: (value) => validPassword(_passwordController.text),
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
                authProvider.status == AuthenticationStatus.authenticating
                    ? ButtonLoading(
                        title: "Login", function: () => login(context))
                    : submitButton("Login", () => login(context)),
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

  void login(BuildContext context) async {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(true, "Please wait authenticating ..."));

      // Update authentication status
      AuthenticationProvider.instance
          .authenticationChanged(AuthenticationStatus.authenticating);

      final res = await UserService().login(data: {
        "email": _emailController.text,
        "password": _passwordController.text
      });
      res.when(
        error: (error) {
          if (error.statusCode == 400) {
            ScaffoldMessenger.of(context)
                .showSnackBar(showMessage(false, "Error! Check your details"));
          } else if (error.statusCode == 500) {
            ScaffoldMessenger.of(context).showSnackBar(showMessage(false,
                "Could not authenticate! \nThe error is on our side solving it ASAP!"));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(showMessage(false, error.message));
          }
        },
        success: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            showMessage(true, "Login Success"),
          );

          AuthenticationProvider.instance.loginUser(
            user: data,
            authToken: data.token,
          );

          Navigator.pushReplacementNamed(context, AppRoute.home);
        },
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, 'Invalid form input!'));
    }
  }
}
