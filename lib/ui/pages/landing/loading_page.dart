import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // quick and dirty way to wait for the widget to mount
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) {
      return;
    }

    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      context.pushReplacement('/home');
    } else {
      context.pushReplacement('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset('assets/logo/dinein-logo-light.png'), //TODO change logo depending on theme
        ),
      ),
    );
  }
}
