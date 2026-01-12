import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NormalModeStudentItem extends StatelessWidget {
  const NormalModeStudentItem({
    super.key,
    required this.student,
    required this.index,
    required this.classModel,
  });

  final StudentModel student;
  final int index;
  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: GestureDetector(
        onTap: () {
          context.push(Routes.attendanceView, extra: student);
        },
        child: CustomStudentItem(
          student: student,
          index: index,
          classModel: classModel,
          isSelectionMode: false,
        ),
      ),
    );
  }
}
