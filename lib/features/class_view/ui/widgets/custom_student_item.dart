import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/widgets/custom_alert_dialoge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'custom_student_item_view.dart';

class CustomStudentItem extends StatelessWidget {
  const CustomStudentItem({
    super.key,
    required this.student,
    required this.index,
  });

  final StudentModel student;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = ColorsTheme();
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
              title: "Delete Class".tr(),
              content: "Are you sure you want to delete this class?".tr(),
              nameOfNegativeButton: 'No'.tr(),
              nameOfPositiveButton: 'Yes'.tr(),
              onNegativeButtonPressed: () => Navigator.of(context).pop(false),
              onPositiveButtonPressed: () => Navigator.of(context).pop(true),
            ),
          );
          return result ?? false;
        },
        onDismissed: (direction) {
          //final cubit = context.read<StudentsClassCubit>();
          // // remove from local list first
          // cubit.classes.removeWhere((c) => c.id == classModel.id);
          // // then delete from remote
          // cubit.deleteClass(classModel: classModel);
          // showSuccessToast(
          //   context,
          //   'Success'.tr(),
          //   "Class deleted successfully".tr(),
          // );
        },
        child: CustomStudentItemView(
          theme: theme,
          index: index,
          student: student,
        ),
      ),
    );
  }
}
