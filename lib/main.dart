// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_app/model/user_model.dart';
import 'package:twitch_app/provider/user_provider.dart';
import 'package:twitch_app/resource/auth_method.dart';
import 'package:twitch_app/utils/color.dart';
import 'package:twitch_app/view/home_view.dart';
import 'package:twitch_app/view/login_view.dart';
import 'package:twitch_app/view/onboarding_view.dart';
import 'package:twitch_app/view/sign_up_view.dart';
import 'package:twitch_app/widget/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDDXju6HeZ6lEWTFcVgam8_C6N9r9o5PKs",
        authDomain: "twitch-app-18239.firebaseapp.com",
        projectId: "twitch-app-18239",
        storageBucket: "twitch-app-18239.appspot.com",
        messagingSenderId: "409785424746",
        appId: "1:409785424746:web:b124f589887e2ade762313",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitch Clone',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: backgroundColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
        ),
      ),
      routes: {
        OnboardingView.routeName: (context) => const OnboardingView(),
        LoginView.routeName: (context) => const LoginView(),
        SignUpView.routeName: (context) => const SignUpView(),
        HomeView.routeName: (context) => const HomeView(),
      },
      home: FutureBuilder(
        future: AuthMethod()
            .getCurrentUser(FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.uid
                : null)
            .then((value) {
          if (value != null) {
            Provider.of<UserProvider>(context, listen: false).setUser(
              UserModel.fromMap(value),
            );
          }
          return value;
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const LoadingIndicator();
          if (snapshot.hasData) return const HomeView();
          return const OnboardingView();
        },
      ),
    );
  }
}
