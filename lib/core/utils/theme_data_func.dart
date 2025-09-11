import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeDataFunc() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsTheme().whiteColor,
    primaryColor: ColorsTheme().primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsTheme().primaryColor,
      brightness: Brightness.light,
      onPrimary: ColorsTheme().whiteColor,
      secondary: ColorsTheme().secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsTheme().primaryDark,
      foregroundColor: ColorsTheme().whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ColorsTheme().whiteColor,
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsTheme().primaryColor,
      foregroundColor: ColorsTheme().whiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsTheme().primaryColor,
        foregroundColor: ColorsTheme().whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    useMaterial3: true,
  );
}
