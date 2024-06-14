import 'package:flutter/material.dart';

import 'package:group_project/ui/widgets/space_y.dart';

class MethodDialog extends StatelessWidget {
  const MethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Material(
            child: Column(
          children: [
            const SpaceY(8),
            Center(
              child: Column(
                children: [
                  MethodBuilder(
                      title: "PayPal",
                      imagePath: "assets/core/paypal.png",
                      onPressed: () {}),
                  const SizedBox(
                    height: 5,
                  ),
                  MethodBuilder(
                      title: "Amazon Pay",
                      imagePath: "assets/core/amazon-pay.png",
                      onPressed: () {}),
                  const SizedBox(
                    height: 5,
                  ),
                  MethodBuilder(
                      title: "Credit Card",
                      imagePath: "assets/core/mastercard.png",
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class MethodBuilder extends StatelessWidget {
  const MethodBuilder(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onPressed,
      this.endIcon = true,
      this.textColor});

  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
