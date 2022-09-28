import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  AuthenticationProvider.instance.status !=
                          AuthenticationStatus.authenticating
                      ? submitButton("Register", doRegister)
                      : Material(
                          elevation: 5,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: AppTheme.primaryColor,
                          child: MaterialButton(
                            onPressed: () => {},
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: double.infinity,
                            child: const Text(
                              "Authenticating...",
                              style: TextStyle(
                                  color: AppTheme.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
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
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      // Update authentication status
      AuthenticationProvider.instance
          .authenticationChanged(AuthenticationStatus.authenticating);

      UserService()
          .register(
        _emailController.text,
        _phoneController.text,
        _passwordConfirmController.text,
      )
          .then((response) {
        if (response['status'] == true) {
          User user = response["data"];

          // Update provider to read user
          Provider.of<AuthenticationProvider>(context)
              .loginUser(user: user, authToken: user.token);

          // Go to homescreen
          Navigator.pushReplacementNamed(context, AppRoute.home);

          ScaffoldMessenger.of(context)
              .showSnackBar(showMessage(true, "Account creation Successful"));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(showMessage(
              false, "Registration failed! ${response.toString()}"));
        }
      }, onError: ((error) {
        if (kDebugMode) {
          print(error);
        }
      }));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, "Please fill the form properly"));
    }
  }
}
