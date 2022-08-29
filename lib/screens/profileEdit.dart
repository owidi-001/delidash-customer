import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';
import 'package:greens_veges/models/user.model.dart';
import 'package:greens_veges/provider/user.provider.dart';
import 'package:greens_veges/utils/routes.dart';
import 'package:greens_veges/widgets/form_field_maker.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        body: SingleChildScrollView(
          // form fields with details
          child: Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              Column(children: [
                const SizedBox(
                  height: 44,
                ),
                CircleAvatar(
                  backgroundColor: AppTheme.whiteColor,
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                        "assets/images/user.png"),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Update your profile",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(
                              label: "First name",
                              currentValue: user?.firstName),
                          makeInput(
                              label: "Last Name",
                              currentValue: user?.lastName),
                          makeInput(
                              label: "Email", currentValue: user?.email),
                          makeInput(
                              label: "Phone",
                              currentValue: user?.phoneNumber),
                          // makeInput(label: "Password", obsureText: true),
                          // makeInput(label: "Confirm Pasword", obsureText: true)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              // formKey.currentState.save();

                              Navigator.pushNamed(
                                  context, MyRoutes.dashboardRoute);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              shape: const StadiumBorder(),
                              backgroundColor: AppTheme.primaryColor,
                            ),
                            child: const Text("Update")),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
