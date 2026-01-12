import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class StudentActionButtons extends StatelessWidget {
  const StudentActionButtons({
    super.key,
    required this.onViewTap,
    required this.onEditTap,
  });

  final VoidCallback onViewTap;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return Row(
      children: [
        // Show Button
        InkWell(
          onTap: onViewTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryDark.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: theme.primaryDark.withValues(alpha: 0.15),
              ),
            ),
            child: Icon(
              Icons.visibility_rounded,
              color: theme.primaryDark,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Edit Button
        InkWell(
          onTap: onEditTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withValues(alpha: 0.15),
                  theme.primaryDark.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: theme.primaryDark.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(Icons.edit_rounded, color: theme.primaryDark, size: 20),
          ),
        ),
      ],
    );
  }
}
