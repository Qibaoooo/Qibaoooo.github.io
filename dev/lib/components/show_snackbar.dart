import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';

void showSnackbar({context, message = String, isAlert = false}) {
  var snackBar = SnackBar(
    margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
    behavior: SnackBarBehavior.floating,
    elevation: 8.0,
    content: Text(
      message,
      style: const TextStyle(color: kClimbjioBrown900),
    ),
    backgroundColor: isAlert ? Colors.amber : kClimbjioPink100,
    duration: const Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
