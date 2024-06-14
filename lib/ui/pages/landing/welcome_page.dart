import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(children: [
          Lottie.asset("assets/core/welcome-lottie.json", width: 200, height: 200),
          Text(
            "Let's get Started!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Reserve a table, Pre-order your meals and",
             style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "make payments immediately without",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "stress!",
            textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 170, 144, 204),
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              onPressed: () => context.go('/signup'),
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
           const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 170, 144, 204),
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              onPressed: () => context.go('/login'),
              child: Text(
                "Log In",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        ]),
      )),
    );
  }
}
