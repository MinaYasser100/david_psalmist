import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/lesson_count_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/cubit/attendance_cubit.dart';

void showEditLessonsDialog({
  required BuildContext context,
  required AttendanceModel attendance,
  required StudentModel studentModel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Edit Lessons'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How many lessons did the student attend?'.tr(),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LessonCountButton(
                  lessonsCount: 0,
                  isSelected: attendance.lessonsAttended == 0,
                  onTap: () => _updateLessons(
                    context: dialogContext,
                    attendance: attendance,
                    studentModel: studentModel,
                    lessonsCount: 0,
                  ),
                ),
                LessonCountButton(
                  lessonsCount: 1,
                  isSelected: attendance.lessonsAttended == 1,
                  onTap: () => _updateLessons(
                    context: dialogContext,
                    attendance: attendance,
                    studentModel: studentModel,
                    lessonsCount: 1,
                  ),
                ),
                LessonCountButton(
                  lessonsCount: 2,
                  isSelected: attendance.lessonsAttended == 2,
                  onTap: () => _updateLessons(
                    context: dialogContext,
                    attendance: attendance,
                    studentModel: studentModel,
                    lessonsCount: 2,
                  ),
                ),
                LessonCountButton(
                  lessonsCount: 3,
                  isSelected: attendance.lessonsAttended == 3,
                  onTap: () => _updateLessons(
                    context: dialogContext,
                    attendance: attendance,
                    studentModel: studentModel,
                    lessonsCount: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'.tr()),
          ),
        ],
      );
    },
  );
}

void _updateLessons({
  required BuildContext context,
  required AttendanceModel attendance,
  required StudentModel studentModel,
  required int lessonsCount,
}) {
  final updatedAttendance = attendance.copyWith(lessonsAttended: lessonsCount);
  context.read<AttendanceCubit>().updateAttendanceLessons(
    studentModel: studentModel,
    attendanceModel: updatedAttendance,
  );
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Lessons updated successfully'.tr()),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
