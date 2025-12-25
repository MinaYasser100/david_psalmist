import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:david_psalmist/core/utils/colors.dart';

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.whiteColor,
              theme.primaryDark.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.primaryDark.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: theme.primaryDark.withValues(alpha: 0.12),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor.withValues(alpha: 0.15),
                    theme.primaryDark.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.primaryDark.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(icon, color: theme.primaryDark, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryDark.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryDark,
                    ),
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
