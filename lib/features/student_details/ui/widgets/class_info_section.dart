import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/section_title.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/student_info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ClassInfoSection extends StatelessWidget {
  const ClassInfoSection({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'classInfo'.tr()),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.class_rounded,
          label: 'level'.tr(),
          value: student.levelName ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.group_rounded,
          label: 'class'.tr(),
          value: student.className ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.check_circle_rounded,
          label: 'attendanceCount'.tr(),
          value: '${student.attendanceCount ?? 0}',
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.calendar_today_rounded,
          label: 'createdAt'.tr(),
          value: student.createdAt != null
              ? DateFormat('dd/MM/yyyy').format(student.createdAt!)
              : 'notAvailable'.tr(),
        ),
      ],
    );
  }
}
