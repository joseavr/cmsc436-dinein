import 'package:flutter/material.dart';

class GoogleCredentialsButton extends StatelessWidget {
  const GoogleCredentialsButton({
    super.key,
    required this.loginOrSignupText,
    required this.onPressed,
  });

  final String loginOrSignupText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        // style: OutlinedButton.styleFrom(
        //     backgroundColor: const Color.fromARGB(255, 226, 226, 226),
        //     side: BorderSide.none,
        //     shape: const StadiumBorder()),
        onPressed: onPressed,
        icon: Container(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              "assets/core/google.png",
              width: 20,
            )),
        label: Text(
          '$loginOrSignupText with Google',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
