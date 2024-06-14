import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermAndPolicyCheckBox extends StatelessWidget {
  const TermAndPolicyCheckBox(
      {super.key, required this.isChecked, this.onChanged});

  final bool isChecked;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "I accept the ",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color)),
          TextSpan(
              text: " terms and privacy policy",
              style: const TextStyle(color: Colors.red),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const TermAndPolicyDialog();
                      });
                })
        ]))
      ],
    );
  }
}

class TermAndPolicyDialog extends StatelessWidget {
  const TermAndPolicyDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Center(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("You are in the Terrm And Policy page")],
          )),
        ));
  }
}
