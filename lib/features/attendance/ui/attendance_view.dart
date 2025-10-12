import 'package:david_psalmist/core/model/student_model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubit/attendance_cubit.dart';
import 'widgets/attendance_body_view.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key, required this.studentModel});
  final StudentModel studentModel;

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  @override
  void initState() {
    context.read<AttendanceCubit>().fetchAttendanceRecords(
      studentModel: widget.studentModel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.studentModel.firstName} ${widget.studentModel.lastName}',
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: AttendanceBodyView(),
    );
  }
}
