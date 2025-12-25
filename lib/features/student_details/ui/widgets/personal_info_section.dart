import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/section_title.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/student_info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'personalInfo'.tr()),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.badge_rounded,
          label: 'studentId'.tr(),
          value: student.studentId ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: student.sex?.toLowerCase() == 'male'
              ? Icons.male_rounded
              : Icons.female_rounded,
          label: 'gender'.tr(),
          value: student.sex ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.cake_rounded,
          label: 'birthday'.tr(),
          value: student.birthday != null
              ? DateFormat('dd/MM/yyyy').format(student.birthday!)
              : 'notAvailable'.tr(),
        ),
      ],
    );
  }
}
