import 'package:flutter/material.dart';
import 'package:music_ecom/app/app.dart';
import 'package:music_ecom/app/di/di.dart';
import 'package:music_ecom/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // await HiveService().clearStudentBox();

  await initDependencies();

  runApp(
    App(),
  );
}
