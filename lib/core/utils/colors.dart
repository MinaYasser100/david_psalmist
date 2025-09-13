import 'package:flutter/material.dart';

class ColorsTheme {
  // Private constructor to prevent external instantiation
  ColorsTheme._();

  // Static instance of the class
  static final ColorsTheme _instance = ColorsTheme._();

  // Factory constructor to return the same instance
  factory ColorsTheme() => _instance;

  // Primary color (Rich Red from the robe)
  final primaryColor = const Color(0xFFC0392B); // Deep Red
  final primaryLight = const Color(0xFFE74C3C); // Light Red
  final primaryDark = const Color(0xFF922B21); // Dark Red

  // Secondary color (Blue from the background and robe)
  final secondaryColor = const Color(0xFF3498DB); // Soft Blue
  final secondaryLight = const Color(0xFF5DADE2); // Light Blue
  final secondaryDark = const Color(0xFF2874A6); // Dark Blue

  // Accent color (Gold from the crown and harp)
  final accentColor = const Color(0xFFD4A017); // Warm Gold
  final accentLight = const Color(0xFFF1C40F); // Light Gold
  final accentDark = const Color(0xFF9B7A00); // Dark Gold

  // Neutral colors (Beige and White from the halo)
  final whiteColor = Colors.white;
  final backgroundColor = const Color(0xFFF5F1E9); // Soft Beige
  final cardColor = const Color(0xFFFAF7F2); // Light Beige
  final grayWhite = const Color(0xFFD3C9B7); // Warm Gray

  // Error color
  final errorColor = const Color(0xFFD32F2F); // Vibrant Red for errors
}
