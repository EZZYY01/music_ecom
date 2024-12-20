import 'package:flutter/material.dart';
import 'package:music_ecom/core/app_theme/theme.dart';
import 'package:music_ecom/view/onboardingscreen_view.dart';
import 'package:music_ecom/view/signup_view.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      // Initial route
      routes: {
        '/': (context) => const OnboardingScreenView(),
        '/signup': (context) => const SignupView()
      },
    );
  }
}
