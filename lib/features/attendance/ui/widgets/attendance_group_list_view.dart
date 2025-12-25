import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/custom_group_separator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

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
