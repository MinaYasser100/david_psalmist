import 'package:flutter/material.dart';

class ColorsTheme {
  // Private constructor to prevent external instantiation
  ColorsTheme._();

  // Static instance of the class
  static final ColorsTheme _instance = ColorsTheme._();

  // Factory constructor to return the same instance
  factory ColorsTheme() => _instance;

  // Primary color (Gold) and its shades
  final primaryColor = const Color(0xFFFFD700); // Gold
  final primaryLight = const Color(0xFFFFE766); // Light Gold
  final primaryDark = const Color(0xFFB8860B); // Dark Goldenrod

  // Secondary color (Red) and its shades
  final secondaryColor = const Color(0xFFE53935); // Red
  final secondaryLight = const Color(0xFFFF6F60); // Light Red
  final secondaryDark = const Color(0xFFAB000D); // Dark Red

  // Accent color (ممكن تسيبه أو تغيره على حسب احتياجك)
  final accentColor = const Color(0xFF27AE60); // Soft Green

  // Neutral colors
  final whiteColor = Colors.white;
  final backgroundColor = const Color(0xFFF5F7FA); // Light Grayish Blue
  final cardColor = Colors.white;
  final grayWhite = const Color(0xFFB0B0B0); // Grayish White
  // Error color
  final errorColor = Colors.red;
}
