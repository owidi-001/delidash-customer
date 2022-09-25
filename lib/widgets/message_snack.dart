import 'package:flutter/material.dart';
import 'package:greens_veges/theme/app_theme.dart';

SnackBar showMessage(bool success, String message) {
  return SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: AppTheme.whiteColor),
    ),
    duration: const Duration(seconds: 3),
    backgroundColor: success ? AppTheme.primaryColor : AppTheme.redColor,
    padding: const EdgeInsets.all(16.0),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
  );
}
