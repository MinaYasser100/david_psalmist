import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/attendance_item.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/custom_group_separator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class AttendanceGroupListView extends StatelessWidget {
  const AttendanceGroupListView({
    super.key,
    required this.attendanceRecords,
    required this.studentModel,
  });

  final List<AttendanceModel> attendanceRecords;
  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<AttendanceModel, DateTime>(
      elements: attendanceRecords,
      groupBy: (attendance) =>
          DateTime(attendance.date.year, attendance.date.month),
      groupSeparatorBuilder: (DateTime groupByValue) =>
          CustomGroupSeparator(groupByValue: groupByValue),
      itemBuilder: (context, attendance) =>
          AttendanceItem(attendance: attendance, studentModel: studentModel),
      itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.DESC,
    );
  }
}
