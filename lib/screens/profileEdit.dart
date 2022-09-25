import 'package:flutter/material.dart';
import 'package:greens_veges/domain/user.model.dart';
import 'package:greens_veges/providers/auth.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/services/user.service.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/utility/validators.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:greens_veges/widgets/message_snack.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  // formkey
  final _formkey = GlobalKey<FormState>();

// editing controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AuthenticationProvider>().user;

// first Name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: _firstNameController,
      keyboardType: TextInputType.name,
      // initialValue: user.firstName.isNotEmpty ? user.firstName : "",
      // initialValue: user.firstName,
      onSaved: (value) {
        _firstNameController.value;
      },
      validator: ((value) {
        if (value!.isEmpty) {
          return "First name is required";
        }
        return null;
      }),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("First Name", Icons.person),
    );

    // last Name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: _lastNameController,
      keyboardType: TextInputType.name,
      // initialValue: user.lastName,
      onSaved: (value) {
        _lastNameController.value;
      },
      validator: ((value) {
        if (value!.isEmpty) {
          return "Last name is required";
        }
        return null;
      }),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Last Name", Icons.person),
    );

    // email field
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      // initialValue: user.email,
      onSaved: (value) {
        _emailController.value;
      },
      validator: ((value) => validEmail(_emailController.text)),
      textInputAction: TextInputAction.next,
      decoration: buildInputDecoration("Email", Icons.mail),
    );

    // phone field
    final phoneField = TextFormField(
      autofocus: false,
      obscureText: false,
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      // initialValue: user.phoneNumber,
      onSaved: (value) {
        _phoneController.value;
      },
      validator: (value) => validPhone(_phoneController.text),
      textInputAction: TextInputAction.done,
      decoration: buildInputDecoration("Phone", Icons.phone),
    );

    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile Update",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios,color: AppTheme.primaryColor,)),
        ),
        body: SingleChildScrollView(
          // form fields with details
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppTheme.lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.whiteColor,
                        radius: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                              // widget.user.profileImage,
                              "assets/images/user.png"),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: const Text(
                          "Update Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            "First Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          firstNameField,
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            "Last Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          lastNameField,
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            "Email Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          emailField,
                          const SizedBox(
                            height: 32,
                          ),
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          phoneField,
                          const SizedBox(
                            height: 32,
                          ),
                          submitButton("Update Details", doUpdate),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void doUpdate() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();

      final Future<Map<String, dynamic>> successfulMessage = UserService()
          .updateProfile(_firstNameController.text, _lastNameController.text,
              _emailController.text, _phoneController.text);

      successfulMessage.then((response) {
        if (response['status'] == true) {
          // redirect to profile
          Navigator.pushReplacementNamed(context, AppRoute.profile);

          ScaffoldMessenger.of(context)
              .showSnackBar(showMessage(true, "Profile Updated Successfully"));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(showMessage(
              false, "Profile Update Failed ${response['message']!}"));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(showMessage(false, 'Invalid form input!'));
    }
  }
}
