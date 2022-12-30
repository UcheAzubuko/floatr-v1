import 'package:flutter/material.dart';

class AppSnackBar {
  static showErrorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMsg),
      duration: const Duration(milliseconds: 3000),
      backgroundColor: Colors.red,
    ));
  }

  static showSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMsg),
      duration: const Duration(milliseconds: 3000),
      // backgroundColor: Colors.red,
    ));
  }
}
