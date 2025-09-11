import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/constants/app_size.dart';

abstract class TAppBarTheme {
  const TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.lightText),
    titleTextStyle: TextStyle(
      color: AppColors.lightText,
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.bold,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.darkText),
    titleTextStyle: TextStyle(
      color: AppColors.darkText,
      fontSize: AppFontSizes.lg,
      fontWeight: FontWeight.bold,
    ),
  );
}
