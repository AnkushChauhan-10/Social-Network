import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  // Light Theme
  static const Color lightBackground = Colors.white;
  static const Color lightBackgroundSecondary = Color(0xFFFAFAFA);
  static const Color lightText = Colors.black;
  static const Color lightGrey = Color(0xFF999999);

  // Dark Theme
  static const Color darkBackground = Colors.black;
  static const Color darkBackgroundSecondary = Color(0xFF121212);
  static const Color darkText = Colors.white;
  static const Color darkGrey = Color(0xFF999999);

  // Primary
  static const Color primaryBlue = Color(0xFF3797EF);

  // Gradient
  static const LinearGradient instaGradient = LinearGradient(
    colors: [
      Color(0xFFF58529),
      Color(0xFFDD2A7B),
      Color(0xFF8134AF),
      Color(0xFF515BD4),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
