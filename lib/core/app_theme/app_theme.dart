import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat Regular',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.deepPurple,
      elevation: 4,
      shadowColor: Colors.pink,
      titleTextStyle: TextStyle(
          fontSize: 16, color: Colors.white, fontFamily: 'Montserrat Bold'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat Bold'),
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: Colors.white),
    ),
  );
}
