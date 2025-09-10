import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeDataFunc() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsTheme().whiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsTheme().primaryColor),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsTheme().primaryColor,
      foregroundColor: ColorsTheme().whiteColor,
    ),
    useMaterial3: true,
  );
}
