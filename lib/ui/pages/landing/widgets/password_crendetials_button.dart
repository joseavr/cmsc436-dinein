import 'package:flutter/material.dart';

class PasswordCredentialsButton extends StatelessWidget {
  const PasswordCredentialsButton(
      {super.key,
      required this.loginOrSignupText,
      required this.onPressed,
      required this.isLoading});

  final String loginOrSignupText;
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        // style: ElevatedButton.styleFrom(
        //     backgroundColor: const Color.fromARGB(255, 170, 144, 204),
        //     side: BorderSide.none,
        //     shape: const StadiumBorder()),

        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                loginOrSignupText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
      ),
    );
  }
}
