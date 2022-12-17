import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}

Material submitButton(String title, Function() function) {
  return Material(
    elevation: 5,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: AppTheme.primaryColor,
    child: MaterialButton(
      onPressed: function,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
            color: AppTheme.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    ),
  );
}

class ButtonLoading extends StatelessWidget {
  final String title;
  final Function() function;
  const ButtonLoading({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: AppTheme.primaryColor,
      child: MaterialButton(
          onPressed: function,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: AppTheme.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const CircularProgressIndicator(
                color: AppTheme.whiteColor,
              ),
            ],
          )),
    );
  }
}
