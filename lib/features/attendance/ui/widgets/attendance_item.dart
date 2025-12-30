import 'package:animate_do/animate_do.dart';
import 'package:david_psalmist/core/model/attendance_model/attendance_model.dart';
import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/attendance/ui/widgets/edit_lessons_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../manager/cubit/attendance_cubit.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({
    super.key,
    required this.attendance,
    required this.studentModel,
  });

  final AttendanceModel attendance;
  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(attendance.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => _showDeleteConfirmation(context),
      onDismissed: (direction) => _handleDismiss(context),
      background: _buildDismissBackground(),
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
              leading: _buildLeadingIcon(),
              title: Text(
                _formatDate(attendance.date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: _buildSubtitle(),
              trailing: _buildTrailingButtons(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsTheme().primaryColor, ColorsTheme().primaryDark],
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
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getDayName(attendance.date),
          style: TextStyle(
            fontSize: 13,
            color: ColorsTheme().primaryDark.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${'Lessons attended'.tr()}: ${attendance.lessonsAttended}/3',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ColorsTheme().primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailingButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _showEditDialog(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsTheme().primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorsTheme().primaryColor, width: 1),
              ),
              child: Icon(
                Icons.edit_rounded,
                color: ColorsTheme().primaryColor,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FadeInLeft(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ColorsTheme().successColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: ColorsTheme().successColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete, color: Colors.white, size: 32),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'.tr()),
          content: Text(
            'Are you sure you want to delete this attendance record?'.tr(),
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
  }

  void _handleDismiss(BuildContext context) {
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
  }

  void _showEditDialog(BuildContext context) {
    showEditLessonsDialog(
      context: context,
      attendance: attendance,
      studentModel: studentModel,
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }

  String _getDayName(DateTime date) {
    return DateFormat('EEEE', 'ar').format(date);
  }
}
