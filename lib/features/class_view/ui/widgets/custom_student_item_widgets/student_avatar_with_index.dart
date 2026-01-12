import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class StudentAvatarWithIndex extends StatelessWidget {
  const StudentAvatarWithIndex({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [theme.primaryColor, theme.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.primaryDark.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.person_rounded, size: 30, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: theme.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: theme.primaryDark, width: 2),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: theme.primaryDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
