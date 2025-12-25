import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/section_title.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/student_info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'contactInfo'.tr()),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.phone_rounded,
          label: 'phone'.tr(),
          value: student.phomeNumber ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.phone_in_talk_rounded,
          label: 'parentNumber'.tr(),
          value: student.parentNumber ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.person_outline_rounded,
          label: 'fatherName'.tr(),
          value: student.studentFather ?? 'notAvailable'.tr(),
        ),
        const SizedBox(height: 12),
        StudentInfoCard(
          icon: Icons.location_on_rounded,
          label: 'address'.tr(),
          value: student.address ?? 'notAvailable'.tr(),
          maxLines: 3,
        ),
      ],
    );
  }
}
