import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/class_body_widgets/normal_mode_student_item.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/class_body_widgets/selection_mode_student_item.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassBodyView extends StatelessWidget {
  const ClassBodyView({super.key, required this.classModel});

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsClassCubit, StudentsClassState>(
      listener: (context, state) {
        if (state is StudentsClassError) {
          showErrorToast(context, 'Error'.tr(), state.message);
        } else if (state is StudentsClassBatchAttendanceSuccess) {
          showSuccessToast(context, 'Success'.tr(), state.message);
        } else if (state is StudentsClassBatchAttendanceError) {
          showErrorToast(context, 'Error'.tr(), state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<StudentsClassCubit>();
        final students = cubit.students;

        if (state is StudentsClassLoading ||
            state is StudentsClassBatchAttendanceSubmitting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (students.isEmpty) {
          return Center(
            child: Text(
              'Add new students to get started!'.tr(),
              style: AppTextStyles.styleBold20sp(
                context,
              ).copyWith(color: ColorsTheme().primaryDark),
            ),
          );
        }

        // Selection Mode
        if (state is StudentsClassSelectionMode) {
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              final isSelected = state.selectedStudentIds.contains(
                student.studentId,
              );

              return SelectionModeStudentItem(
                student: student,
                index: index,
                classModel: classModel,
                isSelected: isSelected,
                onTap: () {
                  cubit.toggleStudentSelection(student.studentId!);
                },
              );
            },
          );
        }

        // Normal Mode
        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return NormalModeStudentItem(
              student: student,
              index: index,
              classModel: classModel,
            );
          },
        );
      },
    );
  }
}
