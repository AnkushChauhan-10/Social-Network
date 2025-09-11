import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';

abstract class TCardTheme {
  const TCardTheme._();

  /// Light Theme
  static final lightCardTheme = CardThemeData(
    color: AppColors.lightBackground,
    elevation: 2,
    margin: const EdgeInsets.all(AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
    shadowColor: Colors.black.withOpacity(0.1),
  );

  /// Dark Theme
  static final darkCardTheme = CardThemeData(
    color: AppColors.darkBackground,
    elevation: 2,
    margin: const EdgeInsets.all(AppSizes.md),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
    shadowColor: Colors.white.withOpacity(0.1),
  );
}
