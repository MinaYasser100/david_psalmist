import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/student_details/ui/widgets/student_details_body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('studentDetails'.tr()),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: StudentDetailsBody(student: student),
    );
  }
}
