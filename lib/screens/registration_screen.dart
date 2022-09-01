import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:greens_veges/utils/routes.dart';
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
          hintText: "Enter your email address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Mobile number required";
        }
        if (!RegExp(r"^0(7(?:(?:[129][0-9])|(?:0[0-8])|(4[0-1]))[0-9]{6})$")
            .hasMatch(value)) {
          return "Enter a valid kenyan number";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your mobile number",
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Password field required!";
        }
        if (!RegExp(r"^.{8,}$").hasMatch(value)) {
          return "Enter a strong password (> 8 characters)";
        }
        return null;
      },
      onSaved: (value) {
        _passwordController.value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
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
      validator: (value) {
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm your password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // register button
    final registerButton = Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(const Radius.circular(10)),
      color: AppTheme.primaryColor,
      child: MaterialButton(
        onPressed: () {
          doRegister();
        },
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          "Sign Up",
          style: TextStyle(
              color: AppTheme.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
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
                  registerButton,
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
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      auth
          .register("John", "Doe", _emailController.text,
              _passwordConfirmController.text, _phoneController.text, false)
          .then((response) {
        if (response != null) {
          if (kDebugMode) {
            print(response);
          }
          // User user = response['data'];
          // Provider.of<UserProvider>(context, listen: false).setUser(user);

          Fluttertoast.showToast(
              msg: "Account creation Successful",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppTheme.primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushNamed(context, MyRoutes.dashboardRoute);
        } else {
          Fluttertoast.showToast(
              msg: "Account creation Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppTheme.redColor,
              textColor: Colors.white,
              fontSize: 16.0);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.toString()),
            duration: const Duration(seconds: 3),
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Form Please Complete the form properly'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
