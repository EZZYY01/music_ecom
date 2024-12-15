import 'package:flutter/material.dart';
import 'package:music_ecom/view/dashboard_view.dart';
import 'package:music_ecom/view/login_view.dart';
import 'package:music_ecom/view/onboardingscreen_view.dart';
import 'package:music_ecom/view/signup_view.dart';

void main() {
  runApp(MaterialApp(
      home: const OnboardingscreenView(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginView(), //login
        "/signup": (context) => const SignupView(), //signup
        "/dashboard": (context) => const DashboardView(), //dashboard
      }));
}
