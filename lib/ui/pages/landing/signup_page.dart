import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:group_project/providers/user.provider.dart';
import 'package:group_project/ui/pages/landing/widgets/google_credentials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/or_divider.dart';
import 'package:group_project/ui/pages/landing/widgets/password_crendetials_button.dart';
import 'package:group_project/ui/pages/landing/widgets/redirect_to.dart';
import 'package:group_project/ui/pages/landing/widgets/term_and_policy_checkbox.dart';
import 'package:group_project/ui/widgets/input_password_form.dart';
import 'package:group_project/ui/widgets/input_text_form.dart';
import 'package:group_project/ui/widgets/space_y.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUp();
}

class _SignUp extends State<SignUpPage> {
  bool _isChecked = false;
  bool _showPassword = true;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toogleCheck(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text("Enter your credientials below to create an account",
                  style: TextStyle(fontSize: 25)),
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  InputTextForm(
                    controller: _fullnameController,
                    text: 'Enter your Full Name',
                    icon: Icons.person_3_outlined,
                  ),
                  const SpaceY(20),
                  InputTextForm(
                    controller: _emailController,
                    text: 'Email',
                    icon: Icons.email,
                  ),
                  const SpaceY(20),
                  InputPasswordForm(
                      text: 'Password',
                      controller: _passwordController,
                      showPassword: _showPassword,
                      toggleShowPassword: _toggle),
                  const SpaceY(10),
                  TermAndPolicyCheckBox(
                    isChecked: _isChecked,
                    onChanged: _toogleCheck,
                  ),
                  const SpaceY(10),
                  Consumer<UserProvider>(builder: (context, provider, _) {
                    return PasswordCredentialsButton(
                      isLoading: provider.isLoading,
                      loginOrSignupText: 'Sign Up',
                      onPressed: () async {
                        if (!_isChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please accept the terms and policy')),
                          );
                          return;
                        }

                        final res = await provider.useSignUpWithPassword(
                            _fullnameController.text,
                            _emailController.text,
                            _passwordController.text);

                        if (!context.mounted || !mounted) return;

                        if (res.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res.error!)),
                          );
                          return;
                        }
                        // successful singup
                        context.pushReplacementNamed(
                          'login',
                          queryParameters: {
                            'email':
                                'Please confirm your email at ${_emailController.text}',
                          },
                        );
                      },
                    );
                  }),
                  const SpaceY(10),
                  const OrDivider(),
                  const SpaceY(10),
                  GoogleCredentialsButton(
                    loginOrSignupText: 'Sign up',
                    onPressed: () async {
                      final res = await userProvider.useLoginWithGoogle();

                      // if the widget is not mounted, don't do anything
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
                  ),
                  const SpaceY(10),
                  RedirectTo(
                    messages: const ['Already have an account?', ' Log in'],
                    onPressed: () => context.replace('/login'),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
