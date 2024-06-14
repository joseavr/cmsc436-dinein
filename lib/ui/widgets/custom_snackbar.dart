import 'package:flutter/material.dart';

showKwunSnackBar(
    {required BuildContext context,
    required String message,
    Color color = Colors.red}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 5000),
  ));
}
