import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/custom_group_separator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../manager/cubit/attendance_cubit.dart';

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
      itemBuilder: (context, attendance) => Dismissible(
        key: Key(attendance.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete'.tr()),
                content: Text(
                  'Are you sure you want to delete this attendance record?'
                      .tr(),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'.tr()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'.tr()),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          context.read<AttendanceCubit>().deleteAttendanceRecord(
            studentModel: studentModel,
            attendanceModel: attendance,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Attendance record deleted successfully'.tr()),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white, size: 32),
        ),
        child: FadeInRight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsTheme().primaryColor.withValues(alpha: 0.1),
                    ColorsTheme().primaryDark.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColorsTheme().primaryDark.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsTheme().primaryColor,
                        ColorsTheme().primaryDark,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: Text(
                  _formatDate(attendance.date),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  _getDayName(attendance.date),
                  style: TextStyle(
                    fontSize: 13,
                    color: ColorsTheme().primaryDark.withValues(alpha: 0.6),
                  ),
                ),
                trailing: FadeInLeft(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorsTheme().successColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: ColorsTheme().successColor,
                      size: 28,
                    ),
                  ),
                ),
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

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }

  String _getDayName(DateTime date) {
    return DateFormat('EEEE', 'ar').format(date);
  }
}
