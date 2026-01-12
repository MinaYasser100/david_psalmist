import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/class_view/manager/scanner_cubit/scanner_cubit.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanned_students_widgets/scanned_student_list_item.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanned_students_widgets/scanned_students_empty_state.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanned_students_widgets/scanned_students_handle.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanned_students_widgets/scanned_students_header.dart';
import 'package:david_psalmist/features/class_view/ui/widgets/scanned_students_widgets/scanned_students_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannedStudentsBottomSheet extends StatelessWidget {
  final List<StudentModel> students;

  const ScannedStudentsBottomSheet({super.key, required this.students});

  static void show(BuildContext context, List<StudentModel> students) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ScannerCubit>(),
        child: ScannedStudentsBottomSheet(students: students),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const ScannedStudentsHandle(),
          ScannedStudentsHeader(studentsCount: students.length),
          Expanded(
            child: students.isEmpty
                ? const ScannedStudentsEmptyState()
                : _buildStudentsList(context),
          ),
          ScannedStudentsSubmitButton(studentsCount: students.length),
        ],
      ),
    );
  }

  Widget _buildStudentsList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return ScannedStudentListItem(
          student: student,
          index: index,
          onDismissed: () {
            context.read<ScannerCubit>().removeStudentFromBatch(
              student.studentId!,
            );
          },
        );
      },
    );
  }
}
