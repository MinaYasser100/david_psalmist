import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/custom_group_separator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class AttendanceGroupListView extends StatelessWidget {
  const AttendanceGroupListView({super.key, required this.attendanceRecords});

  final List<AttendanceModel> attendanceRecords;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<AttendanceModel, DateTime>(
      elements: attendanceRecords,
      groupBy: (attendance) =>
          DateTime(attendance.date.year, attendance.date.month),
      groupSeparatorBuilder: (DateTime groupByValue) =>
          CustomGroupSeparator(groupByValue: groupByValue),
      itemBuilder: (context, attendance) => FadeInRight(
        child: FadeInRight(
          child: ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: ColorsTheme().primaryDark,
            ),
            title: Text(
              attendance.date.toString().split(' ')[0],
              style: const TextStyle(fontSize: 16),
            ),
            trailing: FadeInLeft(
              child: Icon(
                Icons.check_circle,
                color: ColorsTheme().successColor,
              ),
            ),
          ),
        ),
      ),
      itemComparator: (item1, item2) => item1.date.compareTo(item2.date),
      useStickyGroupSeparators: true,
      floatingHeader: true,
      order: GroupedListOrder.DESC,
    );
  }
}
