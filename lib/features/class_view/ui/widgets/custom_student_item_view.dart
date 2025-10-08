import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomStudentItemView extends StatelessWidget {
  const CustomStudentItemView({
    super.key,
    required this.theme,
    required this.index,
    required this.student,
  });

  final ColorsTheme theme;
  final int index;
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.primaryDark.withValues(alpha: 0.05),
              theme.primaryDark.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: theme.primaryDark.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            // circular icon with index
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryDark.withValues(alpha: 0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.styleBold24sp(
                    context,
                  ).copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${student.firstName} ${student.lastName}',
                    style: AppTextStyles.styleBold22sp(
                      context,
                    ).copyWith(color: theme.primaryDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_turned_in_outlined,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${"Attendance:".tr()} ${student.attendanceCount}',
                        style: AppTextStyles.styleMedium18sp(
                          context,
                        ).copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.edit_outlined, color: theme.primaryDark, size: 28),
          ],
        ),
      ),
    );
  }
}
