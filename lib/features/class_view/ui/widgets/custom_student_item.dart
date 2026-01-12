import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_student_item_view.dart';

class CustomStudentItem extends StatelessWidget {
  const CustomStudentItem({
    super.key,
    required this.student,
    required this.index,
    required this.classModel,
    this.isSelectionMode = false,
  });

  final StudentModel student;
  final int index;
  final ClassModel classModel;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();

    // If in selection mode, don't show dismissible
    if (isSelectionMode) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: CustomStudentItemView(
          theme: theme,
          index: index,
          student: student,
          classModel: classModel,
        ),
      );
    }

    // Normal mode with dismissible
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Dismissible(
        key: Key(student.studentId!),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          final result = await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomAlertDialog(
              title: "Delete Student".tr(),
              content: "Are you sure you want to delete this student?".tr(),
              nameOfNegativeButton: 'No'.tr(),
              nameOfPositiveButton: 'Yes'.tr(),
              onNegativeButtonPressed: () => Navigator.of(context).pop(false),
              onPositiveButtonPressed: () => Navigator.of(context).pop(true),
            ),
          );
          return result ?? false;
        },
        onDismissed: (direction) {
          final cubit = context.read<StudentsClassCubit>();
          cubit.deleteStudent(student);
          showSuccessToast(
            context,
            'Success'.tr(),
            "Student deleted successfully".tr(),
          );
        },
        child: CustomStudentItemView(
          theme: theme,
          index: index,
          student: student,
          classModel: classModel,
        ),
      ),
    );
  }
}
