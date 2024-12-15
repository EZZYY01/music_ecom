import 'package:flutter/material.dart';

class OnboardingscreenView extends StatefulWidget {
  const OnboardingscreenView({super.key});

  @override
  State<OnboardingscreenView> createState() => _OnboardingscreenViewState();
}

class _OnboardingscreenViewState extends State<OnboardingscreenView> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'version : 1.0.0',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: size.height * 0.02,
              left: 0,
              right: 0,
              child: Text(
                'Developed by: Manish',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
