import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StudentInfoSection extends StatelessWidget {
  const StudentInfoSection({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            '${student.firstName} ${student.lastName}',
            style: AppTextStyles.styleBold22sp(context).copyWith(
              color: theme.primaryDark,
              fontSize: 18,
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // Attendance Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withValues(alpha: 0.15),
                  theme.primaryDark.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryDark.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: theme.primaryDark,
                ),
                const SizedBox(width: 5),
                Text(
                  '${"Attendance:".tr()} ${student.attendanceCount}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryDark,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
