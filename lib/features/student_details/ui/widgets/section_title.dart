import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return FadeInLeft(
      duration: const Duration(milliseconds: 500),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: theme.primaryDark,
        ),
      ),
    );
  }
}
