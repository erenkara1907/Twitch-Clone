import 'package:flutter/material.dart';
import 'package:twitch_app/responsive/responsive.dart';
import 'package:twitch_app/view/login_view.dart';
import 'package:twitch_app/view/sign_up_view.dart';
import 'package:twitch_app/widget/app_button.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome \nto Twitch',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginView.routeName),
                  text: 'Log In',
                ),
              ),
              AppButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SignUpView.routeName),
                text: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
