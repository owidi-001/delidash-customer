import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/services/user.service.dart';
import '../utils/routes.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email = "", _phone = "", _password = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final mainKey = GlobalKey<ScaffoldState>();

  InputDecoration formInputDecoration() {
    return const InputDecoration(
      // labelText: ,
      // icon: ,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.primaryColor,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.whiteColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Stack(children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.gradientColor,
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
                      "Fill in your details",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: false,
                          initialValue: '',
                          autocorrect: true,
                          decoration: formInputDecoration(),
                          validator: (str) {
                            if (str!.contains(RegExp(
                                r"/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/"))) {
                              return "Not a valid email!";
                            }
                            return null;
                          },
                          onSaved: (str) => _email = str!,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Phone',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: false,
                          initialValue: '',
                          autocorrect: true,
                          decoration: formInputDecoration(),
                          validator: (str) {
                            if (str!.contains(RegExp(
                                r"^(?:254|\+254|0)?(7(?:(?:[129][0–9])|(?:0[0–8])|(4[0–1]))[0–9]{6})$"))) {
                              return "Not a valid phone!";
                            }
                            return null;
                          },
                          onSaved: (str) => _phone = str!,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          obscureText: true,
                          initialValue: '',
                          autocorrect: true,
                          decoration: formInputDecoration(),
                          validator: (str) => str!.length <= 8
                              ? "Input a strong Password!"
                              : null,
                          onSaved: (str) => _password = str!,
                        ),
                        const SizedBox(
                          height: 30,
                        )
                        // makeInput(label: "First name"),
                        // makeInput(label: "Last Name",),
                        // makeInput(label: "Email",),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                      // onPressed: () {
                      //   // formKey.currentState.save();

                      //   Navigator.pushNamed(
                      //       context, MyRoutes.secondRegistrationRoute);
                      // },
                      onPressed: onRegister,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        shape: const StadiumBorder(),
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text("Register")),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text:
                            "By clicking on “Continue” you are agreeing to our ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.secondaryColor,
                            fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: "terms of use",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor)),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void onRegister() async {
    var form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      setState(() {});

      Map data = {'first_name':"John",'last_name':"Doe",'email': _email, 'phone': _phone, 'password': _password};
      // var data = FormData.fromMap(
      //     {'email': _email, 'phone': _phone, 'password': _password});
      await UserAuthentication.registerUser(jsonEncode(data));

      var snackbar = const SnackBar(
        content: Text("Your data has been sent successfully"),
        duration: Duration(milliseconds: 5000),
      );
      // var snackbar = SnackBar(
      //   content: Text("Email: $_email, Phone: $_phone, Password: $_password"),
      //   duration: const Duration(milliseconds: 5000),
      // );

      // mainKey.currentState.
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
