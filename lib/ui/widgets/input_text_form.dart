import 'package:flutter/material.dart';

class InputTextForm extends StatelessWidget {
  const InputTextForm({
    super.key,
    required this.text,
    this.icon,
    required this.controller,
  });

  final String text;
  final IconData? icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(width: 2, color: Colors.black)),
        label: Text(text),
        prefixIcon: Icon(
          icon,
        ),
      ),
    );
  }
}
