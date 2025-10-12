import 'package:david_psalmist/core/theme/app_style.dart';
import 'package:david_psalmist/core/utils/colors.dart';
import 'package:david_psalmist/features/attendance/manager/cubit/attendance_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'attendance_group_list_view.dart';

class AttendanceBodyView extends StatelessWidget {
  const AttendanceBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        var attendanceRecords = context
            .read<AttendanceCubit>()
            .attendanceRecords;
        if (state is AttendanceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AttendanceLoaded) {
          if (attendanceRecords.isEmpty) {
            return Center(
              child: Text(
                'No attendance records found.'.tr(),
                style: AppTextStyles.styleBold20sp(
                  context,
                ).copyWith(color: ColorsTheme().primaryDark),
              ),
            );
          }
          return AttendanceGroupListView(attendanceRecords: attendanceRecords);
        } else {
          return AttendanceGroupListView(attendanceRecords: attendanceRecords);
        }
      },
    );
  }
}
