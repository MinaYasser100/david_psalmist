import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/core/utils/show_top_toast.dart';
import 'package:david_psalmist/features/class_view/manager/students_class_cubit/students_class_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_student_item.dart';

class ClassBodyView extends StatelessWidget {
  const ClassBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsClassCubit, StudentsClassState>(
      listener: (context, state) {
        if (state is StudentsClassError) {
          showErrorToast(context, 'Error'.tr(), state.message);
        }
      },
      builder: (context, state) {
        final students = context.read<StudentsClassCubit>().students;
        if (state is StudentsClassLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StudentsClassLoaded) {
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
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return GestureDetector(
                onTap: () {
                  context.push(Routes.attendanceView, extra: student);
                },
                child: CustomStudentItem(student: student, index: index),
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return FadeInRight(
                child: GestureDetector(
                  onTap: () {
                    context.push(Routes.attendanceView, extra: student);
                  },
                  child: CustomStudentItem(student: student, index: index),
                ),
              );
            },
          );
        }
      },
    );
  }
}
