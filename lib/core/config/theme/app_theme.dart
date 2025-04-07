import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.background_white,
    scaffoldBackgroundColor: AppColors.background_white,
    fontFamily: 'Inter',
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      contentPadding: EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black, width: 0.5),
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),


  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.background_black,
    scaffoldBackgroundColor: AppColors.background_black,
    fontFamily: 'Inter',
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      contentPadding: EdgeInsets.all(20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white, width: 0.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.white, width: 0.5),
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),
  );
}
