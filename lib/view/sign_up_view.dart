// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:twitch_app/resource/auth_method.dart';
import 'package:twitch_app/responsive/responsive.dart';
import 'package:twitch_app/view/home_view.dart';
import 'package:twitch_app/widget/app_button.dart';
import 'package:twitch_app/widget/app_textfield.dart';

import '../widget/loading_indicator.dart';

class SignUpView extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpView({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController _emailController,
      _passwordController,
      _usernameController;
  final AuthMethod _authMethod = AuthMethod();
  bool _isLoading = false;

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethod.signUp(
      context,
      _emailController.text,
      _usernameController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res) Navigator.pushReplacementNamed(context, HomeView.routeName);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : Responsive(
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      const Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTextField(controller: _emailController),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTextField(controller: _usernameController),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTextField(controller: _passwordController),
                      ),
                      const SizedBox(height: 20.0),
                      AppButton(onPressed: signUp, text: 'Sign Up'),
                    ],
                  ),
                ),
              ),
          ),
    );
  }
}
