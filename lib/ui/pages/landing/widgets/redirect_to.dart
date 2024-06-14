import 'package:flutter/material.dart';

class RedirectTo extends StatelessWidget {
  const RedirectTo(
      {super.key, required this.messages, required this.onPressed});

  final void Function() onPressed;
  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text.rich(TextSpan(
            text: messages[0],
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: messages[1],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.redAccent),
              )
            ])));
  }
}
