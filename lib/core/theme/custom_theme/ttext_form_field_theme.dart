import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';

abstract class TTextFormFieldTheme {
  const TTextFormFieldTheme._();

  /// Light theme Instagram-style input
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightBackgroundSecondary, // light grey background
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.lightGrey,width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.lightGrey,width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.lightGrey, width: 1.5),
    ),
    hintStyle: TextStyle(color: AppColors.lightGrey),
  );

  /// Dark theme Instagram-style input
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkBackgroundSecondary, // dark grey background
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.darkGrey,width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.darkGrey,width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.darkGrey, width: 1.5),
    ),
    hintStyle: TextStyle(color: AppColors.darkGrey),
  );
}