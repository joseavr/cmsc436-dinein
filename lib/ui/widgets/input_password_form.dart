import 'package:flutter/material.dart';
import 'package:group_project/providers/theme.provider.dart';
import 'package:provider/provider.dart';

class InputPasswordForm extends StatelessWidget {
  const InputPasswordForm({
    super.key,
    required this.text,
    this.icon,
    required this.controller,
    required this.showPassword,
    required this.toggleShowPassword,
  });

  final String text;
  final IconData? icon;
  final TextEditingController controller;
  final bool showPassword;
  final void Function() toggleShowPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: showPassword,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(width: 2, color: Colors.black)),
        label: Text(text),
        prefixIcon: const Icon(Icons.fingerprint),
        suffixIcon: IconButton(
          icon: Icon(
            showPassword
                ? Icons.remove_red_eye_sharp
                : Icons.remove_red_eye_outlined,
          ),
          onPressed: toggleShowPassword,
        ),
      ),
    );
  }
}
