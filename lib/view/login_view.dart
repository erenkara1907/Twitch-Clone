// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:twitch_app/resource/auth_method.dart';
import 'package:twitch_app/responsive/responsive.dart';
import 'package:twitch_app/view/home_view.dart';
import 'package:twitch_app/widget/loading_indicator.dart';

import '../widget/app_button.dart';
import '../widget/app_textfield.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/login';
  const LoginView({Key? key}) : super(key: key);
  @override
// ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController, _passwordController;
  final AuthMethod _authMethod = AuthMethod();

  bool _isLoading = false;

  login() async {
    setState(() {
      _isLoading = true;
    });
    bool res = await _authMethod.logIn(
        context, _emailController.text, _passwordController.text);

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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
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
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppTextField(controller: _passwordController),
                      ),
                      const SizedBox(height: 20.0),
                      AppButton(onPressed: login, text: 'Log In'),
                    ],
                  ),
                ),
              ),
          ),
    );
  }
}
