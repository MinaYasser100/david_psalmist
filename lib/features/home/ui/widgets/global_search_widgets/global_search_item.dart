import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlobalSearchItem extends StatelessWidget {
  const GlobalSearchItem({
    super.key,
    required this.student,
    required this.index,
  });

  final StudentModel student;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return FadeInUp(
      duration: Duration(milliseconds: 200 + (index * 50)),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () => _navigateToStudentDetails(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    '${index + 1}',
                    style: AppTextStyles.styleMedium16sp(
                      context,
                    ).copyWith(color: theme.primaryColor),
                  ),
                ),
                const SizedBox(width: 16),
                // Student Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${student.firstName ?? ''} ${student.lastName ?? ''}',
                        style: AppTextStyles.styleMedium16sp(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        icon: Icons.class_outlined,
                        text: student.className ?? 'N/A',
                        context: context,
                      ),
                      const SizedBox(height: 2),
                      _buildInfoRow(
                        icon: Icons.school_outlined,
                        text: student.levelName ?? 'N/A',
                        context: context,
                      ),
                    ],
                  ),
                ),
                // Arrow
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.styleRegular14sp(
              context,
            ).copyWith(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _navigateToStudentDetails(BuildContext context) {
    context.push(Routes.studentDetailsView, extra: student);
  }
}
