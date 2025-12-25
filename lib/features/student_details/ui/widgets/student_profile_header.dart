import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/psalmist_badge.dart';
import 'package:flutter/material.dart';

class StudentProfileHeader extends StatelessWidget {
  const StudentProfileHeader({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
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
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${student.firstName ?? ''} ${student.lastName ?? ''}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.primaryDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (student.isPsalmist == true) const PsalmistBadge(),
          ],
        ),
      ),
    );
  }
}
