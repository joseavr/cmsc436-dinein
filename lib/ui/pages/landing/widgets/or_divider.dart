import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 0.8,
          ),
        ),
        Text("OR", style: Theme.of(context).textTheme.bodyLarge),
        const Expanded(
            child: Divider(
          thickness: 0.8,
        ))
      ],
    );
  }
}
