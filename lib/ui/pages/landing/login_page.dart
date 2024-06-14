import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:group_project/ui/pages/landing/widgets/google_credentials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/or_divider.dart';
import 'package:group_project/ui/pages/landing/widgets/password_crendetials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/redirect_to.dart';
import 'package:group_project/ui/widgets/input_password_form.dart';
import 'package:group_project/ui/widgets/input_text_form.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final String? query;
  const LoginPage({super.key, this.query});
  @override
  State<LoginPage> createState() => _Login();
}

class _Login extends State<LoginPage> {
  bool isChecked = false;
  bool _showPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.query!)),
        );
      });
    }

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
                "Enter your credientials below to log in to your account",
                style: TextStyle(fontSize: 25)),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              children: [
                InputTextForm(
                  text: 'Email',
                  controller: _emailController,
                  icon: Icons.person_3_outlined,
                ),
                const SpaceY(20),
                InputPasswordForm(
                  text: 'Password',
                  controller: _passwordController,
                  showPassword: _showPassword,
                  toggleShowPassword: _toggle,
                ),
                const SpaceY(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rememberMeWidget(),
                    TextButton(
                      onPressed: () {}, // TODO: implement forgot password
                      child: Text("Forgot Password?",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ],
                ),
                const SpaceY(15),
                Consumer<UserProvider>(builder: (context, provider, _) {
                  return PasswordCredentialsButton(
                    isLoading: provider.isLoading,
                    loginOrSignupText: 'Log In',
                    onPressed: () async {
                      final res = await provider.useLoginWithPassword(
                        _emailController.text,
                        _passwordController.text,
                      );

                      // if the widget is not mounted, don't do anything
                      // this prevents memory leaks
                      if (!context.mounted) return;

                      if (res.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res.error!)),
                        );
                        return;
                      }
                      // sucesss login
                      context.pushReplacement('/home');
                    },
                  );
                }),
                const SpaceY(10),
                const OrDivider(),
                const SpaceY(10),
                Consumer<UserProvider>(builder: (context, provider, _) {
                  return GoogleCredentialsButton(
                    loginOrSignupText: 'Login',
                    onPressed: () async {
                      final res = await provider.useLoginWithGoogle();

                      // since the provider makes to rebuild the widgets,
                      // we need to check if the widget is mounted before doing anything
                      // this prevents memory leaks
                      if (!context.mounted) return;

                      if (res.error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res.error!)),
                        );
                        return;
                      }
                      // succesfull login
                      context.pushReplacement('/home');
                    },
                  );
                }),
                const SpaceY(10),
                RedirectTo(
                  messages: const ["Don't have an account?", " Sign Up"],
                  onPressed: () => context.replace('/signup'),
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }

  Widget _rememberMeWidget() {
    return Row(
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (checked) {
              setState(() {
                isChecked = checked!;
              });
            }),
        const Text("Remember me?", style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
