import 'package:flutter/material.dart';
import 'package:social_network/core/constants/app_color.dart';
import 'package:social_network/core/theme/custom_theme/tapp_bar_theme.dart';
import 'package:social_network/core/theme/custom_theme/tcard_theme.dart';
import 'package:social_network/core/theme/custom_theme/televeted_button_theme.dart';
import 'package:social_network/core/theme/custom_theme/ttext_form_field_theme.dart';
import 'package:social_network/core/theme/custom_theme/ttext_theme.dart';

class AppTheme {
  AppTheme._();

  /// 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    cardTheme: TCardTheme.lightCardTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,

    // Extra normal values
    iconTheme: const IconThemeData(color: AppColors.lightText),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBackground,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.lightGrey,
      showUnselectedLabels: true,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightGrey,
      thickness: 1,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.primaryBlue,
      contentTextStyle: TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    ),
  );

  /// 🌚 Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    cardTheme: TCardTheme.darkCardTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,

    // Extra normal values
    iconTheme: const IconThemeData(color: AppColors.darkText),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.primaryBlue,
      unselectedItemColor: AppColors.darkGrey,
      showUnselectedLabels: true,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkGrey,
      thickness: 1,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.primaryBlue,
      contentTextStyle: TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
