import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ecom/app/di/di.dart';
import 'package:music_ecom/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:music_ecom/features/splash/presentation/view/onboardingscreen_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Management',
      home: BlocProvider.value(
        value: getIt<LoginBloc>(),
        child: OnboardingScreenView(),
      ),
    );
  }
}
