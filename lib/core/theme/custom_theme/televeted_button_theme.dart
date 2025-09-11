import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';

abstract class TElevatedButtonTheme {
  const TElevatedButtonTheme._();

  /// Light Theme
  static final ElevatedButtonThemeData lightElevatedButtonTheme =
  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      elevation: 0, // minimal shadow
    ),
  );

  /// Dark theme Instagram-style button
  static final ElevatedButtonThemeData darkElevatedButtonTheme =
  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      elevation: 0,
    ),
  );
}