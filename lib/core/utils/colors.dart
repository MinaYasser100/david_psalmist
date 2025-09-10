import 'package:flutter/material.dart';

class ColorsTheme {
  // Private constructor to prevent external instantiation
  ColorsTheme._();

  // Static instance of the class
  static final ColorsTheme _instance = ColorsTheme._();

  // Factory constructor to return the same instance
  factory ColorsTheme() => _instance;

  // Primary color and its shades
  final primaryColor = const Color(0xFF4A90E2); // Azure Blue
  final primaryLight = const Color(0xFF7ABAF2); // Light Blue
  final primaryDark = const Color(0xFF2E4374); // Dark Blue

  // Accent color for highlights
  final accentColor = const Color(0xFF27AE60); // Soft Green

  // Neutral colors
  final whiteColor = Colors.white;
  final backgroundColor = const Color(0xFFF5F7FA); // Light Grayish Blue
  final cardColor = Colors.white;

  // Error color
  final errorColor = Colors.red;
}
