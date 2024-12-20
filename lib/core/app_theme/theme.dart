import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.blueGrey[900],
        elevation: 4,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        )),
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Montserrat Bold',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
