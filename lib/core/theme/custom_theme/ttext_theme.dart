import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';

abstract class TTextTheme {
  const TTextTheme._();

  static final lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: AppFontSizes.xxxl,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    ),
    displayMedium: TextStyle(
      fontSize: AppFontSizes.xxl,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
    displaySmall: TextStyle(
      fontSize: AppFontSizes.xl,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
    ),
    headlineMedium: TextStyle(
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
    headlineSmall: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
    ),
    titleLarge: TextStyle(
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
    bodyLarge: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.normal,
      color: AppColors.lightText,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.normal,
      color: AppColors.lightGrey,
    ),
    labelLarge: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryBlue,
    ),
  );

  /// Dark Theme Text Styles
  static final darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: AppFontSizes.xxxl,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
    ),
    displayMedium: TextStyle(
      fontSize: AppFontSizes.xxl,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
    displaySmall: TextStyle(
      fontSize: AppFontSizes.xl,
      fontWeight: FontWeight.w500,
      color: AppColors.darkText,
    ),
    headlineMedium: TextStyle(
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
    headlineSmall: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.w500,
      color: AppColors.darkText,
    ),
    titleLarge: TextStyle(
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
    bodyLarge: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.normal,
      color: AppColors.darkText,
    ),
    bodyMedium: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.normal,
      color: AppColors.darkGrey,
    ),
    labelLarge: TextStyle(
      fontSize: AppFontSizes.md,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryBlue,
    ),
  );
}
