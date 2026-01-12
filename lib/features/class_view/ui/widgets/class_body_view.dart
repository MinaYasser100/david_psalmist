import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_student_item.dart';

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

              return FadeInRight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      cubit.toggleStudentSelection(student.studentId!);
                    },
                    child: Stack(
                      children: [
                        // Student Item
                        CustomStudentItem(
                          student: student,
                          index: index,
                          classModel: classModel,
                          isSelectionMode: true,
                        ),
                        // Checkbox Circle on top right
                        Positioned(
                          top: 8,
                          right: 8,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? ColorsTheme().primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? ColorsTheme().primaryColor
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        // Normal Mode
        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
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
          },
        );
      },
    );
  }
}
