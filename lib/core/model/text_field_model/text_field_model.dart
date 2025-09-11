import 'package:flutter/material.dart';

class TextFieldModel {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  void Function(String)? onFieldSubmitted;
  bool autofocus;
  final String? errorText;
  TextFieldModel({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.hintText,
    required this.icon,
    required this.validator,
    this.obscureText = false,
    this.autovalidateMode,
    this.focusNode,
    this.autofocus = false,
    this.onFieldSubmitted,
    this.errorText,
  });
}
