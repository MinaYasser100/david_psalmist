import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/class_info_section.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/contact_info_section.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/personal_info_section.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/student_profile_header.dart';
import 'package:flutter/material.dart';

class StudentDetailsBody extends StatelessWidget {
  const StudentDetailsBody({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentProfileHeader(student: student),
          const SizedBox(height: 32),
          PersonalInfoSection(student: student),
          const SizedBox(height: 24),
          ContactInfoSection(student: student),
          const SizedBox(height: 24),
          ClassInfoSection(student: student),
        ],
      ),
    );
  }
}
