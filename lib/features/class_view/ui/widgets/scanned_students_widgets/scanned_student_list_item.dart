import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:flutter/material.dart';

class ScannedStudentListItem extends StatelessWidget {
  const ScannedStudentListItem({
    super.key,
    required this.student,
    required this.index,
    required this.onDismissed,
  });

  final StudentModel student;
  final int index;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      delay: Duration(milliseconds: index * 50),
      child: Dismissible(
        key: Key(student.studentId!),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 28,
          ),
        ),
        onDismissed: (direction) => onDismissed(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorsTheme().primaryColor.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorsTheme().primaryColor.withOpacity(0.1),
                child: Text(
                  (student.firstName?.isNotEmpty == true
                      ? student.firstName![0].toUpperCase()
                      : 'S'),
                  style: TextStyle(
                    color: ColorsTheme().primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${student.firstName ?? ''} ${student.lastName ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      student.phomeNumber ?? 'N/A',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: ColorsTheme().primaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
