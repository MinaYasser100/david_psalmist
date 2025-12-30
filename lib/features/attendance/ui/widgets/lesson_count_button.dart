import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class LessonCountButton extends StatelessWidget {
  const LessonCountButton({
    super.key,
    required this.lessonsCount,
    required this.isSelected,
    required this.onTap,
  });

  final int lessonsCount;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsTheme().primaryColor
              : ColorsTheme().primaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsTheme().primaryColor, width: 2),
        ),
        child: Center(
          child: Text(
            '$lessonsCount',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : ColorsTheme().primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
