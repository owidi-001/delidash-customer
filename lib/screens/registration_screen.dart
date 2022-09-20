import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/providers/user.provider.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:greens_veges/utility/routes.dart';
import 'package:greens_veges/utility/validators.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // formkey
  final _formkey = GlobalKey<FormState>();

  // editing controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

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
      decoration: buildInputDecoration("Enter your email address", Icons.mail),
    );

    // Phone field
    final phoneField = TextFormField(
      autofocus: false,
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onSaved: (value) {
        _phoneController.value;
      },
      validator: ((value) => validPhone(_phoneController.text)),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Enter your mobile number", Icons.phone),
    );

    // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      validator: ((value) => validPassword(_passwordController.text)),
      onSaved: (value) {
        _passwordController.value;
      },
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Enter your password", Icons.lock),
    );

    // password field
    final passwordConfirmField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordConfirmController,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) {
        _passwordConfirmController.value;
      },
      textInputAction: TextInputAction.done,
      validator: ((value) => passwordMatch(
          _passwordController.text, _passwordConfirmController.text)),
      decoration: buildInputDecoration("Confirm your password", Icons.lock),
    );

    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: AppTheme.primaryColor,
            )),
      ),
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
                            "Sign Up",
                            style: TextStyle(
                                color: AppTheme.darkColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Create account to continue",
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
                    "Mobile Number",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  phoneField,
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
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordConfirmField,
                  const SizedBox(
                    height: 32,
                  ),
                  submitButton("Register", doRegister),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Sign in",
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

  void doRegister() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      auth
          .register(
        _emailController.text,
        _phoneController.text,
        _passwordConfirmController.text,
      )
          .then((response) {
        if (response['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Account creation Successfull',
                style: TextStyle(color: AppTheme.whiteColor),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: AppTheme.primaryColor,
              padding: EdgeInsets.all(16.0),
              elevation: 10,
              behavior: SnackBarBehavior.floating));

          User user = response["data"];

          Provider.of<UserProvider>(context, listen: false).setUser(user);
          if (kDebugMode) {
            print("logged user $user");
          }

          Navigator.pushNamed(context, MyRoutes.dashboardRoute);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Account creation Failed',
              style: TextStyle(color: AppTheme.whiteColor),
            ),
            duration: Duration(seconds: 3),
            backgroundColor: AppTheme.redColor,
            padding: EdgeInsets.all(16.0),
            elevation: 10,
            behavior: SnackBarBehavior.floating,
          ));

          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text(response.toString()),
          //   duration: const Duration(seconds: 3),
          //   elevation: 10,
          //   behavior: SnackBarBehavior.floating,
          // ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Invalid Form Please Complete the form properly',
          style: TextStyle(color: AppTheme.whiteColor),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: AppTheme.redColor,
        padding: EdgeInsets.all(16.0),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
