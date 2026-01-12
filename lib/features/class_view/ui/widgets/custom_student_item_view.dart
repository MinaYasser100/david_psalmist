import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/routing/routes.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/add_student_bottom_sheet.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item_widgets/student_action_buttons.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item_widgets/student_avatar_with_index.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/custom_student_item_widgets/student_info_section.dart';
import 'package:david_psalmist/features/classes/data/model/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomStudentItemView extends StatelessWidget {
  const CustomStudentItemView({
    super.key,
    required this.theme,
    required this.index,
    required this.student,
    required this.classModel,
  });

  final ColorsTheme theme;
  final int index;
  final StudentModel student;
  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.whiteColor,
              theme.primaryDark.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.primaryDark.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: theme.primaryDark.withValues(alpha: 0.12),
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              context.push(Routes.attendanceView, extra: student);
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  StudentAvatarWithIndex(index: index),
                  const SizedBox(width: 14),
                  StudentInfoSection(student: student),
                  const SizedBox(width: 10),
                  StudentActionButtons(
                    onViewTap: () {
                      context.push(Routes.studentDetailsView, extra: student);
                    },
                    onEditTap: () => _showEditStudentBottomSheet(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditStudentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ScannerCubit>(),
        child: AddStudentBottomSheet(
          classModel: classModel,
          levelName: classModel.levelName ?? 'Unknown Level',
          studentModel: student,
        ),
      ),
    );
  }
}
