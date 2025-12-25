import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.whiteColor,
              theme.primaryDark.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.primaryDark.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              context.push(Routes.attendanceView, extra: student);
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Avatar with gradient and index
                  Stack(
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
                        child: Center(
                          child: Icon(
                            Icons.person_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
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
                            border: Border.all(
                              color: theme.primaryDark,
                              width: 2,
                            ),
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
                  ),
                  const SizedBox(width: 14),
                  // Student Info
                  Expanded(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
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
                  ),
                  const SizedBox(width: 10),
                  // Action Buttons
                  Row(
                    children: [
                      // Show Button
                      InkWell(
                        onTap: () {
                          context.push(
                            Routes.studentDetailsView,
                            extra: student,
                          );
                        },
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
                        onTap: () {
                          // TODO: Add edit functionality
                        },
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
                          child: Icon(
                            Icons.edit_rounded,
                            color: theme.primaryDark,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
